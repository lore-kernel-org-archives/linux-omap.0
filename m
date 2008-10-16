From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 11/28] [OMAPZOOM] OMAP: CAM: ISP: Fix Silicon Revision check
Date: Wed, 15 Oct 2008 20:24:39 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568842@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbYJPBYq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:24:46 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1Oegs011657
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:24:45 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1OeZg011081
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:24:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: Fix Silicon Revision check

This patch fixes the silicon revision checking method for the latest
method

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c        |    4 ++--
 drivers/media/video/isp/ispccdc.c    |    2 +-
 drivers/media/video/isp/ispmmu.c     |    4 ++--
 drivers/media/video/isp/isppreview.c |    4 ++--
 drivers/media/video/isp/ispresizer.c |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c	2008-10-14 10:22:33.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.c	2008-10-14 11:03:27.000000000 -0500
@@ -696,7 +696,7 @@
 		omap_writel(ISPMMU_AUTOIDLE | (ISPMMU_SIDLEMODE_SMARTIDLE <<
 						ISPMMU_SIDLEMODE_SHIFT),
 						ISPMMU_SYSCONFIG);
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+		if (system_rev == OMAP3430_REV_ES1_0) {
 			omap_writel(ISPCSI1_AUTOIDLE |
 					(ISPCSI1_MIDLEMODE_SMARTSTANDBY <<
 					ISPCSI1_MIDLEMODE_SHIFT),
@@ -717,7 +717,7 @@
 		omap_writel(ISPMMU_AUTOIDLE |
 			(ISPMMU_SIDLEMODE_NOIDLE << ISPMMU_SIDLEMODE_SHIFT),
 							ISPMMU_SYSCONFIG);
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+		if (system_rev == OMAP3430_REV_ES1_0) {
 			omap_writel(ISPCSI1_AUTOIDLE |
 					(ISPCSI1_MIDLEMODE_FORCESTANDBY <<
 					ISPCSI1_MIDLEMODE_SHIFT),
Index: omapkernel/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.c	2008-10-14 10:22:33.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispccdc.c	2008-10-14 11:03:27.000000000 -0500
@@ -751,7 +751,7 @@
 		bclamp_val |= bclamp.obstpixel << ISPCCDC_CLAMP_OBST_SHIFT;
 		omap_writel(bclamp_val, ISPCCDC_CLAMP);
 	} else {
-		if (is_sil_rev_less_than(OMAP3430_REV_ES2_0))
+		if (system_rev < OMAP3430_REV_ES2_0)
 			if ((ispccdc_obj.syncif_ipmod == YUV16) ||
 					(ispccdc_obj.syncif_ipmod == YUV8) ||
 					((omap_readl(ISPCCDC_REC656IF) &
Index: omapkernel/drivers/media/video/isp/ispmmu.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispmmu.c	2008-10-14 10:22:33.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispmmu.c	2008-10-14 11:03:27.000000000 -0500
@@ -211,7 +211,7 @@
 					l2_page_cache_p, l2_page_cache,
 					L2P_TABLES_SIZE);
 
-	if (is_sil_rev_less_than(OMAP3430_REV_ES2_0))
+	if (system_rev < OMAP3430_REV_ES2_0)
 		l2_mapattr_obj.endianism = B_ENDIAN;
 	else
 		l2_mapattr_obj.endianism = L_ENDIAN;
@@ -616,7 +616,7 @@
 	DPRINTK_ISPMMU("TTB allocated at p = 0x%x, v = 0x%x, size = 0x%x\n",
 		ttb_p, (u32)ttb, ttb_aligned_size);
 
-	if (is_sil_rev_less_than(OMAP3430_REV_ES2_0))
+	if (system_rev < OMAP3430_REV_ES2_0)
 		l1_mapattr_obj.endianism = B_ENDIAN;
 	else
 		l1_mapattr_obj.endianism = L_ENDIAN;
Index: omapkernel/drivers/media/video/isp/isppreview.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.c	2008-10-14 10:22:33.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.c	2008-10-14 11:03:27.000000000 -0500
@@ -1441,7 +1441,7 @@
 				"width < 16 or height < 32 \n");
 		return -EINVAL;
 	}
-	if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+	if (system_rev == OMAP3430_REV_ES1_0)
 		max_out = ISPPRV_MAXOUTPUT_WIDTH;
 	else
 		max_out = ISPPRV_MAXOUTPUT_WIDTH_ES2;
@@ -1808,7 +1808,7 @@
 	ispprev_obj.prev_inuse = 0;
 	mutex_init(&ispprev_obj.ispprev_mutex);
 
-	if (is_sil_rev_equal_to(OMAP3430_REV_ES2_0)) {
+	if (system_rev > OMAP3430_REV_ES1_0) {
 		flr_wbal_coef0 = 0x23;
 		flr_wbal_coef1 = 0x20;
 		flr_wbal_coef2 = 0x20;
Index: omapkernel/drivers/media/video/isp/ispresizer.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispresizer.c	2008-10-14 10:22:33.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispresizer.c	2008-10-14 11:03:27.000000000 -0500
@@ -353,7 +353,7 @@
 	if (*output_h < 2)
 		*output_h = 2;
 
-	if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+	if (system_rev == OMAP3430_REV_ES1_0) {
 		max_in_otf = MAX_IN_WIDTH_ONTHEFLY_MODE;
 		max_out_7tap = MAX_7TAP_VRSZ_OUTWIDTH;
 	} else {
