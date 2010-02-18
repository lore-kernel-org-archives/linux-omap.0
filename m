From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/23] IGEPv2: Added WIFI support
Date: Wed, 17 Feb 2010 17:32:30 -0800
Message-ID: <20100218013230.32075.7435.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59215 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072Ab0BRBbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:41 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jonas Zetterberg <jozz@jozz.se>, linux-omap@vger.kernel.org, Anders Hedlund <anders.j.hedlund@gmail.com>

From: Jonas Zetterberg <jozz@jozz.se>

Enabled VMMC2 LDO voltage regulator on TWL4030.
Added GPIO's (power down and reset) for WIFI chip.

Signed-off-by: Anders Hedlund <anders.j.hedlund@gmail.com>
Signed-off-by: Jonas Zetterberg <jozz@jozz.se>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   40 ++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3d1fde7..4a5d663 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -42,6 +42,8 @@
 #define IGEP2_GPIO_LED0_GREEN 	27
 #define IGEP2_GPIO_LED1_RED   	28
 #define IGEP2_GPIO_DVI_PUP	170
+#define IGEP2_GPIO_WIFI_NPD 	94
+#define IGEP2_GPIO_WIFI_NRESET 	95
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
@@ -209,6 +211,10 @@ static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
 
+static struct regulator_consumer_supply igep2_vmmc2_supply = {
+	.supply		= "vmmc",
+};
+
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep2_vmmc1 = {
 	.constraints = {
@@ -224,6 +230,21 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
+/* VMMC2 for OMAP VDD_MMC2 (i/o) and MMC2 WIFI */
+static struct regulator_init_data igep2_vmmc2 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &igep2_vmmc2_supply,
+};
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -251,6 +272,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	 * regulators will be set up only *after* we return.
 	*/
 	igep2_vmmc1_supply.dev = mmc[0].dev;
+	igep2_vmmc2_supply.dev = mmc[1].dev;
 
 	return 0;
 };
@@ -364,6 +386,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_gpio_data,
 	.vmmc1          = &igep2_vmmc1,
+	.vmmc2		= &igep2_vmmc2,
 	.vpll2		= &igep2_vpll2,
 
 };
@@ -440,6 +463,23 @@ static void __init igep2_init(void)
 		gpio_set_value(IGEP2_GPIO_LED1_RED, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
+
+	/* GPIO W-LAN + Bluetooth combo module */
+	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
+	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {
+		gpio_export(IGEP2_GPIO_WIFI_NPD, 0);
+/* 		gpio_set_value(IGEP2_GPIO_WIFI_NPD, 0); */
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NPD\n");
+
+	if ((gpio_request(IGEP2_GPIO_WIFI_NRESET, "GPIO_WIFI_NRESET") == 0) &&
+	    (gpio_direction_output(IGEP2_GPIO_WIFI_NRESET, 1) == 0)) {
+		gpio_export(IGEP2_GPIO_WIFI_NRESET, 0);
+		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 0);
+		udelay(10);
+		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 1);
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NRESET\n");
 }
 
 static void __init igep2_map_io(void)

