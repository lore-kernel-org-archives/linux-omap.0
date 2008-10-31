From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 30 Oct 2008 19:04:16 -0700
Message-ID: <1225418657-31775-4-git-send-email-tony@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
 <1225418657-31775-2-git-send-email-tony@atomide.com>
 <1225418657-31775-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50520 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYJaCEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:04:24 -0400
In-Reply-To: <1225418657-31775-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Add support for the second controller hopefully in a generic way.
Also put the twl4030 specific voltage configuration into a separate
function.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c      |    4 +-
 arch/arm/mach-omap2/board-ldp.c          |    4 +-
 arch/arm/mach-omap2/board-omap2evm.c     |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    4 +-
 arch/arm/mach-omap2/board-overo.c        |    4 +-
 arch/arm/mach-omap2/hsmmc.c              |  192 +++++++++++++++++++++---------
 arch/arm/plat-omap/include/mach/hsmmc.h  |   35 ------
 arch/arm/plat-omap/include/mach/mmc.h    |    9 ++-
 11 files changed, 160 insertions(+), 108 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/hsmmc.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cea2540..8532ef3 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -36,7 +36,7 @@
 #include <mach/mux.h>
 #include <mach/board.h>
 #include <mach/usb-musb.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/common.h>
 #include <mach/keypad.h>
 #include <mach/gpmc.h>
@@ -404,7 +404,7 @@ static void __init omap_2430sdp_init(void)
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
 	ads7846_dev_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 
 	/* turn off secondary LCD backlight */
 	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 8773698..0221b66 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -35,7 +35,7 @@
 #include <mach/board.h>
 #include <mach/usb-musb.h>
 #include <mach/usb-ehci.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/common.h>
 #include <mach/keypad.h>
 #include <mach/dma.h>
@@ -465,7 +465,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1 | HSMMC2);
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d4d4e90..387bd41 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -34,7 +34,7 @@
 #include <mach/board.h>
 #include <mach/common.h>
 #include <mach/gpmc.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/usb-musb.h>
 
 #include <asm/io.h>
@@ -341,7 +341,7 @@ static void __init omap_ldp_init(void)
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index d284551..68aebe7 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -34,7 +34,7 @@
 #include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/common.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/keypad.h>
 #include <mach/gpmc.h>
 #include <mach/nand.h>
@@ -347,7 +347,7 @@ static void __init omap2_evm_init(void)
 	spi_register_board_info(omap2evm_spi_board_info,
 				ARRAY_SIZE(omap2evm_spi_board_info));
 	omap_serial_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 	omap2evm_flash_init();
 	ads7846_dev_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ce6c7b4..062a28b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -37,7 +37,7 @@
 #include <mach/board.h>
 #include <mach/usb-musb.h>
 #include <mach/usb-ehci.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/common.h>
 #include <mach/gpmc.h>
 #include <mach/nand.h>
@@ -309,7 +309,7 @@ static void __init omap3_beagle_init(void)
 	omap_cfg_reg(AH8_34XX_GPIO29);
 	gpio_request(29, "mmc0_wp");
 	gpio_direction_input(29);
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a72772f..614fa02 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -32,7 +32,7 @@
 #include <mach/gpio.h>
 #include <mach/keypad.h>
 #include <mach/board.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/usb-musb.h>
 #include <mach/usb-ehci.h>
 #include <mach/common.h>
@@ -245,7 +245,7 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 	usb_musb_init();
 	usb_ehci_init();
 	omap3evm_flash_init();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f4180a0..ee001bb 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -41,7 +41,7 @@
 #include <mach/gpio.h>
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/usb-ehci.h>
 #include <mach/usb-musb.h>
@@ -208,7 +208,7 @@ static void __init omap3pandora_init(void)
 	omap_board_config = omap3pandora_config;
 	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
 	omap_serial_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 	usb_musb_init();
 	usb_ehci_init();
 	omap3pandora_flash_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index b0e5cec..a4bd804 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -42,7 +42,7 @@
 #include <mach/gpio.h>
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
-#include <mach/hsmmc.h>
+#include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/usb-ehci.h>
 #include <mach/usb-musb.h>
