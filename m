From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: 2 new entries in SDRC table for Qimonda HYB18M512160AF-6
Date: Mon,  1 Jun 2009 17:00:07 +0530
Message-ID: <1243855807-31226-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57875 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZFALaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 07:30:13 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n51BU97Q024912
	for <linux-omap@vger.kernel.org>; Mon, 1 Jun 2009 06:30:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds 2 more entries for new SDRC clock rates
(166000000 and 83000000) in the sdrc params table for
Qimonda HYB18M512160AF-6 sdram part.
Without this CORE dvfs is broken on the 3430SDP as
omap2_sdrc_get_params() call in the dvfs sequence
always return 'rate not found'

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   22 ++++++++++++++++---
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 74a92c8..5b83076 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -20,34 +20,48 @@
 /* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 	[0] = {
-		.rate	     = 165941176,
+		.rate	     = 166000000,
 		.actim_ctrla = 0x629db4c6,
 		.actim_ctrlb = 0x00012214,
 		.rfr_ctrl    = 0x0004dc01,
 		.mr	     = 0x00000032,
 	},
 	[1] = {
+		.rate	     = 165941176,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr	     = 0x00000032,
+	},
+	[2] = {
 		.rate	     = 133333333,
 		.actim_ctrla = 0x5219b485,
 		.actim_ctrlb = 0x00012210,
 		.rfr_ctrl    = 0x0003de01,
 		.mr	     = 0x00000032,
 	},
-	[2] = {
+	[3] = {
+		.rate	     = 83000000,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr	     = 0x00000022,
+	},
+	[4] = {
 		.rate	     = 82970588,
 		.actim_ctrla = 0x31512283,
 		.actim_ctrlb = 0x0001220a,
 		.rfr_ctrl    = 0x00025501,
 		.mr	     = 0x00000022,
 	},
-	[3] = {
+	[5] = {
 		.rate	     = 66666666,
 		.actim_ctrla = 0x290d2243,
 		.actim_ctrlb = 0x00012208,
 		.rfr_ctrl    = 0x0001d601,
 		.mr	     = 0x00000022,
 	},
-	[4] = {
+	[6] = {
 		.rate	     = 0
 	},
 };
-- 
1.5.4.7

