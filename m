From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH v2 1/2] OMAP3ISP: Preview fix
Date: Wed, 7 Jan 2009 18:13:04 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328C8F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbZAHANL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 19:13:11 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n080D64U027483
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 18:13:11 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n080D5Cc007381
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 18:13:05 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 28d4ab715a8448dcd75a6e7a2924c1a24a5563b9 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 7 Jan 2009 16:39:11 -0600
Subject: [PATCH] OMAP3ISP: Preview fix

This is for Syncup from TI internal tree, as this seems
to look better on SDP for both MT9P012 and OV3640 sensors.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isppreview.c |   16 ++++++++++------
 drivers/media/video/isp/isppreview.h |   11 +++++------
 2 files changed, 15 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 drivers/media/video/isp/isppreview.c
 mode change 100644 => 100755 drivers/media/video/isp/isppreview.h

diff --git a/drivers/media/video/isp/isppreview.c b/drivers/media/video/isp/isppreview.c
old mode 100644
new mode 100755
index abee2d5..1d877af
--- a/drivers/media/video/isp/isppreview.c
+++ b/drivers/media/video/isp/isppreview.c
@@ -100,7 +100,7 @@ static struct ispprev_csc flr_prev_csc[] = {
 			{0x0, 0x0, 0x0}
 	},
 	{
-		{	/* CSC Coef Matrix Sepia */
+		{	/* CSC Coef Matrix Sepia*/
 			{19, 38, 7},
 			{0, 0, 0},
 			{0, 0, 0}
@@ -500,6 +500,7 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 		down(&isppreview_mutex);
 		if (copy_from_user(redgamma_table, isptables_struct->red_gamma,
 						sizeof(redgamma_table))) {
+			RG_update = 0;
 			up(&isppreview_mutex);
 			goto err_copy_from_user;
 		}
@@ -527,6 +528,7 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 		if (copy_from_user(greengamma_table,
 						isptables_struct->green_gamma,
 						sizeof(greengamma_table))) {
+			GG_update = 0;
 			up(&isppreview_mutex);
 			goto err_copy_from_user;
 		}
@@ -554,6 +556,7 @@ int omap34xx_isp_tables_update(struct isptables_update *isptables_struct)
 		if (copy_from_user(bluegamma_table, (isptables_struct->
 						blue_gamma),
 						sizeof(bluegamma_table))) {
+			BG_update = 0;
 			up(&isppreview_mutex);
 			goto err_copy_from_user;
 		}
@@ -1977,7 +1980,7 @@ int __init isp_preview_init(void)
 		flr_wbal_coef0 = 0x23;
 		flr_wbal_coef1 = 0x20;
 		flr_wbal_coef2 = 0x20;
-		flr_wbal_coef3 = 0x39;
+		flr_wbal_coef3 = 0x30;
 	}
 
 	/* Init values */
@@ -2003,7 +2006,7 @@ int __init isp_preview_init(void)
 	memcpy(params->nf.table, noise_filter_table, sizeof(params->nf.table));
 	params->dcor.couplet_mode_en = 1;
 	for (i = 0; i < 4; i++)
-		params->dcor.detect_correct[i] = 0xE;
+		params->dcor.detect_correct[i] = 0x32 | (0x19 << 16);/*0xE*/
 	params->gtable.bluetable = bluegamma_table;
 	params->gtable.greentable = greengamma_table;
 	params->gtable.redtable = redgamma_table;
@@ -2018,14 +2021,15 @@ int __init isp_preview_init(void)
 	params->rgb2rgb = flr_rgb2rgb;
 	params->rgb2ycbcr = flr_prev_csc[ispprev_obj.color];
 
-	params->features = PREV_CFA | PREV_CHROMA_SUPPRESS | PREV_LUMA_ENHANCE
-				| PREV_DEFECT_COR | PREV_NOISE_FILTER;
+	params->features = PREV_CFA | PREV_DEFECT_COR | PREV_NOISE_FILTER;
 	params->features &= ~(PREV_AVERAGER | PREV_INVERSE_ALAW |
 						PREV_HORZ_MEDIAN_FILTER |
 						PREV_GAMMA_BYPASS |
 						PREV_DARK_FRAME_SUBTRACT |
 						PREV_LENS_SHADING |
-						PREV_DARK_FRAME_CAPTURE);
+						PREV_DARK_FRAME_CAPTURE |
+						PREV_CHROMA_SUPPRESS |
+						PREV_LUMA_ENHANCE);
 	return 0;
 }
 
diff --git a/drivers/media/video/isp/isppreview.h b/drivers/media/video/isp/isppreview.h
old mode 100644
new mode 100755
index 11596b3..0a0a9e2
--- a/drivers/media/video/isp/isppreview.h
+++ b/drivers/media/video/isp/isppreview.h
@@ -28,21 +28,20 @@
 #define ISPPRV_BRIGHT_DEF		0x1
 #define ISPPRV_BRIGHT_LOW		0x0
 #define ISPPRV_BRIGHT_HIGH		0xF
-#define ISPPRV_BRIGHT_UNITS		0x1
+#define ISPPRV_BRIGHT_UNITS		0x7
 
-/*
 #define ISPPRV_CONTRAST_STEP		0x1
 #define ISPPRV_CONTRAST_DEF		0x2
 #define ISPPRV_CONTRAST_LOW		0x0
 #define ISPPRV_CONTRAST_HIGH		0xF
 #define ISPPRV_CONTRAST_UNITS		0x5
-*/
+/* MMS
 #define ISPPRV_CONTRAST_STEP		0x1
-#define ISPPRV_CONTRAST_DEF		0x1 /* MMS */
+#define ISPPRV_CONTRAST_DEF		0x1
 #define ISPPRV_CONTRAST_LOW		0x0
 #define ISPPRV_CONTRAST_HIGH		0xF
-#define ISPPRV_CONTRAST_UNITS		0x16 /* MMS */
-
+#define ISPPRV_CONTRAST_UNITS		0x16
+*/
 #define NO_AVE				0x0
 #define AVE_2_PIX			0x1
 #define AVE_4_PIX			0x2
-- 
1.5.6.5

