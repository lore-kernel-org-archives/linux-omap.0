From: Paul Walmsley <paul@pwsan.com>
Subject: Re: State of LDP3430 platform
Date: Tue, 7 Dec 2010 20:40:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com> <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58150 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0LHDkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 22:40:12 -0500
In-Reply-To: <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Tue, 7 Dec 2010, Paul Walmsley wrote:

> I do have a LDP3430 here though.  It doesn't boot past:
> 
> [    0.000000] Linux version 2.6.37-rc5 (paul@twilight) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #68 SMP Tue Dec 7 17:42:20
> [    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] Machine: OMAP Zoom2 board
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
> [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
> 
> Looking into it now.

My Zoom2 dies in the memset() in omap2_map_sram().  Not sure why, since 
yours seems to make it quite a bit further.  It dies in the same place 
with 2.6.36.  The Zoom2 here may be broken; it does not receive regular 
use.

Regarding the watchdog problem, unfortunately, I can't reproduce on the 
BeagleBoard with v2.6.37-rc5 with either omap2plus_defconfig or 
omap2plus_defconfig without CONFIG_WATCHDOG.  If you send along your 
.config, one of us can try to reproduce the problem with it.  Do the 
2.6.38 hwmod and wdt patchsets fix the problem for .38, at least?


- Paul
