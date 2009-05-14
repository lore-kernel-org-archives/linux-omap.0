From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/2] OMAP3 SDRC: Drop 133.3MHz,
	66.6MHz rates from Qimonda SDRAM params file
Date: Thu, 14 May 2009 13:50:21 -0600
Message-ID: <20090514195010.20623.21180.stgit@localhost.localdomain>
References: <20090514194728.20623.60039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43624 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZENTwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:52:34 -0400
In-Reply-To: <20090514194728.20623.60039.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>

Boards that used 133.3MHz maximum rate SDRAM were never released to the
public and presumably used the OMAPZoom kernel; so, drop these unused
rates.  Viz.:

    http://marc.info/?l=linux-omap&m=124232922426311&w=2

This patch is a collaboration between Richard Woodruff <r-woodruff2@ti.com>
and Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   21 +++-----------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
index 74a92c8..8b6f929 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -1,8 +1,8 @@
 /*
  * SDRC register values for the Qimonda HYB18M512160AF-6
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Paul Walmsley
  *
@@ -17,7 +17,6 @@
 #include <mach/sdrc.h>
 
 /* Qimonda HYB18M512160AF-6 */
-/* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 	[0] = {
 		.rate	     = 165941176,
@@ -27,27 +26,13 @@ static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
 		.mr	     = 0x00000032,
 	},
 	[1] = {
-		.rate	     = 133333333,
-		.actim_ctrla = 0x5219b485,
-		.actim_ctrlb = 0x00012210,
-		.rfr_ctrl    = 0x0003de01,
-		.mr	     = 0x00000032,
-	},
-	[2] = {
 		.rate	     = 82970588,
 		.actim_ctrla = 0x31512283,
 		.actim_ctrlb = 0x0001220a,
 		.rfr_ctrl    = 0x00025501,
 		.mr	     = 0x00000022,
 	},
-	[3] = {
-		.rate	     = 66666666,
-		.actim_ctrla = 0x290d2243,
-		.actim_ctrlb = 0x00012208,
-		.rfr_ctrl    = 0x0001d601,
-		.mr	     = 0x00000022,
-	},
-	[4] = {
+	[2] = {
 		.rate	     = 0
 	},
 };


