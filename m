From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Optimize the delay in MMC power sequence
Date: Mon, 7 Sep 2009 00:26:21 +0530 (IST)
Message-ID: <38467.192.168.10.88.1252263381.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758089AbZIFS4Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 Sep 2009 14:56:24 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n86IuMLF001440
	for <linux-omap@vger.kernel.org>; Sun, 6 Sep 2009 13:56:27 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n86IuKYF024335
	for <linux-omap@vger.kernel.org>; Sun, 6 Sep 2009 13:56:21 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

commit 004a049bbab47d382a741d8e8fc6a1b9b44b36ac
Author: Madhu <madhu.cr@ti.com>
Date:   Sun Sep 6 13:18:21 2009 -0400

    Replace the 100mS delay in the MMC power sequence with an appropriate delay
    based on the measurements taken for VDDS stability on SDP with T2 power IC.
    The delay in the power down sequence is not needed since it is taken care in
    the power up sequence.

    Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 3c04c2f..6a9be61 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -237,30 +237,27 @@ static int twl_mmc1_set_power(struct device *dev, int
slot, int power_on,
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);

-		ret = mmc_regulator_set_ocr(c->vcc, vdd);
-
-		/* 100ms delay required for PBIAS configuration */
-		msleep(100);
 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
 		if ((1 << vdd) <= MMC_VDD_165_195)
 			reg &= ~OMAP2_PBIASLITEVMODE0;
 		else
 			reg |= OMAP2_PBIASLITEVMODE0;
 		omap_ctrl_writel(reg, control_pbias_offset);
+
+		ret = mmc_regulator_set_ocr(c->vcc, vdd);
+
+		/* 400uS required for VDDS to stable */
+		udelay(400);
+
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= OMAP2_PBIASLITEPWRDNZ0;
+		omap_ctrl_writel(reg, control_pbias_offset);
 	} else {
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);

 		ret = mmc_regulator_set_ocr(c->vcc, 0);
-
-		/* 100ms delay required for PBIAS configuration */
-		msleep(100);
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
-			OMAP2_PBIASLITEVMODE0);
-		omap_ctrl_writel(reg, control_pbias_offset);
 	}

 	return ret;


