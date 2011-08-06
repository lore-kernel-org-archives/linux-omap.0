From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 7/9] OMAP: omap_device: _disable_idle_on_suspend() takes platform_device pointer
Date: Fri,  5 Aug 2011 17:19:23 -0700
Message-ID: <1312589965-19416-8-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:47644 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932306Ab1HFATj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:39 -0400
Received: by mail-yx0-f181.google.com with SMTP id 13so2316054yxi.12
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:38 -0700 (PDT)
In-Reply-To: <1312589965-19416-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org

Public omap_device functions need to take platform_device pointers,
conversion to omap_device pointers is done internal to the omap_device
layer.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/gpio.c                    |    2 +-
 arch/arm/mach-omap2/serial.c                  |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   13 ++++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 76abdcb..652ccc5 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -119,7 +119,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(pdev);
 	}
 
-	omap_device_disable_idle_on_suspend(od);
+	omap_device_disable_idle_on_suspend(pdev);
 
 	gpio_bank_count++;
 	return 0;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 53b6808..3d1c1d3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -805,7 +805,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
-	omap_device_disable_idle_on_suspend(od);
+	omap_device_disable_idle_on_suspend(pdev);
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
 	uart->irq = oh->mpu_irqs[0].irq;
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 750f401..4f98770 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,11 +116,6 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
-static inline void omap_device_disable_idle_on_suspend(struct omap_device *od)
-{
-	od->flags |= OMAP_DEVICE_NO_IDLE_ON_SUSPEND;
-}
-
 /*
  * Entries should be kept in latency order ascending
  *
@@ -153,4 +148,12 @@ struct omap_device_pm_latency {
 /* Get omap_device pointer from platform_device pointer */
 #define to_omap_device(x) container_of((x), struct omap_device, pdev)
 
+static inline
+void omap_device_disable_idle_on_suspend(struct platform_device *pdev)
+{
+	struct omap_device *od = to_omap_device(pdev);
+
+	od->flags |= OMAP_DEVICE_NO_IDLE_ON_SUSPEND;
+}
+
 #endif
-- 
1.7.6

