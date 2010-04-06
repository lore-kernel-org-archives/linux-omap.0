From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: remove unused module parameters
Date: Tue, 6 Apr 2010 12:52:47 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CAF98C63@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44670 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab0DFRwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:52:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 0923c8f7c0cca3a2d308d673092adcc4de74088b Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Sat, 27 Mar 2010 02:01:20 -0600
Subject: [PATCH] DSPBRIDGE: remove unused module parameters

This patch removes unused module parameters:
-phys_mempool_base
-phys_mempool_base

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 5f01ab9..3d22f8c 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -88,8 +88,6 @@ static s32 driver_major;
 static char *base_img;
 char *iva_img;
 static s32 shm_size = 0x500000;	/* 5 MB */
-static u32 phys_mempool_base;
-static u32 phys_mempool_size;
 static int tc_wordswapon;	/* Default value is always false */
 #ifdef CONFIG_BRIDGE_RECOVERY
 #define REC_TIMEOUT 5000	/*recovery timeout in msecs */
@@ -133,13 +131,6 @@ MODULE_PARM_DESC(base_img, "DSP base image, default = NULL");
 module_param(shm_size, int, 0);
 MODULE_PARM_DESC(shm_size, "shm size, default = 4 MB, minimum = 64 KB");
 
-module_param(phys_mempool_base, uint, 0);
-MODULE_PARM_DESC(phys_mempool_base,
-		 "Physical memory pool base passed to driver");
-
-module_param(phys_mempool_size, uint, 0);
-MODULE_PARM_DESC(phys_mempool_size,
-		 "Physical memory pool size passed to driver");
 module_param(tc_wordswapon, int, 0);
 MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
 
@@ -316,18 +307,9 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	}
 	dev_dbg(bridge, "%s: requested shm_size = 0x%x\n", __func__, shm_size);
 
-	if (pdata->phys_mempool_base && pdata->phys_mempool_size) {
-		phys_mempool_base = pdata->phys_mempool_base;
-		phys_mempool_size = pdata->phys_mempool_size;
-	}
-
-	dev_dbg(bridge, "%s: phys_mempool_base = 0x%x \n", __func__,
-		phys_mempool_base);
-
-	dev_dbg(bridge, "%s: phys_mempool_size = 0x%x\n", __func__,
-		phys_mempool_base);
-	if ((phys_mempool_base > 0x0) && (phys_mempool_size > 0x0))
-		mem_ext_phys_pool_init(phys_mempool_base, phys_mempool_size);
+	if ((pdata->phys_mempool_base > 0) && (pdata->phys_mempool_size > 0))
+		mem_ext_phys_pool_init(pdata->phys_mempool_base,
+						pdata->phys_mempool_size);
 	if (tc_wordswapon) {
 		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
 		reg_set_value(TCWORDSWAP, (u8 *) &tc_wordswapon,
-- 
1.6.0.4

