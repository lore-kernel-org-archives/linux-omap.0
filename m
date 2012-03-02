From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix module build errors with CONFIG_OMAP4_ERRATA_I688
Date: Fri, 2 Mar 2012 16:31:18 +0530
Message-ID: <1330686078-9478-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2CBLB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 06:01:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, santosh.shilimkar@ti.com

While building modules with randconfig the below errors are observed.

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

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index ebc5950..70de277 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -31,6 +31,7 @@
 
 #include "common.h"
 #include "omap4-sar-layout.h"
+#include <linux/export.h>
 
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
@@ -55,6 +56,7 @@ void omap_bus_sync(void)
 		isb();
 	}
 }
+EXPORT_SYMBOL(omap_bus_sync);
 
 /* Steal one page physical memory for barrier implementation */
 int __init omap_barrier_reserve_memblock(void)
-- 
1.7.1