@@ -212,7 +212,7 @@ static void __init overo_init(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	hsmmc_init();
+	hsmmc_init(HSMMC1);
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index f711d7b..23cbdf6 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,13 +32,23 @@
 #define GPIO_0_BIT_POS		(1 << 0)
 
 #define VMMC1_DEV_GRP		0x27
-#define VMMC1_DEV_GRP_P1	0x20
-#define VMMC1_DEDICATED		0x2A
 #define VMMC1_CLR		0x00
 #define VMMC1_315V		0x03
 #define VMMC1_300V		0x02
 #define VMMC1_285V		0x01
 #define VMMC1_185V		0x00
+#define VMMC1_DEDICATED		0x2A
+
+#define VMMC2_DEV_GRP		0x2B
+#define VMMC2_CLR		0x40
+#define VMMC2_315V		0x0c
+#define VMMC2_300V		0x0b
+#define VMMC2_285V		0x0a
+#define VMMC2_260V		0x08
+#define VMMC2_185V		0x06
+#define VMMC2_DEDICATED		0x2E
+
+#define VMMC_DEV_GRP_P1		0x20
 
 static u16 control_pbias_offset;
 
@@ -46,17 +56,23 @@ static struct hsmmc_controller {
 	u16		control_devconf_offset;
 	u32		devconf_loopback_clock;
 	int		card_detect_gpio;
+	u8		twl_vmmc_dev_grp;
+	u8		twl_mmc_dedicated;
 } hsmmc[] = {
 	{
 		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
 		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
 		.card_detect_gpio		= OMAP_MAX_GPIO_LINES,
+		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
+		.twl_mmc_dedicated		= VMMC1_DEDICATED,
 	},
 	{
 		/* control_devconf_offset set dynamically */
 		.devconf_loopback_clock		= OMAP2_MMCSDIO2ADPCLKISEL,
+		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
+		.twl_mmc_dedicated		= VMMC2_DEDICATED,
 	},
-};
+ };
 
 static int hsmmc1_card_detect(int irq)
 {
@@ -96,7 +112,7 @@ static void hsmmc1_cleanup(struct device *dev)
 #ifdef CONFIG_PM
 
 /*
- * To mask and unmask MMC Card Detect Interrupt
+ * Mask and unmask MMC Card Detect Interrupt
  * mask : 1
  * unmask : 0
  */
@@ -150,33 +166,88 @@ static int hsmmc1_resume(struct device *dev, int slot)
 
 #endif
 
+/*
+ * Sets the MMC voltage in twl4030
+ */
+static int hsmmc_twl_set_voltage(struct hsmmc_controller *c, int vdd)
+{
+	int ret;
+	u8 vmmc, dev_grp_val;
+
+	switch (1 << vdd) {
+	case MMC_VDD_35_36:
+	case MMC_VDD_34_35:
+	case MMC_VDD_33_34:
+	case MMC_VDD_32_33:
+	case MMC_VDD_31_32:
+	case MMC_VDD_30_31:
+		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+			vmmc = VMMC1_315V;
+		else
+			vmmc = VMMC2_315V;
+		break;
+	case MMC_VDD_29_30:
+		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+			vmmc = VMMC1_315V;
+		else
+			vmmc = VMMC2_300V;
+		break;
+	case MMC_VDD_27_28:
+	case MMC_VDD_26_27:
+		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+			vmmc = VMMC1_285V;
+		else
+			vmmc = VMMC2_285V;
+		break;
+	case MMC_VDD_25_26:
+	case MMC_VDD_24_25:
+	case MMC_VDD_23_24:
+	case MMC_VDD_22_23:
+	case MMC_VDD_21_22:
+	case MMC_VDD_20_21:
+		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+			vmmc = VMMC1_285V;
+		else
+			vmmc = VMMC2_260V;
+		break;
+	case MMC_VDD_165_195:
+		if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP)
+			vmmc = VMMC1_185V;
+		else
+			vmmc = VMMC2_185V;
+		break;
+	default:
+		vmmc = 0;
+		break;
+	}
+
+	if (vmmc)
+		dev_grp_val = VMMC_DEV_GRP_P1;	/* Power up */
+	else
+		dev_grp_val = LDO_CLR;		/* Power down */
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+					dev_grp_val, c->twl_vmmc_dev_grp);
+	if (ret)
+		return ret;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						vmmc, c->twl_mmc_dedicated);
+
+	return ret;
+}
+
 static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
 	u32 reg;
 	int ret = 0;
-	u16 control_devconf_offset = hsmmc[0].control_devconf_offset;
+	struct hsmmc_controller *c = &hsmmc[0];
 
 	if (power_on) {
-		u32 vdd_sel = 0;
-
-		switch (1 << vdd) {
-		case MMC_VDD_33_34:
-		case MMC_VDD_32_33:
-		case MMC_VDD_31_32:
-		case MMC_VDD_30_31:
-			vdd_sel = VMMC1_315V;
-			break;
-		case MMC_VDD_29_30:
-			vdd_sel = VMMC1_300V;
-			break;
-		case MMC_VDD_165_195:
-			vdd_sel = VMMC1_185V;
-		}
-
 		if (cpu_is_omap2430()) {
 			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
-			if (vdd_sel >= VMMC1_300V)
+			if ((1 << vdd) >= MMC_VDD_30_31)
 				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
 			else
 				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
@@ -185,9 +256,9 @@ static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 
 		/* REVISIT: Loop back clock not needed for 2430? */
 		if (!cpu_is_omap2430()) {
-			reg = omap_ctrl_readl(control_devconf_offset);
+			reg = omap_ctrl_readl(c->control_devconf_offset);
 			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
-			omap_ctrl_writel(reg, control_devconf_offset);
+			omap_ctrl_writel(reg, c->control_devconf_offset);
 		}
 
 		reg = omap_ctrl_readl(control_pbias_offset);
@@ -195,60 +266,53 @@ static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						VMMC1_DEV_GRP_P1, VMMC1_DEV_GRP);
-		if (ret)
-			goto err;
-
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						vdd_sel, VMMC1_DEDICATED);
-		if (ret)
-			goto err;
+		ret = hsmmc_twl_set_voltage(c, vdd);
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
-
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if (vdd_sel == VMMC1_185V)
+		if ((1 << vdd) <= MMC_VDD_165_195)
 			reg &= ~OMAP2_PBIASLITEVMODE0;
 		else
 			reg |= OMAP2_PBIASLITEVMODE0;
 		omap_ctrl_writel(reg, control_pbias_offset);
