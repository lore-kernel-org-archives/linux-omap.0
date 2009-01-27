From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] hsmmc: Add MMC3 support
Date: Tue, 27 Jan 2009 11:53:42 +0200
Message-ID: <1233050022-5769-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:33281 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbZA0Jxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 04:53:48 -0500
Received: by fk-out-0910.google.com with SMTP id f33so3069194fkf.5
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 01:53:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Device connected to MMC3 is assumed to be self-powered, so
set_power() function is empty. It can't be omited because
host driver requires it. Array size for hsmmc[] is specified
because hsmmc[2].name is needed for MMC3 name.

Also fix a leak which happens if invalid controller id
is passed.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
This patch applies on top of David Brownel's recent 2 patches.

 arch/arm/mach-omap2/board-omap3pandora.c |    6 ++++++
 arch/arm/mach-omap2/mmc-twl4030.c        |   18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2637641..6c1e8fe 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -159,6 +159,12 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 		.ext_clock	= 1,
 		.transceiver	= true,
 	},
+	{
+		.mmc		= 3,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
 	{}	/* Terminator */
 };
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index b45135e..3b98948 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -61,7 +61,7 @@ static struct twl_mmc_controller {
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
 	char		name[HSMMC_NAME_LEN];
-} hsmmc[] = {
+} hsmmc[OMAP34XX_NR_MMC] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC1_DEDICATED,
@@ -346,6 +346,15 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 	return ret;
 }
 
+static int twl_mmc3_set_power(struct device *dev, int slot, int power_on, int vdd)
+{
+	/*
+	 * Assume MMC3 has self-powered device connected, for example on-board
+	 * chip with external power source.
+	 */
+	return 0;
+}
+
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
@@ -413,7 +422,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
 		 * the TWL4030's VMMC1 and VMMC2, respectively;
-		 * and that OMAP's MMC3 isn't used.
+		 * and that MMC3 device has it's own power source.
 		 */
 
 		switch (c->mmc) {
@@ -428,8 +437,13 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			else
 				mmc->slots[0].ocr_mask = MMC_VDD_165_195;
 			break;
+		case 3:
+			mmc->slots[0].set_power = twl_mmc3_set_power;
+			mmc->slots[0].ocr_mask = MMC_VDD_165_195;
+			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
+			kfree(mmc);
 			continue;
 		}
 		hsmmc_data[c->mmc - 1] = mmc;
-- 
1.5.6.3

