﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SlipeServer.Packets.Enums;

public enum ScreenshotStatus : byte
{
    Unknown,
    Success,
    Minimalized,
    Disabled,
    Error,
}
