From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] arm: igep0020: Specify the VPLL2 regulator unconditionally
Date: Mon, 23 Apr 2012 14:48:58 +0200
Message-ID: <1335185338-22006-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:36479 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2DWMss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 08:48:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Mike Rapoport <mike@compulab.co.il>, Tony Lindgren <tony@atomide.com>

The supply is connected to the DSS DO-D5 pins and is thus needed for
both serial and parallel display interfaces on the igep0030 as well as
the igep0020.

If the igep0030 module isn't connected to a display, no DSI or DPI
display will be specified in board code, and the DSS driver won't enable
to VPLL2 regulator anyway.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a59ace0..242cdff 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -539,7 +539,10 @@ static void __init igep_i2c_init(void)
 {
 	int ret;
 
-	omap3_pmic_get_config(&igep_twldata, TWL_COMMON_PDATA_USB, 0);
+	omap3_pmic_get_config(&igep_twldata, TWL_COMMON_PDATA_USB,
+			      TWL_COMMON_REGULATOR_VPLL2);
+	igep_twldata.vpll2->constraints.apply_uV = true;
+	igep_twldata.vpll2->constraints.name = "VDVI";
 
 	if (machine_is_igep0020()) {
 		/*
@@ -553,10 +556,7 @@ static void __init igep_i2c_init(void)
 
 		igep_twldata.keypad	= &igep2_keypad_pdata;
 		/* Get common pmic data */
-		omap3_pmic_get_config(&igep_twldata, TWL_COMMON_PDATA_AUDIO,
-				      TWL_COMMON_REGULATOR_VPLL2);
-		igep_twldata.vpll2->constraints.apply_uV = true;
-		igep_twldata.vpll2->constraints.name = "VDVI";
+		omap3_pmic_get_config(&igep_twldata, TWL_COMMON_PDATA_AUDIO, 0);
 	}
 
 	omap3_pmic_init("twl4030", &igep_twldata);
-- 
Regards,

Laurent Pinchart

