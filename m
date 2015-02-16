From: Tony Lindgren <tony@atomide.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Mon, 16 Feb 2015 09:58:26 -0800
Message-ID: <20150216175826.GT2531@atomide.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery1.ore.mailhop.org ([54.149.155.156]:49582 "EHLO
	pmta2.delivery1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753490AbbBPSDC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Feb 2015 13:03:02 -0500
Received: from smtp1.ore.mailhop.org (172.31.36.112) by pmta2.delivery1.ore.mailhop.org id hs8oe620u50c for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2015 18:03:14 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matthijs van Duin <matthijsvanduin@gmail.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

* Grazvydas Ignotas <notasas@gmail.com> [150215 13:34]:
> Hi,
> 
> Does anyone know if there is a way to make DBGEN signal high on
> OMAP3530 and/or DM3730 without using a hardware debugger? My goal is
> to make use of hardware watchpoints in Cortex-A8, but that requires
> DBGEN to be high.
> 
> The TRM states:
> "The DBGEM signal on the Cortex-A8 is driven by setting bit 13 at
> address 0x5401 D030 in the DAP-APB address space."
> However regardless of how hard I try the writes to that register seem
> to be ignored. I even tried to do it from IVA/C64x with no success.
> (I assume DBGEM is a typo since Cortex-A8 manuals have no mention of
> it, and they meant DBGEN there).
> 
> It seems others had this problem too, and TI is as helpful as ever:
> http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/30011/104527
> 
> DBGEN is mentioned by Will Deacon's commit
> 8954bb0da99b76c7ce5edf2f314807cff68b6ea8 , but I guess he mixed NIDEN
> with DBGEN there (DBGAUTHSTATUS returns 0x000000ae so NIDEN is indeed
> set here, and I have tried old kernel where OMAP3_EMU was still
> available).

Does the perf counter still work OK? Looks like OMAP3_EMU got
removed by commit 184901a06a36 ("ARM: removing support for etb/etm in
"arch/arm/kernel/"").

The perf counter on omap3 used to work, but is buggy at least on
3430 because it eventually stops producing interrupts because of
some bug in the Cortex-A8 version being used.

Looking at the commits it seems that it probably only works for
device tree based booting nowadays.

Also, it seems that having the etm@54010000, etb@540000000
and etb@5401b000 entries only in the omap3-beagle*.dts files
is wrong. To me it seems they should be in the omap3.dtsi and
omap36xx.dtsi instead. Looks like those got added by commit
9d31620268a7 ("coresight: adding support for beagle and beagleXM").

So maybe moving  the etb and etm entries to omap3.dtsi and
omap36xx.dtsi is all you need with the current mainline kernel?
 
> 0x5401D030 is referenced by some OpenOCD scripts, so I guess it's
> writeable over jtag, but not by the CPU(s). It's quite a mysterious
> otherwise undocumented register, I've noticed it's bit21 is some
> status bit related to Cortex-A8's low power states.

Have you checked the Cortex-A8 documentation for the debugger?
It seems that's where they should be documented.

Regards,

Tony