-
-		return ret;
-
 	} else {
-		/* Power OFF */
-
-		/* For MMC1, Toggle PBIAS before every power up sequence */
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						LDO_CLR, VMMC1_DEV_GRP);
-		if (ret)
-			goto err;
-
-		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						VSEL_S2_CLR, VMMC1_DEDICATED);
-		if (ret)
-			goto err;
+		ret = hsmmc_twl_set_voltage(c, 0);
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
-
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
 			OMAP2_PBIASLITEVMODE0);
 		omap_ctrl_writel(reg, control_pbias_offset);
 	}
 
-	return 0;
+	return ret;
+}
 
-err:
-	return 1;
+static int hsmmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
+{
+	int ret;
+
+	struct hsmmc_controller *c = &hsmmc[1];
+
+	if (power_on) {
+		u32 reg;
+
+		reg = omap_ctrl_readl(c->control_devconf_offset);
+		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+		omap_ctrl_writel(reg, c->control_devconf_offset);
+		ret = hsmmc_twl_set_voltage(c, vdd);
+	} else {
+		ret = hsmmc_twl_set_voltage(c, 0);
+	}
+
+	return ret;
 }
 
 static struct omap_mmc_platform_data mmc1_data = {
@@ -272,9 +336,20 @@ static struct omap_mmc_platform_data mmc1_data = {
 	},
 };
 
+static struct omap_mmc_platform_data mmc2_data = {
+	.nr_slots			= 1,
+	.slots[0] = {
+		.set_power		= hsmmc2_set_power,
+		.ocr_mask		= MMC_VDD_27_28 | MMC_VDD_28_29 |
+					  MMC_VDD_29_30 | MMC_VDD_30_31 |
+					  MMC_VDD_31_32 | MMC_VDD_32_33,
+		.name			= "second slot",
+	},
+};
+
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC];
 
-void __init hsmmc_init(void)
+void __init hsmmc_init(int controller_mask)
 {
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -284,7 +359,12 @@ void __init hsmmc_init(void)
 		hsmmc[1].control_devconf_offset = OMAP343X_CONTROL_DEVCONF1;
 	}
 
-	hsmmc_data[0] = &mmc1_data;
+	if (controller_mask & HSMMC1)
+		hsmmc_data[0] = &mmc1_data;
+	if (controller_mask & HSMMC2)
+		hsmmc_data[1] = &mmc2_data;
+	if (controller_mask & HSMMC3)
+		pr_err("HSMMC: Unknown configuration for controller 3\n");
 	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
 }
 
diff --git a/arch/arm/plat-omap/include/mach/hsmmc.h b/arch/arm/plat-omap/include/mach/hsmmc.h
deleted file mode 100644
index 587e8ab..0000000
--- a/arch/arm/plat-omap/include/mach/hsmmc.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * include/asm-arm/arch-omap/hsmmc.h
- *
- * Hardware definitions for SD/MMC Controller on OMAP243x and OMAP34xx
- *
- * Initial creation by Felipe Balbi.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_OMAP_HSMMC_H
-#define __ASM_ARCH_OMAP_HSMMC_H
-
-extern void hsmmc_init(void);
-
-#endif /* __ASM_ARCH_OMAP_HSMMC_H */
-
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 2f20789..5e8ac72 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -30,6 +30,9 @@
 #define OMAP2_MMC1_BASE		0x4809c000
 #define OMAP2_MMC2_BASE		0x480b4000
 #define OMAP3_MMC3_BASE		0x480ad000
+#define HSMMC3			(1 << 2)
+#define HSMMC2			(1 << 1)
+#define HSMMC1			(1 << 0)
 
 #define OMAP_MMC_MAX_SLOTS	2
 
@@ -127,7 +130,11 @@ static inline int omap_mmc_add(int id, unsigned long base, unsigned long size,
 #endif
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-void __init hsmmc_init(void);
+void __init hsmmc_init(int controller_mask);
+#else
+static inline void hsmmc_init(void)
+{
+}
 #endif
 
 #endif
-- 
1.5.6.rc3.21.g8c6b5

