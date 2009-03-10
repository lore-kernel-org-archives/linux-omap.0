From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/6] OMAP: mmc-twl4030 support VSIM is VMMC2_IO
Date: Tue, 10 Mar 2009 11:33:09 +0200
Message-ID: <20090310093309.16889.79381.sendpatchset@ahunter-laptop>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38150 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbZCJJdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 05:33:17 -0400
In-Reply-To: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, David Brownell <david-b@pacbell.net>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 2f6a22e9091a09fb3cbb720356116035611636b2 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 23 Jan 2009 11:45:49 +0200
Subject: [PATCH] OMAP: mmc-twl4030 support VSIM is VMMC2_IO

eMMC has two voltage lines, one for I/O and one for the
NAND core.  This patch allows VSIM and VMMC2 respectively,
to be used for those two.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   25 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index aeaab5a..736b039 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -52,6 +52,10 @@
 
 #define VMMC_DEV_GRP_P1		0x20
 
+#define VSIM_DEV_GRP		0x37
+#define VSIM_18V		0x03
+#define VSIM_DEDICATED		0x3A
+
 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
 
@@ -61,6 +65,7 @@ static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
+	bool		vsim_18v;
 	char		name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC] = {
 	{
@@ -251,6 +256,19 @@ doit:
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->twl_mmc_dedicated);
+	if (ret)
+		return ret;
+
+	if (c->vsim_18v) {
+		u8 vsim = vmmc ? VSIM_18V : 0;
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+					   dev_grp_val, VSIM_DEV_GRP);
+		if (ret)
+			return ret;
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+					   vsim, VSIM_DEDICATED);
+	}
 
 	return ret;
 }
@@ -437,7 +455,12 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			mmc->slots[0].set_power = twl_mmc2_set_power;
 			if (c->transceiver)
 				mmc->slots[0].ocr_mask = MMC2_OCR;
-			else
+			else if (c->vsim_18v) {
+				mmc->slots[0].ocr_mask = MMC_VDD_27_28 |
+					MMC_VDD_28_29 | MMC_VDD_29_30 |
+					MMC_VDD_30_31 | MMC_VDD_31_32;
+				twl->vsim_18v = true;
+			} else
 				mmc->slots[0].ocr_mask = MMC_VDD_165_195;
 			break;
 		case 3:
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 21d3572..087a969 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -11,6 +11,7 @@ struct twl4030_hsmmc_info {
 	u8	wires;		/* 1/4/8 wires */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
+	bool	vsim_18v;	/* MMC-2 option */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	struct device *dev;	/* returned: pointer to mmc adapter */
-- 
1.5.6.3

