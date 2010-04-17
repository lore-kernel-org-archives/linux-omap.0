From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 4/5] DSPBRIDGE: Remove handles from registry
Date: Fri, 16 Apr 2010 22:34:08 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76409@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51803 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQDeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:34:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 874bc262b47319b311d14ca32a7c1afb9eb388e8 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Thu, 1 Apr 2010 00:17:24 -0600
Subject: [PATCH 4/5] DSPBRIDGE: Remove handles from registry

Remove handles from registry.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |    3 +
 drivers/dsp/bridge/services/cfg.c          |   59 +++++++++++++++++----------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 210ca68..f505b21 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -128,6 +128,9 @@ struct drv_data {
 	char *base_img;
 	s32 shm_size;
 	int tc_wordswapon;
+	void *drv_object;
+	void *dev_object;
+	void *mgr_object;
 };
 
 /* Process Context */
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 8f9f84c..8e2d614 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -82,6 +82,10 @@ dsp_status cfg_get_dev_object(struct cfg_devnode *dev_node_obj,
 {
 	dsp_status status = DSP_SOK;
 	u32 dw_buf_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+
+	if (!drv_datap)
+		status = DSP_EFAIL;
 
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
@@ -92,14 +96,12 @@ dsp_status cfg_get_dev_object(struct cfg_devnode *dev_node_obj,
 	dw_buf_size = sizeof(pdwValue);
 	if (DSP_SUCCEEDED(status)) {
 
-		/* check the device string and then call the reg_set_value */
+		/* check the device string and then store dev object */
 		if (!
 		    (strcmp
 		     ((char *)((struct drv_ext *)dev_node_obj)->sz_string,
 		      "TIOMAP1510")))
-			status =
-			    reg_get_value("DEVICE_DSP", (u8 *) pdwValue,
-					  &dw_buf_size);
+			*pdwValue = (u32)drv_datap->dev_object;
 	}
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
@@ -144,23 +146,31 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 dsp_status cfg_get_object(OUT u32 *pdwValue, u32 dw_type)
 {
 	dsp_status status = DSP_EINVALIDARG;
-	u32 dw_buf_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+
 	DBC_REQUIRE(pdwValue != NULL);
 
-	dw_buf_size = sizeof(pdwValue);
+	if (!drv_datap)
+		return DSP_EFAIL;
+
 	switch (dw_type) {
 	case (REG_DRV_OBJECT):
-		status =
-		    reg_get_value(DRVOBJECT, (u8 *) pdwValue, &dw_buf_size);
-		if (DSP_FAILED(status))
+		if (drv_datap->drv_object) {
+			*pdwValue = (u32)drv_datap->drv_object;
+			status = DSP_SOK;
+		} else {
 			status = CFG_E_RESOURCENOTAVAIL;
+		}
 		break;
 	case (REG_MGR_OBJECT):
-		status =
-		    reg_get_value(MGROBJECT, (u8 *) pdwValue, &dw_buf_size);
-		if (DSP_FAILED(status))
+		if (drv_datap->mgr_object) {
+			*pdwValue = (u32)drv_datap->mgr_object;
+			status = DSP_SOK;
+		} else {
 			status = CFG_E_RESOURCENOTAVAIL;
+		}
 		break;
+
 	default:
 		break;
 	}
@@ -191,18 +201,21 @@ bool cfg_init(void)
 dsp_status cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 dwValue)
 {
 	dsp_status status = DSP_SOK;
-	u32 dw_buff_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+
+	if (!drv_datap) {
+		pr_err("%s: Failed, status 0x%x\n", __func__, status);
+		return DSP_EFAIL;
+	}
 
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
 
-	dw_buff_size = sizeof(dwValue);
 	if (DSP_SUCCEEDED(status)) {
 		/* Store the WCD device object in the Registry */
 
 		if (!(strcmp((char *)dev_node_obj, "TIOMAP1510"))) {
-			status = reg_set_value("DEVICE_DSP", (u8 *) &dwValue,
-					       dw_buff_size);
+			drv_datap->dev_object = (void *) dwValue;
 		}
 	}
 	if (DSP_FAILED(status))
@@ -219,17 +232,19 @@ dsp_status cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 dwValue)
 dsp_status cfg_set_object(u32 dwValue, u32 dw_type)
 {
 	dsp_status status = DSP_EINVALIDARG;
-	u32 dw_buff_size;
+	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+
+	if (!drv_datap)
+		return DSP_EFAIL;
 
-	dw_buff_size = sizeof(dwValue);
 	switch (dw_type) {
 	case (REG_DRV_OBJECT):
-		status =
-		    reg_set_value(DRVOBJECT, (u8 *) &dwValue, dw_buff_size);
+		drv_datap->drv_object = (void *)dwValue;
+		status = DSP_SOK;
 		break;
 	case (REG_MGR_OBJECT):
-		status =
-		    reg_set_value(MGROBJECT, (u8 *) &dwValue, dw_buff_size);
+		drv_datap->mgr_object = (void *)dwValue;
+		status = DSP_SOK;
 		break;
 	default:
 		break;
-- 
1.5.4.5

