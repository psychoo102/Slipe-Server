﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using SlipeServer.Packets;
using SlipeServer.Packets.Definitions.Lua;
using SlipeServer.Packets.Definitions.Ped;
using SlipeServer.Packets.Enums;
using SlipeServer.Server.Elements;
using SlipeServer.Server.Events;
using SlipeServer.Server.Extensions;
using SlipeServer.Server.Repositories;

namespace SlipeServer.Server.PacketHandling.QueueHandlers
{
    public class PedSyncQueueHandler : WorkerBasedQueueHandler
    {
        private readonly ILogger logger;
        private readonly IElementRepository elementRepository;
        private readonly Configuration configuration;

        public override IEnumerable<PacketId> SupportedPacketIds => this.PacketTypes.Keys;
        protected override Dictionary<PacketId, Type> PacketTypes { get; } = new Dictionary<PacketId, Type>() {
            [PacketId.PACKET_ID_PED_SYNC] = typeof(PedSyncPacket),
            [PacketId.PACKET_ID_PED_TASK] = typeof(PedTaskPacket),
            [PacketId.PACKET_ID_PED_WASTED] = typeof(PedWastedPacket),
            [PacketId.PACKET_ID_PED_STARTSYNC] = typeof(PedStartSyncPacket),
            [PacketId.PACKET_ID_PED_STOPSYNC] = typeof(PedStopSyncPacket),
        };

        public PedSyncQueueHandler(ILogger logger, IElementRepository elementRepository, Configuration configuration, int sleepInterval = 10, int workerCount = 1) : base(sleepInterval, workerCount)
        {
            this.logger = logger;
            this.elementRepository = elementRepository;
            this.configuration = configuration;
        }

        protected override void HandlePacket(Client client, Packet packet)
        {
            try
            {
                switch (packet)
                {
                    case PedSyncPacket pedSyncPacket:
                        this.HandlePedSyncPacket(client, pedSyncPacket);
                        break;
                }
            }
            catch (Exception e)
            {
                this.logger.LogError($"Handling packet ({packet.PacketId}) failed.\n{e.Message}");
            }
        }

        private void OverrideSyncer(Ped ped, Player player)
        {
            var currentSyncer = ped.Syncer;
            if (currentSyncer != null)
            {
                if (currentSyncer != player)
                {
                    StopSync(ped);
                }
            }

            if (player != null && ped != null)
            {
                StartSync(player, ped);
            }
        }

        private void Update()
        {
            IEnumerable<Ped> allPeds = this.elementRepository.GetByType<Ped>(ElementType.Ped).Where(ped =>
                !(ped is Player)).ToArray();

            foreach (var ped in allPeds)
            {
                UpdatePed(ped);
            }
        }

        private void UpdatePed(Ped ped)
        {
            Player? syncer = ped.Syncer;

            if (!ped.IsSyncable)
            {
                if (syncer != null)
                {
                    StopSync(ped);
                }
            } else
            {
                if (syncer != null)
                {
                    if (Vector3.Distance(syncer.Position, ped.Position) < this.configuration.SyncIntervals.PedSyncerDistance || (ped.Dimension != syncer.Dimension))
                    {
                        StopSync(ped);

                        if (ped != null)
                        {
                            FindSyncer(ped);
                        }
                    } else
                    {
                        FindSyncer(ped);
                    }
                }
            }
        }

        private void FindSyncer(Ped ped)
        {
            if (ped.IsSyncable)
            {
                Player? player = FindPlayerCloseToPed(ped, this.configuration.SyncIntervals.PedSyncerDistance);
                if (player != null)
                {
                    StartSync(player, ped);
                }
            }
        }

        private void StartSync(Player player, Ped ped)
        {
            if (ped.IsSyncable)
            {
                player.Client.SendPacket(new PedStartSyncPacket(ped.Id));

                ped.Syncer = player;
            }
        }

        private void StopSync(Ped ped)
        {
            var syncer = ped.Syncer;
            syncer?.Client.SendPacket(new PedStopSyncPacket(ped.Id));

            ped.Syncer = null;
        }

        private Player? FindPlayerCloseToPed(Ped ped, float maxDistance)
        {
            Player? lastPlayerSyncing = null;

            var allPlayers = this.elementRepository
                .GetWithinRange<Player>(ped.Position, maxDistance, ElementType.Player)
                .Where(x => x.Dimension == ped.Dimension)
                .ToArray();

            foreach (Player thePlayer in allPlayers)
            {
                if (lastPlayerSyncing != null ||
                    thePlayer.SyncingPeds.Count < lastPlayerSyncing?.SyncingPeds.Count)
                {
                        lastPlayerSyncing = thePlayer;
                }
            }

            return lastPlayerSyncing;
        }

        private void HandlePedSyncPacket(Client client, PedSyncPacket packet)
        {
            foreach (var syncData in packet.Syncs)
            {
                Ped pedElement = (Ped)this.elementRepository.Get(syncData.SourceElementId)!;

                if ((pedElement != null) && !(pedElement is Ped))
                {
                    pedElement.RunAsSync(() =>
                    {
                        if (pedElement.Syncer?.Client == client && pedElement.CanUpdateSync(syncData.TimeSyncContext))
                        {
                            if ((syncData.Flags & 0x01) != 0)
                            {
                                pedElement.Position = syncData.Position;
                            }
                            if ((syncData.Flags & 0x02) != 0)
                            {
                                pedElement.PedRotation = syncData.Rotation;
                            }
                            if ((syncData.Flags & 0x04) != 0)
                            {
                                pedElement.Velocity = syncData.Velocity;
                            }
                            if ((syncData.Flags & 0x08) != 0)
                            {
                                float previousHealth = pedElement.Health;
                                pedElement.Health = syncData.Health;
                            }

                            if ((syncData.Flags & 0x10) != 0)
                            {
                                pedElement.Armor = syncData.Armor;
                            }

                            if ((syncData.Flags & 0x20) != 0)
                            {
                                pedElement.IsOnFire = syncData.IsOnFire;
                            }

                            if ((syncData.Flags & 0x40) != 0)
                            {
                                pedElement.IsInWater = syncData.IsInWater;
                            }

                        }

                        var players = this.elementRepository.GetByType<Player>(ElementType.Player)
                            .Where(player => player.Client != client);

                        packet.SendTo(players);
                    });
                }
            }
        }

    }
}
