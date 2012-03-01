From: Tony Lindgren <tony@atomide.com>
Subject: Re: Randconfig module build error with OMAP4_ERRATA_I688
Date: Thu, 1 Mar 2012 08:25:56 -0800
Message-ID: <20120301162556.GY18901@atomide.com>
References: <20120229173719.GN18901@atomide.com>
 <CAMQu2gxg_57AVW+MT_Sgi+gr2OUge-YPdSUxoG+z-zQth=4-UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54157 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab2CAQZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 11:25:59 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxg_57AVW+MT_Sgi+gr2OUge-YPdSUxoG+z-zQth=4-UA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120301 00:38]:
> On Wed, Feb 29, 2012 at 11:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Santosh,
> >
> > Looks like OMAP4_ERRATA_I688 still has one more issue:
> > Modules won't build at least with the attached randconfig
> > generated file.
> >
> > Can you please take a look at how to deal with it?
> >
> > Maybe omap_bus_sync should be an inline function with some
> > wrapper for the sleep44xx.S to call?
> >
> > I already posted a fix for the GPMC related error with the
> > same .config file.
> >
> This one builds for me against 'Linux 3.3-rc5,
> Ofocurse I got below error with the attached .config which
> I bypassed to see the Errata build failure.
> 
> arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback':
> linux-2.6/arch/arm/mach-omap2/board-n8x0.c:374: undefined reference to
> `omap_mmc_notify_cover_event'
> make: *** [.tmp_vmlinux1] Error 1

Yes a fix for that has been queued already.
 
> I build this with below toolchain...
> $arm-none-linux-gnueabi-gcc --version
> arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2011.03-41) 4.5.2
> Copyright (C) 2010 Free Software Foundation, Inc.
> 
> Am I missing anything ?

I think you're missing your commit 2ec1fc4e169acc0b8d6733ff028fd52e766773d9
(ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve callback)
thats' queued up in fixes, and CONFIG_OMAP4_ERRATA_I688=y.

Then with -rc5 + 2ec1fc4e when you build modules you'll get this:

ERROR: "omap_bus_sync" [drivers/watchdog/sp805_wdt.ko] undefined!
ERROR: "omap_bus_sync" [drivers/watchdog/dw_wdt.ko] undefined!
ERROR: "omap_bus_sync" [drivers/virtio/virtio_ring.ko] undefined!
ERROR: "omap_bus_sync" [drivers/video/sm501fb.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/mon/usbmon.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/host/sl811-hcd.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/host/ohci-hcd.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/host/isp1760.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/host/isp1362-hcd.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/host/isp116x-hcd.ko] undefined!
ERROR: "omap_bus_sync" [drivers/usb/core/usbcore.ko] undefined!
ERROR: "omap_bus_sync" [drivers/tty/serial/altera_uart.ko] undefined!
ERROR: "omap_bus_sync" [drivers/tty/serial/altera_jtaguart.ko] undefined!
ERROR: "omap_bus_sync" [drivers/tty/serial/8250/8250_dw.ko] undefined!
ERROR: "omap_bus_sync" [drivers/ssb/ssb.ko] undefined!
ERROR: "omap_bus_sync" [drivers/rtc/rtc-cmos.ko] undefined!
ERROR: "omap_bus_sync" [drivers/rtc/rtc-bq4802.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/nand/tmio_nand.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/nand/omap2.ko] undefined!

ERROR: "gpmc_calculate_ecc" [drivers/mtd/nand/omap2.ko] undefined!
ERROR: "gpmc_enable_hwecc" [drivers/mtd/nand/omap2.ko] undefined!

For the two above I already posted a fix for.

ERROR: "omap_bus_sync" [drivers/mtd/nand/nand.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/nand/diskonchip.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/maps/map_funcs.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/devices/docprobe.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/devices/doc2001.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mtd/devices/doc2000.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mmc/host/sdhci.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mmc/host/sdhci-pxav3.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mmc/host/sdhci-pxav2.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mmc/host/dw_mmc.ko] undefined!
ERROR: "omap_bus_sync" [drivers/mfd/sm501.ko] undefined!
ERROR: "omap_bus_sync" [drivers/leds/leds-ot200.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/touchscreen/w90p910_ts.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/touchscreen/tsc2007.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/touchscreen/pixcir_i2c_ts.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/touchscreen/mk712.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/touchscreen/auo-pixcir-ts.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/serio/ambakmi.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/keyboard/matrix_keypad.ko] undefined!
ERROR: "omap_bus_sync" [drivers/input/keyboard/atkbd.ko] undefined!
ERROR: "omap_bus_sync" [drivers/i2c/busses/i2c-simtec.ko] undefined!
ERROR: "omap_bus_sync" [drivers/i2c/busses/i2c-pca-platform.ko] undefined!
ERROR: "omap_bus_sync" [drivers/i2c/busses/i2c-ocores.ko] undefined!
ERROR: "omap_bus_sync" [drivers/gpu/drm/drm.ko] undefined!
ERROR: "omap_bus_sync" [drivers/dma/dw_dmac.ko] undefined!
ERROR: "omap_bus_sync" [drivers/char/nvram.ko] undefined!
ERROR: "omap_bus_sync" [drivers/block/mg_disk.ko] undefined!
ERROR: "omap_bus_sync" [drivers/base/firmware_class.ko] undefined!

Regards,

Tony
