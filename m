From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] Initial multi-omap support for omap4
Date: Mon, 1 Feb 2010 11:11:41 -0800
Message-ID: <20100201191140.GA22747@atomide.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EC6@dbde02.ent.ti.com>
 <20100130162441.GQ23505@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EF8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55738 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab0BATLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 14:11:19 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EF8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100130 09:52]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Saturday, January 30, 2010 9:55 PM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 0/9] Initial multi-omap support for omap4
> > 
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100130 04:49]:
> > > > > Hi all,
> > > > >
> > > > > These patches allow compiling in also omap4 into the multi-omap
> > > > > configuration. As I don't yet have omap4, I've only boot tested
> > > > > these on omap2 and omap3.
> > > > >
> > > > > Somebody with an omap4 board please boot test these with the
> > > > > omap3_defconfig and see what happens.. You might want to enable
> > > > > DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.
> > > > Looks like this series have some dependent series because it doesn't
> > > > apply on mainline.
> > > >
> > > > So I tested this directly on linux-omap "multi-omap4" branch. It boots sufficiently
> > > > but doesn't proceed after "brd_init". Didn't get much time to debug so attached log
> > >
> > > Stand alone omap_4430sdp_defconfig also didn't fully boot on the linux-omap "multi-omap4".
> > > The log below shows that the serial platform data isn't configured correctly.
> > >
> > > <6>io scheduler deadline registered
> > > <6>io scheduler cfq registered (default)
> > > <6>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > > <6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 104) is a ST16654
> > > <6>serial8250.1: ttyS0 at MMIO 0x4806a000 (irq = 105) is a ST16654
> > >
> > > Below patch to fix the boot for omap_4430sdp_defconfig. Small typo really.
> > >
> > > diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/inclu
> > > index 67ffa08..83dce4c 100644
> > > --- a/arch/arm/plat-omap/include/plat/serial.h
> > > +++ b/arch/arm/plat-omap/include/plat/serial.h
> > > @@ -33,7 +33,7 @@
> > >
> > >  /* OMAP4 serial ports */
> > >  #define OMAP4_UART1_BASE       OMAP2_UART1_BASE
> > > -#define OMAP4_UART2_BASE       OMAP2_UART1_BASE
> > > +#define OMAP4_UART2_BASE       OMAP2_UART2_BASE
> > >  #define OMAP4_UART3_BASE       0x48020000
> > >  #define OMAP4_UART4_BASE       0x4806e000

I've refreshed the second patch in the earlier multi-omap series
with your fix above.
 
> > Heh OK :) Sounds like at this point it makes sense to merge
> > that into the original patch redo omap-for-linus partially.
> > 
> > Can I also add your Acked-by for these patches then?
> Yes please.

OK, added your Acked-by to all the omap4 patches. Also fixed
three checkpatch.pl warnings about long lines for the gpio patch.

> > > For multi-omap build, for now I need to disable
> > > [*] Reset unused clocks during boot
> > 
> > Sounds like omap4 has some clocks left on from the bootloader
> > that it should clk_get and clk_enable during init. That should
> > be easy to track if you boot with "debug" in your cmdline and
> > take a look at the list of unused clocks that are shut down
> > with late_initcall.
> I know it hangs when it tries to cut down UART3 ( console) clock.
> The clock support got just recently merged and drivers are not 
> yet migrated so, need to still depend on bootloader. The work 
> is ongoing and soon the patches will be pushed. Few drivers
> are planned to be handled in hwmod way so we were holding these
> patches. 

OK

Tony
