From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 1/7] OMAP3ISP: Preview: Abstraction layer updates
Date: Tue, 6 Jan 2009 14:41:51 -0600
Message-ID: <A24693684029E5489D1D202277BE89441632805E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59703 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZAFUl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:41:59 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06KfsbM004713
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:41:59 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06KfsdR007556
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:41:54 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 9e13b28b32bd793f042d431d41541262a491e891 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:19:08 -0600
Subject: [PATCH] OMAP3ISP: Preview: Abstraction layer updates

This patch fixes abstraction layer updates on stream off state.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isppreview.c |   89 ++++++++++++++++++++++++++++-----
 drivers/media/video/isp/isppreview.h |    5 ++
 2 files changed, 80 insertions(+), 14 deletions(-)
 mode change 100644 => 100755 drivers/media/video/isp/isppreview.c
 mode change 100644 => 100755 drivers/media/video/isp/isppreview.h

diff --git a/drivers/media/video/isp/isppreview.c b/drivers/media/video/isp/isppreview.c
old mode 100644
new mode 100755
index 6e157a2..4bd2ed5
--- a/drivers/media/video/isp/isppreview.c
+++ b/drivers/media/video/isp/isppreview.c
@@ -30,8 +30,10 @@
 #include "isppreview.h"
 
 static struct ispprev_nf prev_nf_t;
+static struct ispprev_csc prev_csc_t;
 static struct prev_params *params;
 static int RG_update, GG_update, BG_update, NF_enable, NF_update;
+static int CSC_update;
 
 /* Structure for saving/restoring preview module registers */
 static struct isp_reg ispprev_reg_list[] = {
@@ -181,9 +183,11 @@ static struct isp_prev {
 	u8 fmtavg;
 	u8 brightness;
 	u8 contrast;
+	int stream_on;
 	enum preview_color_effect color;
 	enum cfa_fmt cfafmt;
 	struct mutex ispprev_mutex; /* For checking/modifying prev_inuse */
+	spinlock_t ispprev_lock;
 	u32 sph;
 	u32 slv;
 } ispprev_obj;
@@ -252,7 +256,6 @@ int omap34xx_isp_preview_config(void *userspace_add)
 	struct ispprev_wbal prev_wbal_t;
 	struct ispprev_blkadj prev_blkadj_t;
 	struct ispprev_rgbtorgb rgb2rgb_t;
-	struct ispprev_csc prev_csc_t;
 	struct ispprev_yclimit yclimit_t;
 	struct ispprev_dcor prev_dcor_t;
 	struct ispprv_update_config *preview_struct;
@@ -375,8 +378,16 @@ int omap34xx_isp_preview_config(void *userspace_add)
 						(preview_struct->prev_csc),
 						sizeof(struct ispprev_csc)))
 			goto err_copy_from_user;
-		isppreview_config_rgb_to_ycbcr(prev_csc_t);
-	}
+		spin_lock(&ispprev_obj.ispprev_lock);
+		if (ispprev_obj.stream_on == 0) {
+			isppreview_config_rgb_to_ycbcr(prev_csc_t);
+			CSC_update = 0;
+		} else
+			CSC_update = 1;
+
+		spin_unlock(&ispprev_obj.ispprev_lock);
+	} else
+		CSC_update = 0;
 
 	if ((ISP_ABS_PREV_YC_LIMIT & preview_struct->update) ==
 		ISP_ABS_PREV_YC_LIMIT) {
@@ -440,6 +451,7 @@ EXPORT_SYMBOL(omap34xx_isp_preview_config);
  **/
 int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 {
+	int ctr;
 
 	if ((ISP_ABS_TBL_NF & isptables_struct->flag) == ISP_ABS_TBL_NF) {
 		NF_enable = 1;
@@ -450,8 +462,15 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 						(isptables_struct->prev_nf),
 						sizeof(struct ispprev_nf)))
 				goto err_copy_from_user;
-
-			NF_update = 1;
+			spin_lock(&ispprev_obj.ispprev_lock);
+			if (ispprev_obj.stream_on == 0) {
+				NF_update = 0;
+				isppreview_config_noisefilter(prev_nf_t);
+				isppreview_enable_noisefilter(NF_enable);
+			} else
+				NF_update = 1;
+
+			spin_unlock(&ispprev_obj.ispprev_lock);
 		} else
 			NF_update = 0;
 	} else {
@@ -470,7 +489,17 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 						sizeof(redgamma_table))) {
 			goto err_copy_from_user;
 		}
-		RG_update = 1;
+		spin_lock(&ispprev_obj.ispprev_lock);
+		if (ispprev_obj.stream_on == 0) {
+			omap_writel(ISPPRV_TBL_ADDR_RED_G_START,
+							ISPPRV_SET_TBL_ADDR);
+			for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++)
+				omap_writel(redgamma_table[ctr],
+							ISPPRV_SET_TBL_DATA);
+		} else
+			RG_update = 1;
+
+		spin_unlock(&ispprev_obj.ispprev_lock);
 	} else
 		RG_update = 0;
 
@@ -480,9 +509,19 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 						isptables_struct->green_gamma,
 						sizeof(greengamma_table)))
 			goto err_copy_from_user;
