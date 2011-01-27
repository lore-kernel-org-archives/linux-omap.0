From: "Reizer, Eyal" <eyalr@ti.com>
Subject: [PATCH] omap: omap3evm: add support for the WL12xx WLAN module to
 the AM/DM3xx Evaluation Module
Date: Thu, 27 Jan 2011 10:49:49 +0100
Message-ID: <EC51CDB0807A51469E0C9CB8CF72D65F032D484171@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1A0Jt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 04:49:56 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0R9nt97021428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 03:49:55 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p0R9ntHw011916
	for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 03:49:55 -0600 (CST)
Received: from DNCE73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p0R9npXB021259
	for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 03:49:55 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adds platform initialization for working with the WLAN module attached to the evaluation module.
The patch includes MMC2 initialization, SDIO and control pins muxing and platform device registration

Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   78 ++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 323c380..2d2092a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -30,6 +30,8 @@
 #include <linux/usb/otg.h>
 #include <linux/smsc911x.h>
 
+#include <linux/wl12xx.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/mmc/host.h>
 
@@ -381,6 +383,16 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
 	},
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+	{
+		.name		= "wl1271",
+		.mmc            = 2,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
+		.gpio_wp	= -EINVAL,
+		.gpio_cd	= -EINVAL,
+		.nonremovable	= true,
+	},
+#endif
 	{}	/* Terminator */
 };
 
@@ -538,6 +550,50 @@ static struct regulator_init_data omap3_evm_vpll2 = {
 	.consumer_supplies	= &omap3_evm_vpll2_supply,
 };
 
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+
+#define OMAP3EVM_WLAN_PMENA_GPIO	(150)
+#define OMAP3EVM_WLAN_IRQ_GPIO		(149)
+
+static struct regulator_consumer_supply omap3evm_vmmc2_supply = {
+	.supply			= "vmmc",
+	.dev_name		= "mmci-omap-hs.1",
+};
+
+/* VMMC2 for driving the WL12xx module */
+static struct regulator_init_data omap3evm_vmmc2 = {
+	.constraints = {
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies = &omap3evm_vmmc2_supply,
+};
+
+static struct fixed_voltage_config omap3evm_vwlan = {
+	.supply_name		= "vwl1271",
+	.microvolts		= 1800000, /* 1.80V */
+	.gpio			= OMAP3EVM_WLAN_PMENA_GPIO,
+	.startup_delay		= 70000, /* 70ms */
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &omap3evm_vmmc2,
+};
+
+static struct platform_device omap3evm_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &omap3evm_vwlan,
+	},
+};
+
+struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
+	.irq = OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
+	/* ref clock is 38.4 MHz */
+	.board_ref_clock = 2,
+};
+#endif
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -658,6 +714,21 @@ static struct omap_board_mux board_mux[] __initdata = {
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+	/* WLAN IRQ - GPIO 149 */
+	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
+	/* WLAN POWER ENABLE - GPIO 150 */
+	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+
+	/* MMC2 SDIO pin muxes for WL12xx */
+	OMAP3_MUX(SDMMC2_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+#endif
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #endif
@@ -715,6 +786,13 @@ static void __init omap3_evm_init(void)
 	ads7846_dev_init();
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
+
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+	/* WL12xx WLAN Init */
+	if (wl12xx_set_platform_data(&omap3evm_wlan_data))
+		pr_err("error setting wl12xx data\n");
+	platform_device_register(&omap3evm_vwlan_device);
+#endif
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
-- 
1.7.0.4

