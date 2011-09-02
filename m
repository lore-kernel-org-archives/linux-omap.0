From: Marc Dietich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Fri, 2 Sep 2011 13:13:37 +0200
Message-ID: <201109021313.38224.marvin24@gmx.de>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com> <201109011313.42547.marvin24@gmx.de> <74CDBE0F657A3D45AFBB94109FB122FF04B327A383@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A383-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

just another measurement point

> Stephen Warren wrote at Thursday:
>
> Here are the results I found:
> 
> Harmony:
> Tegra USB3 -> SMSC9514 hub: NOT affected
> (Unplugging LAN cable, or disabling SMSC9514 LAN driver doesn't change
> this)
> 
> Seaboard (springbank; clamshell):
> Tegra USB1 -> no hub: Affected
> 
> Seaboard (seaboard non-clamshell):
> Tegra USB1 -> no hub: Affected
> Tegra USB3 -> no hub: Affected
> 
> TrimSlice:
> Tegra USB3 -> unknown hub: Affected

PAZ00:
ULPI -> SMCS 2512: Affected
Tegra USB3 -> SMSC 2514: Affected

The patch also cures high latencies/packet drops on wifi connected to ULPI via 
the 2512 hub. The pen drive was connected to USB3/2514.

> This implies there's something different about Harmony.
> 
> Is the USB hub a clue? Seaboard doesn't have one, and although I don't
> know what model TrimSlice uses, I assume it's different since I know
> TrimSlice's Ethernet is not the same as Harmony's.
> 
> I don't see anything in board-harmony.c vs. board-seaboard.c that'd affect
> anything USB-related.
> 
> Perhaps there's some kind of bootloader or BCT difference. However, my
> Harmony and both Seaboards both use (a very old) U-Boot and BCT from
> ChromeOS, so I don't imagine there's actually much difference there.