-		GG_update = 1;
+		spin_lock(&ispprev_obj.ispprev_lock);
+		if (ispprev_obj.stream_on == 0) {
+			omap_writel(ISPPRV_TBL_ADDR_GREEN_G_START,
+							ISPPRV_SET_TBL_ADDR);
+			for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++)
+				omap_writel(greengamma_table[ctr],
+						ISPPRV_SET_TBL_DATA);
+		} else
+			GG_update = 1;
+
+		spin_unlock(&ispprev_obj.ispprev_lock);
 	} else
-		GG_update = 0;
+		 GG_update = 0;
 
 	if ((ISP_ABS_TBL_BLUEGAMMA & isptables_struct->update) ==
 					ISP_ABS_TBL_BLUEGAMMA) {
@@ -491,9 +530,19 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 						sizeof(bluegamma_table))) {
 			goto err_copy_from_user;
 		}
-		BG_update = 1;
+		spin_lock(&ispprev_obj.ispprev_lock);
+		if (ispprev_obj.stream_on == 0) {
+			omap_writel(ISPPRV_TBL_ADDR_BLUE_G_START,
+							ISPPRV_SET_TBL_ADDR);
+			for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++)
+				omap_writel(bluegamma_table[ctr],
+						ISPPRV_SET_TBL_DATA);
+		} else
+			BG_update = 1;
+
+		spin_unlock(&ispprev_obj.ispprev_lock);
 	} else
-		BG_update = 0;
+		 BG_update = 0;
 
 	return 0;
 
@@ -534,13 +583,18 @@ void isppreview_config_shadow_registers()
 								color]);
 		update_color_matrix = 0;
 	}
-	if (GG_update || RG_update || BG_update || NF_update) {
+	if (GG_update || RG_update || BG_update || NF_update || CSC_update) {
 		isppreview_enable(0);
 		prv_disabled = 1;
 	}
 
+	if (CSC_update) {
+		isppreview_config_rgb_to_ycbcr(prev_csc_t);
+		CSC_update = 0;
+	}
+
 	if (GG_update) {
-		omap_writel(0x400, ISPPRV_SET_TBL_ADDR);
+		omap_writel(ISPPRV_TBL_ADDR_GREEN_G_START, ISPPRV_SET_TBL_ADDR);
 
 		for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++) {
 			omap_writel(greengamma_table[ctr],
@@ -550,7 +604,7 @@ void isppreview_config_shadow_registers()
 	}
 
 	if (RG_update) {
-		omap_writel(0, ISPPRV_SET_TBL_ADDR);
+		omap_writel(ISPPRV_TBL_ADDR_RED_G_START, ISPPRV_SET_TBL_ADDR);
 
 		for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++)
 			omap_writel(redgamma_table[ctr], ISPPRV_SET_TBL_DATA);
@@ -558,7 +612,7 @@ void isppreview_config_shadow_registers()
 	}
 
 	if (BG_update) {
-		omap_writel(0x800, ISPPRV_SET_TBL_ADDR);
+		omap_writel(ISPPRV_TBL_ADDR_BLUE_G_START, ISPPRV_SET_TBL_ADDR);
 
 		for (ctr = 0; ctr < ISP_GAMMA_TABLE_SIZE; ctr++)
 			omap_writel(bluegamma_table[ctr], ISPPRV_SET_TBL_DATA);
@@ -1694,9 +1748,15 @@ void isppreview_enable(u8 enable)
 {
 
 	if (enable) {
+		spin_lock(&ispprev_obj.ispprev_lock);
+		ispprev_obj.stream_on = 1;
+		spin_unlock(&ispprev_obj.ispprev_lock);
 		omap_writel((omap_readl(ISPPRV_PCR)) | ISPPRV_PCR_EN,
 								ISPPRV_PCR);
 	} else {
+		spin_lock(&ispprev_obj.ispprev_lock);
+		ispprev_obj.stream_on = 0;
+		spin_unlock(&ispprev_obj.ispprev_lock);
 		omap_writel((omap_readl(ISPPRV_PCR)) & ~ISPPRV_PCR_EN,
 								ISPPRV_PCR);
 	}
@@ -1827,6 +1887,7 @@ int __init isp_preview_init(void)
 
 	ispprev_obj.prev_inuse = 0;
 	mutex_init(&ispprev_obj.ispprev_mutex);
+	spin_lock_init(&ispprev_obj.ispprev_lock);
 
 	if (system_rev > OMAP3430_REV_ES1_0) {
 		flr_wbal_coef0 = 0x23;
diff --git a/drivers/media/video/isp/isppreview.h b/drivers/media/video/isp/isppreview.h
old mode 100644
new mode 100755
index 960dbb2..11596b3
--- a/drivers/media/video/isp/isppreview.h
+++ b/drivers/media/video/isp/isppreview.h
@@ -71,6 +71,11 @@
 
 #define ISP_GAMMA_TABLE_SIZE 		(1 << 10)
 
+/* Table addresses */
+#define ISPPRV_TBL_ADDR_RED_G_START  0x00
+#define ISPPRV_TBL_ADDR_BLUE_G_START  0x800
+#define ISPPRV_TBL_ADDR_GREEN_G_START  0x400
+
 /*
  *Enumeration Constants for input and output format
  */
-- 
1.5.6.5

