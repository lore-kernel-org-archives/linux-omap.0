From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] ARM: OMAP3: mmc-twl4030 add MMC3 support
Date: Tue, 10 Mar 2009 14:10:00 -0700
Message-ID: <20090310211000.16425.62205.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55804 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbZCJVKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:10:02 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

Device connected to MMC3 is assumed to be self-powered, so
set_power() function is empty. It can't be omited because
host driver requires it. Array size for hsmmc[] is specified
because hsmmc[2].name is needed for MMC3 name.

Also fix a leak which happens if invalid controller id
is passed.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    6 ++++++
 arch/arm/mach-omap2/mmc-twl4030.c        |   19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7a46a65..6e17180 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -55,6 +55,12 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
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
index 6399874..042035c 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -62,7 +62,7 @@ static struct twl_mmc_controller {
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
 	char		name[HSMMC_NAME_LEN + 1];
-} hsmmc[] = {
+} hsmmc[OMAP34XX_NR_MMC] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
 		.twl_mmc_dedicated		= VMMC1_DEDICATED,
@@ -347,6 +347,16 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 	return ret;
 }
 
+static int twl_mmc3_set_power(struct device *dev, int slot, int power_on,
+		int vdd)
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
@@ -414,7 +424,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
 		 * the TWL4030's VMMC1 and VMMC2, respectively;
-		 * and that OMAP's MMC3 isn't used.
+		 * and that MMC3 device has it's own power source.
 		 */
 
 		switch (c->mmc) {
@@ -429,8 +439,13 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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

