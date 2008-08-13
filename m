From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Wed, 13 Aug 2008 11:48:52 +0530 (IST)
Message-ID: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:38596 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYHMGS7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2008 02:18:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: OMAP3430 SDP HSMMC2 support.

This patch adds the necessary routines to 3430 sdp hsmmc file to support slot2.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    4
 arch/arm/mach-omap2/hsmmc.c         |  185 ++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-08-11
14:57:04.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-08-11
15:00:23.000000000 +0530
@@ -333,6 +333,10 @@ static struct omap_mmc_config sdp3430_mm
 		.enabled	= 1,
 		.wire4		= 1,
 	},
+	.mmc [1] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
 };

 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
Index: linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/hsmmc.c	2008-08-11
14:57:04.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c	2008-08-13 09:35:21.000000000 +0530
@@ -33,8 +33,11 @@
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
 #define GPIO_0_BIT_POS		(1 << 0)
+#define GPIO_1_BIT_POS		(1 << 1)
 #define MMC1_CD_IRQ		0
 #define MMC2_CD_IRQ		1
+#define VMMC2_DEV_GRP		0x2B
+#define VMMC2_DEDICATED		0x2E

 #define OMAP2_CONTROL_DEVCONF0	0x48002274
 #define OMAP2_CONTROL_DEVCONF1	0x490022E8
@@ -86,6 +89,41 @@ err:
 	return ret;
 }

+/*
+ * MMC2 Slot Initialization.
+ */
+static int hsmmc2_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	/*
+	 * Configure TWL4030 GPIO parameters for MMC2 hotplug irq
+	 */
+	ret = twl4030_request_gpio(MMC2_CD_IRQ);
+	if (ret != 0)
+		goto err;
+
+	ret = twl4030_set_gpio_edge_ctrl(MMC2_CD_IRQ,
+			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
+	if (ret != 0)
+		goto err;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
+						TWL_GPIO_PUPDCTR1);
+	if (ret != 0)
+		goto err;
+
+	ret = twl4030_set_gpio_debounce(MMC2_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
+	if (ret != 0)
+		goto err;
+
+	return ret;
+err:
+	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+
+	return ret;
+}
+
 static void hsmmc_cleanup(struct device *dev)
 {
 	int ret = 0;
@@ -95,6 +133,15 @@ static void hsmmc_cleanup(struct device
 		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
 }

+static void hsmmc2_cleanup(struct device *dev)
+{
+	int ret = 0;
+
+	ret = twl4030_free_gpio(MMC2_CD_IRQ);
+	if (ret != 0)
+		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+}
+
 #ifdef CONFIG_PM

 /*
@@ -140,6 +187,48 @@ static int hsmmc_suspend(struct device *
 	return ret;
 }

+/*
+ * To mask and unmask MMC Card Detect Interrupt
+ * mask : 1
+ * unmask : 0
+ */
+static int mask_cd2_interrupt(int mask)
+{
+	u8 reg = 0, ret = 0;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_IMR1A);
+	if (ret != 0)
+		goto err;
+
+	reg = (mask == 1) ? (reg | GPIO_1_BIT_POS) : (reg & ~GPIO_1_BIT_POS);
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_IMR1A);
+	if (ret != 0)
+		goto err;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_ISR1A);
+	if (ret != 0)
+		goto err;
+
+	reg = (mask == 1) ? (reg | GPIO_1_BIT_POS) : (reg & ~GPIO_1_BIT_POS);
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_ISR1A);
+	if (ret != 0)
+		goto err;
+err:
+	return ret;
+}
+
+static int hsmmc2_suspend(struct device *dev, int slot)
+{
+	int ret = 0;
+
+	disable_irq(TWL4030_GPIO_IRQ_NO(MMC2_CD_IRQ));
+	ret = mask_cd2_interrupt(1);
+
+	return ret;
+}
+
 static int hsmmc_resume(struct device *dev, int slot)
 {
 	int ret = 0;
@@ -150,6 +239,15 @@ static int hsmmc_resume(struct device *d
 	return ret;
 }

+static int hsmmc2_resume(struct device *dev, int slot)
+{
+	int ret = 0;
+
+	enable_irq(TWL4030_GPIO_IRQ_NO(MMC2_CD_IRQ));
+	ret = mask_cd2_interrupt(0);
+
+	return ret;
+}
 #endif

 static int hsmmc_set_power(struct device *dev, int slot, int power_on,
@@ -255,6 +353,70 @@ err:
 	return 1;
 }

+static int hsmmc2_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	u32 vdd_sel = 0, devconf = 0;
+	int ret = 0;
+
+	if (power_on == 1) {
+		if (cpu_is_omap24xx())
+			devconf = omap_readl(0x490022E8);
+		else
+			devconf = omap_readl(0x480022D8);
+
+		switch (1 << vdd) {
+		case MMC_VDD_33_34:
+		case MMC_VDD_32_33:
+			vdd_sel = VSEL_3V;
+			if (cpu_is_omap24xx())
+				devconf = (devconf | (1 << 31));
+			break;
+		case MMC_VDD_165_195:
+			vdd_sel = VSEL_18V;
+			if (cpu_is_omap24xx())
+				devconf = (devconf & ~(1 << 31));
+		}
+
+		if (cpu_is_omap24xx())
+			omap_writel(devconf, 0x490022E8);
+		else
+			omap_writel(devconf | 1 << 6, 0x480022D8);
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						P1_DEV_GRP, VMMC2_DEV_GRP);
+		if (ret != 0)
+			goto err;
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						0x05, VMMC2_DEDICATED);
+		if (ret != 0)
+			goto err;
+
+		return ret;
+
+	} else if (power_on == 0) {
+
+		/* Power OFF */
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						LDO_CLR, VMMC2_DEV_GRP);
+		if (ret != 0)
+			goto err;
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						VSEL_S2_CLR, VMMC2_DEDICATED);
+		if (ret != 0)
+			goto err;
+	} else {
+		ret = -1;
+		goto err;
+	}
+
+	return 0;
+err:
+	return 1;
+}
+
 static struct omap_mmc_platform_data hsmmc_data = {
 	.nr_slots			= 1,
 	.switch_slot			= NULL,
@@ -278,9 +440,32 @@ static struct omap_mmc_platform_data hsm
 	},
 };

+static struct omap_mmc_platform_data hsmmc2_data = {
+	.nr_slots			= 1,
+	.switch_slot			= NULL,
+	.init				= hsmmc2_late_init,
+	.cleanup			= hsmmc2_cleanup,
+#ifdef CONFIG_PM
+	.suspend			= hsmmc2_suspend,
+	.resume				= hsmmc2_resume,
+#endif
+	.slots[0] = {
+		.set_power		= hsmmc2_set_power,
+		.set_bus_mode		= NULL,
+		.get_ro			= NULL,
+		.get_cover_state	= NULL,
+		.ocr_mask		= MMC_VDD_165_195,
+		.name			= "first slot",
+
+		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(MMC2_CD_IRQ),
+		.card_detect            = hsmmc_card_detect,
+	},
+};
+
 void __init hsmmc_init(void)
 {
 	omap_set_mmc_info(1, &hsmmc_data);
+	omap_set_mmc_info(2, &hsmmc2_data);
 }

 #else


