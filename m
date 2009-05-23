From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 SDRC: Drop 133.3MHz, 66.6MHz rates from Micron SDRAM
 params file
Date: Fri, 22 May 2009 19:56:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905221955390.26015@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44095 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZEWB4e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 21:56:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r-woodruff2@ti.com, tony@atomide.com


Boards that used 133.3MHz maximum rate SDRAM were never released to the
public and presumably used the OMAPZoom kernel; so, drop these unused
rates.  Viz.:

    http://marc.info/?l=linux-omap&m=124232922426311&w=2

This patch is a collaboration between Richard Woodruff <r-woodruff2@ti.com>,
Tony Lindgren <tony@atomide.com>, and Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
index b6c1db3..02e1c2d 100644
--- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -2,7 +2,7 @@
  * SDRC register values for the Micron MT46H32M32LF-6
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Paul Walmsley
  *
@@ -34,34 +34,20 @@ static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] = {
 		.mr	     = 0x00000032,
 	},
 	[2] = {
-		.rate	     = 133333333,
-		.actim_ctrla = 0x7a19b485,
-		.actim_ctrlb = 0x00011213,
-		.rfr_ctrl    = 0x0003de01,
-		.mr	     = 0x00000032,
-	},
-	[3] = {
 		.rate	     = 83000000,
 		.actim_ctrla = 0x51512283,
 		.actim_ctrlb = 0x0001120c,
 		.rfr_ctrl    = 0x00025501,
 		.mr	     = 0x00000032,
 	},
-	[4] = {
+	[3] = {
 		.rate	     = 82970588,
 		.actim_ctrla = 0x51512283,
 		.actim_ctrlb = 0x0001120c,
 		.rfr_ctrl    = 0x00025501,
 		.mr	     = 0x00000032,
 	},
-	[5] = {
-		.rate	     = 66666666,
-		.actim_ctrla = 0x410d2243,
-		.actim_ctrlb = 0x0001120a,
-		.rfr_ctrl    = 0x0001d601,
-		.mr	     = 0x00000032,
-	},
-	[6] = {
+	[4] = {
 		.rate	     = 0
 	},
 };
-- 
1.6.3.rc1.51.gea0b7

