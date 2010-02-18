From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 01/12] DSPBRIDGE: global bridge device
Date: Thu, 18 Feb 2010 15:37:52 -0600
Message-ID: <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46717 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab0BRVZ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:27 -0500
In-Reply-To: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch declares and externs a pointer to a bridge device
to be used with dev_dbg.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/host_os.h |    1 +
 drivers/dsp/bridge/rmgr/drv_interface.c        |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 066c4d7..8cc1c6f 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -68,6 +68,7 @@ struct dspbridge_platform_data {
 #define PRCM_VDD1 1
 
 extern struct platform_device *omap_dspbridge_dev;
+extern struct device *bridge;
 
 #if defined(CONFIG_MPU_BRIDGE) || defined(CONFIG_MPU_BRIDGE_MODULE)
 extern void dspbridge_reserve_sdram(void);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index cff2877..cadb670 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -75,6 +75,7 @@
 s32 dsp_debug;
 
 struct platform_device *omap_dspbridge_dev;
+struct device *bridge;
 
 /* This is a test variable used by Bridge to test different sleep states */
 s32 dsp_test_sleepstate;
@@ -229,6 +230,9 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	omap_dspbridge_dev = pdev;
 
+	/* Global bridge device */
+	bridge = &omap_dspbridge_dev->dev;
+
 	/* use 2.6 device model */
 	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
 	if (result < 0) {
-- 
1.6.2.4

