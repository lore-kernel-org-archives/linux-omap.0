From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 5/5] Regulator: Renaming the supplies used in MMC driver
Date: Thu,  5 Nov 2009 22:09:49 +0530
Message-ID: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757461AbZKEQjv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Supply names are renamed from vmmc -> mmc and vmmc_aux -> mmc_aux.
This is done to have simple supply names both in the driver
and in the board-evm file.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 3403914..af3b1be 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -109,9 +109,9 @@ static int twl_mmc_late_init(struct device *dev)
 
 			hsmmc[i].mmc = mmc;
 
-			reg = regulator_get(dev, "vmmc");
+			reg = regulator_get(dev, "mmc");
 			if (IS_ERR(reg)) {
-				dev_dbg(dev, "vmmc regulator missing\n");
+				dev_dbg(dev, "mmc regulator missing\n");
 				/* HACK: until fixed.c regulator is usable,
 				 * we don't require a main regulator
 				 * for MMC2 or MMC3
@@ -126,7 +126,7 @@ static int twl_mmc_late_init(struct device *dev)
 			mmc->slots[0].ocr_mask = mmc_regulator_get_ocrmask(reg);
 
 			/* allow an aux regulator */
-			reg = regulator_get(dev, "vmmc_aux");
+			reg = regulator_get(dev, "mmc_aux");
 			hsmmc[i].vcc_aux = IS_ERR(reg) ? NULL : reg;
 
 			/* UGLY HACK:  workaround regulator framework bugs.
-- 
1.6.2.4

