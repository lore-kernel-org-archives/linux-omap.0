From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 6/6] OMAP: mmc-twl4030: Add VAUX3 support
Date: Tue, 10 Mar 2009 11:33:36 +0200
Message-ID: <20090310093336.16889.58211.sendpatchset@ahunter-laptop>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55496 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbZCJJe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 05:34:27 -0400
In-Reply-To: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, David Brownell <david-b@pacbell.net>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From a9cdb13f11c6f38680a4bec27300ed4c4709418f Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Wed, 25 Feb 2009 15:04:20 +0200
Subject: [PATCH] OMAP: mmc-twl4030: Add VAUX3 support

Allow overriding of VMMC2 regulator for MMC2 and use VAUX3 instead.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-flash.c |    2 +
 arch/arm/mach-omap2/mmc-twl4030.c      |  106 ++++++++++++++++++++++----------
 arch/arm/mach-omap2/mmc-twl4030.h      |    1 +
 3 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-flash.c b/arch/arm/mach-omap2/board-rx51-flash.c
index 20fe242..7060d26 100644
--- a/arch/arm/mach-omap2/board-rx51-flash.c
+++ b/arch/arm/mach-omap2/board-rx51-flash.c
@@ -20,6 +20,7 @@
 #include "mmc-twl4030.h"
 
 #define	RX51_FLASH_CS	0
+#define	VAUX3_DEV_GRP	0x1F
 
 extern struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
 extern int n800_onenand_setup(void __iomem *onenand_base, int freq);
@@ -66,6 +67,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.vsim_18v	= true,
+		.vmmc_dev_grp	= VAUX3_DEV_GRP,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 8fc8e84..208ff43 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -31,30 +31,34 @@
 
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
+#define VMMC_DEV_GRP_P1		0x20
+#define DEDICATED_OFFSET	3
+#define VMMC_DEV_GRP(c)		(c->twl_vmmc_dev_grp)
 
+#define VAUX3_DEV_GRP		0x1F
 #define VMMC1_DEV_GRP		0x27
-#define VMMC1_CLR		0x00
+#define VMMC2_DEV_GRP		0x2B
+#define VSIM_DEV_GRP		0x37
+
 #define VMMC1_315V		0x03
 #define VMMC1_300V		0x02
 #define VMMC1_285V		0x01
 #define VMMC1_185V		0x00
-#define VMMC1_DEDICATED		0x2A
 
-#define VMMC2_DEV_GRP		0x2B
-#define VMMC2_CLR		0x40
 #define VMMC2_315V		0x0c
 #define VMMC2_300V		0x0b
 #define VMMC2_285V		0x0a
 #define VMMC2_280V		0x09
 #define VMMC2_260V		0x08
 #define VMMC2_185V		0x06
-#define VMMC2_DEDICATED		0x2E
 
-#define VMMC_DEV_GRP_P1		0x20
+#define VAUX3_300V		0x04
+#define VAUX3_280V		0x03
+#define VAUX3_250V		0x02
+#define VAUX3_180V		0x01
+#define VAUX3_150V		0x00
 
-#define VSIM_DEV_GRP		0x37
 #define VSIM_18V		0x03
-#define VSIM_DEDICATED		0x3A
 
 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
@@ -64,17 +68,14 @@ static u16 control_devconf1_offset;
 static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
 	u8		twl_vmmc_dev_grp;
-	u8		twl_mmc_dedicated;
 	bool		vsim_18v;
 	char		name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
-		.twl_mmc_dedicated		= VMMC1_DEDICATED,
 	},
 	{
 		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
-		.twl_mmc_dedicated		= VMMC2_DEDICATED,
 	},
 };
 
@@ -188,10 +189,31 @@ static int twl_mmc_resume(struct device *dev, int slot)
 		|MMC_VDD_25_26|MMC_VDD_26_27|MMC_VDD_27_28 \
 		|MMC_VDD_28_29|MMC_VDD_29_30|MMC_VDD_30_31|MMC_VDD_31_32)
 
