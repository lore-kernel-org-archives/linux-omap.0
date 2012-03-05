From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix module build errors with
 CONFIG_OMAP4_ERRATA_I688
Date: Mon, 5 Mar 2012 14:18:35 -0800
Message-ID: <20120305221835.GB12083@atomide.com>
References: <1330686078-9478-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:46583 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab2CEWSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:18:37 -0500
Content-Disposition: inline
In-Reply-To: <1330686078-9478-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

* R Sricharan <r.sricharan@ti.com> [120302 02:29]:
> While building modules with randconfig the below errors are observed.
> 
> ERROR: "omap_bus_sync" [drivers/watchdog/sp805_wdt.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/watchdog/dw_wdt.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/virtio/virtio_ring.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/video/sm501fb.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/mon/usbmon.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/sl811-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/ohci-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp1760.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp1362-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp116x-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/core/usbcore.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/altera_uart.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/altera_jtaguart.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/8250/8250_dw.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/ssb/ssb.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/rtc/rtc-cmos.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/rtc/rtc-bq4802.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/mtd/nand/tmio_nand.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/mtd/nand/omap2.ko] undefined!

Thanks applying into fixes.

Regards,

Tony
