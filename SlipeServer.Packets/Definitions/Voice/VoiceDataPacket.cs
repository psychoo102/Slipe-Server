﻿using System.Diagnostics.Contracts;
using System.Linq;
using System.Runtime.Serialization;
using SlipeServer.Packets.Builder;
using SlipeServer.Packets.Enums;
using SlipeServer.Packets.Reader;
using System.Text;

namespace SlipeServer.Packets.Definitions.Voice
{
    public class VoiceDataPacket : Packet
    {
        public override PacketId PacketId { get; } = PacketId.PACKET_ID_VOICE_DATA;
        public override PacketReliability Reliability { get; } = PacketReliability.ReliableSequenced;
        public override PacketPriority Priority { get; } = PacketPriority.Low;

        public byte[]? Buffer { get; set; }
        public uint SourceElementId { get; set; }

        public VoiceDataPacket(uint sourceElementId, byte[]? buffer)
        {
            this.Buffer = buffer;
            this.SourceElementId = sourceElementId;
        }

        public VoiceDataPacket()
        {
            
        }

        public override byte[] Write()
        {
            var builder = new PacketBuilder();

            builder.WriteElementId(this.SourceElementId);

            builder.Write((ushort)this.Buffer!.Length);

            builder.Write(Encoding.Default.GetString(this.Buffer));

            return builder.Build();
        }

        public override void Read(byte[] bytes)
        {
            var reader = new PacketReader(bytes);

            this.Buffer = reader.GetBytes(bytes.Length);
        }
    }
}