+static int twl_mmc_set_regulator(u8 vmmc_dev_grp, u8 vmmc)
+{
+	int ret;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				   VMMC_DEV_GRP_P1, vmmc_dev_grp);
+
+	if (ret)
+		return ret;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				   vmmc, vmmc_dev_grp + DEDICATED_OFFSET);
+	return ret;
+}
+
+static int twl_mmc_shutdown_regulator(u8 vmmc_dev_grp)
+{
+	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				    LDO_CLR, vmmc_dev_grp);
+}
+
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
 	int ret;
-	u8 vmmc = 0, dev_grp_val;
+	u8 vmmc = 0;
 
 	if (!vdd)
 		goto doit;
@@ -221,6 +243,32 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 		default:
 			return -EINVAL;
 		}
+	} else if (c->twl_vmmc_dev_grp == VAUX3_DEV_GRP) {
+		/* VAUX3:  max 200 mA */
+		switch (1 << vdd) {
+		case MMC_VDD_165_195:
+			vmmc = VAUX3_180V;
+			break;
+		case MMC_VDD_25_26:
+		case MMC_VDD_26_27:
+			vmmc = VAUX3_250V;
+			break;
+		case MMC_VDD_27_28:
+			vmmc = VAUX3_280V;
+			break;
+		case MMC_VDD_28_29:
+			vmmc = VAUX3_280V;
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			vmmc = VAUX3_300V;
+			break;
+		case MMC_VDD_31_32:
+			vmmc = VAUX3_300V;
+			break;
+		default:
+			return -EINVAL;
+		}
 	} else if (c->twl_vmmc_dev_grp == VMMC2_DEV_GRP) {
 		/* VMMC2:  max 100 mA */
 		switch (1 << vdd) {
@@ -252,30 +300,20 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 	}
 
 doit:
-	if (vdd)
-		dev_grp_val = VMMC_DEV_GRP_P1;	/* Power up */
-	else
-		dev_grp_val = LDO_CLR;		/* Power down */
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					dev_grp_val, c->twl_vmmc_dev_grp);
-	if (ret || !vdd)
-		return ret;
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					vmmc, c->twl_mmc_dedicated);
-	if (ret)
-		return ret;
-
-	if (c->vsim_18v) {
-		u8 vsim = vmmc ? VSIM_18V : 0;
+	if (vdd) {
+		ret = twl_mmc_set_regulator(VMMC_DEV_GRP(c), vmmc);
+		if (ret)
+			return ret;
 
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					   dev_grp_val, VSIM_DEV_GRP);
+		if (c->vsim_18v)
+			ret = twl_mmc_set_regulator(VSIM_DEV_GRP, VSIM_18V);
+	} else {
+		ret = twl_mmc_shutdown_regulator(VMMC_DEV_GRP(c));
 		if (ret)
 			return ret;
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					   vsim, VSIM_DEDICATED);
+
+		if (c->vsim_18v)
+			ret = twl_mmc_shutdown_regulator(VSIM_DEV_GRP);
 	}
 
 	return ret;
@@ -467,6 +505,8 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			break;
 		case 2:
 			mmc->slots[0].set_power = twl_mmc2_set_power;
+			if (c->vmmc_dev_grp)
+				twl->twl_vmmc_dev_grp = c->vmmc_dev_grp;
 			if (c->transceiver)
 				mmc->slots[0].ocr_mask = MMC2_OCR;
 			else if (c->vsim_18v) {
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 69dbbc1..6148ba6 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -11,6 +11,7 @@ struct twl4030_hsmmc_info {
 	u8	wires;		/* 1/4/8 wires */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
+	u8      vmmc_dev_grp;   /* override default regulator */
 	bool	vsim_18v;	/* MMC-2 option */
 	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
-- 
1.5.6.3

