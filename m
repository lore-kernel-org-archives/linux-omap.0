From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] ARM: OMAP3: mmc-twl4030 voltage cleanup
Date: Tue, 10 Mar 2009 14:07:25 -0700
Message-ID: <20090310210725.16425.93638.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53231 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbZCJVH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:07:28 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Correct twl4030 MMC power switching:  fix voltage ranges reported
for each slot, and handle them fully.

 Lies corrected:
  - MMC-1 doesn't support the 2.6-2.7 Volt range
  - MMC-2 can't normally support anything except 1.8V
 Omissions corrected
  - MMC-1 *does* handle the 2.8-2.9 Volt range
  - MMC-2 can handle 2.5-3.2 Volt cards, given a transceiver

Add transciever support for MMC-2; enable it for Overo and Pandora.
(Depends on something else to have set up pinmuxing for control
signals instead of as MMC2_DAT4..7 pins.)

Also shrink twl4030_hsmmc_info a smidgeon ... padding is all gone.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    1 
 arch/arm/mach-omap2/board-overo.c        |    1 
 arch/arm/mach-omap2/mmc-twl4030.c        |  127 +++++++++++++++++++-----------
 arch/arm/mach-omap2/mmc-twl4030.h        |    3 -
 4 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b319610..7a46a65 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -53,6 +53,7 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 127,
 		.ext_clock	= 1,
+		.transceiver	= true,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 82b3dc5..61f8e23 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -209,6 +209,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.transceiver	= true,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 909f57c..42ac13f 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -44,6 +44,7 @@
 #define VMMC2_315V		0x0c
 #define VMMC2_300V		0x0b
 #define VMMC2_285V		0x0a
+#define VMMC2_280V		0x09
 #define VMMC2_260V		0x08
 #define VMMC2_185V		0x06
 #define VMMC2_DEDICATED		0x2E
@@ -166,56 +167,73 @@ static int twl_mmc_resume(struct device *dev, int slot)
 /*
  * Sets the MMC voltage in twl4030
  */
+
+#define MMC1_OCR	(MMC_VDD_165_195 \
+		|MMC_VDD_28_29|MMC_VDD_29_30|MMC_VDD_30_31|MMC_VDD_31_32)
+#define MMC2_OCR	(MMC_VDD_165_195 \
+		|MMC_VDD_25_26|MMC_VDD_26_27|MMC_VDD_27_28 \
+		|MMC_VDD_28_29|MMC_VDD_29_30|MMC_VDD_30_31|MMC_VDD_31_32)
+
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
 	int ret;
 	u8 vmmc, dev_grp_val;
 
-	switch (1 << vdd) {
-	case MMC_VDD_35_36:
-	case MMC_VDD_34_35:
-	case MMC_VDD_33_34:
-	case MMC_VDD_32_33:
-	case MMC_VDD_31_32:
-	case MMC_VDD_30_31:
-		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
-			vmmc = VMMC1_315V;
-		else
-			vmmc = VMMC2_315V;
-		break;
-	case MMC_VDD_29_30:
-		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
-			vmmc = VMMC1_315V;
-		else
-			vmmc = VMMC2_300V;
-		break;
-	case MMC_VDD_27_28:
-	case MMC_VDD_26_27:
-		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
-			vmmc = VMMC1_285V;
-		else
-			vmmc = VMMC2_285V;
-		break;
-	case MMC_VDD_25_26:
-	case MMC_VDD_24_25:
-	case MMC_VDD_23_24:
-	case MMC_VDD_22_23:
-	case MMC_VDD_21_22:
-	case MMC_VDD_20_21:
-		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
-			vmmc = VMMC1_285V;
-		else
-			vmmc = VMMC2_260V;
-		break;
-	case MMC_VDD_165_195:
-		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+	if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP) {
+		/* VMMC1:  max 220 mA.  And for 8-bit mode,
+		 * VSIM:  max 50 mA
+		 */
+		switch (1 << vdd) {
+		case MMC_VDD_165_195:
 			vmmc = VMMC1_185V;
-		else
+			/* and VSIM_180V */
+			break;
+		case MMC_VDD_28_29:
+			vmmc = VMMC1_285V;
+			/* and VSIM_280V */
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			vmmc = VMMC1_300V;
+			/* and VSIM_300V */
+			break;
+		case MMC_VDD_31_32:
+			vmmc = VMMC1_315V;
+			/* error if VSIM needed */
+			break;
+		default:
+			vmmc = 0;
+			break;
+		}
+	} else if (c->twl_vmmc_dev_grp == VMMC2_DEV_GRP) {
+		/* VMMC2:  max 100 mA */
+		switch (1 << vdd) {
+		case MMC_VDD_165_195:
 			vmmc = VMMC2_185V;
-		break;
-	default:
-		vmmc = 0;
-		break;
+			break;
+		case MMC_VDD_25_26:
+		case MMC_VDD_26_27:
+			vmmc = VMMC2_260V;
+			break;
+		case MMC_VDD_27_28:
+			vmmc = VMMC2_280V;
+			break;
+		case MMC_VDD_28_29:
+			vmmc = VMMC2_285V;
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			vmmc = VMMC2_300V;
+			break;
+		case MMC_VDD_31_32:
+			vmmc = VMMC2_315V;
+			break;
+		default:
+			vmmc = 0;
+			break;
+		}
+	} else {
+		return 0;
 	}
 
 	if (vmmc)
@@ -242,6 +260,14 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 	struct twl_mmc_controller *c = &hsmmc[0];
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	/*
+	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
+	 * card using the same TWL VMMC1 supply (hsmmc[0]); OMAP has both
+	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
+	 *
+	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
+	 * is most naturally TWL VSIM; those pins also use PBIAS.
+	 */
 	if (power_on) {
 		if (cpu_is_omap2430()) {
 			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
@@ -298,6 +324,12 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
 	struct twl_mmc_controller *c = &hsmmc[1];
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	/*
+	 * Assume TWL VMMC2 (hsmmc[1]) is used only to power the card ... OMAP
+	 * VDDS is used to power the pins, optionally with a transceiver to
+	 * support cards using voltages other than VDDS (1.8V nominal).  When a
+	 * transceiver is used, DAT3..7 are muxed as transceiver control pins.
+	 */
 	if (power_on) {
 		if (mmc->slots[0].internal_clock) {
 			u32 reg;
@@ -352,10 +384,6 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
-		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
-					MMC_VDD_26_27 | MMC_VDD_27_28 |
-					MMC_VDD_29_30 |
-					MMC_VDD_30_31 | MMC_VDD_31_32;
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
@@ -391,9 +419,14 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		switch (c->mmc) {
 		case 1:
 			mmc->slots[0].set_power = twl_mmc1_set_power;
+			mmc->slots[0].ocr_mask = MMC1_OCR;
 			break;
 		case 2:
 			mmc->slots[0].set_power = twl_mmc2_set_power;
+			if (c->transceiver)
+				mmc->slots[0].ocr_mask = MMC2_OCR;
+			else
+				mmc->slots[0].ocr_mask = MMC_VDD_165_195;
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index e1c8076..380dde7 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -9,9 +9,10 @@
 struct twl4030_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
+	bool	transceiver;	/* MMC-2 option */
+	bool	ext_clock;	/* use external pin for input clock */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
-	int	ext_clock:1;	/* use external pin for input clock */
 };
 
 #if	defined(CONFIG_TWL4030_CORE) && \

