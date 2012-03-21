From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x devices.
Date: Wed, 21 Mar 2012 10:55:54 -0700
Message-ID: <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
References: <4F6324D5.9010106@uni-dortmund.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58411 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab2CUR4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 13:56:15 -0400
Received: by gghe5 with SMTP id e5so1185970ggh.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 10:56:14 -0700 (PDT)
In-Reply-To: <4F6324D5.9010106@uni-dortmund.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mporter@ti.com, tony@atomide.com, robert.marklund@stericsson.com, broonie@opensource.wolfsonmicro.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>

Commit c7e963f6888816 (net/smsc911x: Add regulator support) breaks
registration of gpmc connected smcs911x devices on machines with
regulator support, but without dummy regulator support.

Commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add
required smsc911x regulators) fixed the issue for boards with single
smsc911x devices, but attempted to register the fixed voltage regulator
twice for boards with 2 devices which fails.

A proper fix needs to supply a proper regulator/consumer mapping for
each smsc911x device. The below patch does that. However, it also
points out how unmanageable things will become if regulators are required
for each and every device for the sake of the one board where they need
to be enabled.

In the case of the smsc911x driver, the ST-Ericsson Snowball has regulators
that need to be powered up for the smsc911x to function. Robert Marklund
added functionality to the smsc911x driver to power up its regulators at
probe time and power them off at remove time. One can see how quickly
unwieldy this would become if it were done for every device. Either the
functionality needs to be moved to Snowball board init code, or a generic
framework needs to be made for attaching regulators to arbitrary devices.

Incidentally, while the patch for the smsc911x regulators is in, it does not
appear that the patch for the snowball to supply these is in.

This patch has been compile tested, but not run tested.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c              |   34 +++++-----
 arch/arm/mach-omap2/board-igep0020.c            |   15 +++--
 arch/arm/mach-omap2/board-ldp.c                 |   14 ++--
 arch/arm/mach-omap2/board-omap3evm.c            |   21 ++++--
 arch/arm/mach-omap2/board-omap3logic.c          |   18 +++--
 arch/arm/mach-omap2/board-omap3stalker.c        |   15 +++--
 arch/arm/mach-omap2/board-overo.c               |   32 +++++-----
 arch/arm/mach-omap2/board-zoom-debugboard.c     |   14 ++--
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   79 +++++++++++++++++------
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    6 +-
 10 files changed, 154 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d73316e..4090ca1 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -65,26 +65,28 @@
 #include <linux/smsc911x.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
-	.id		= 0,
-	.cs             = CM_T35_SMSC911X_CS,
-	.gpio_irq       = CM_T35_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
-};
-
-static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg = {
-	.id		= 1,
-	.cs             = SB_T35_SMSC911X_CS,
-	.gpio_irq       = SB_T35_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+static struct omap_smsc911x_platform_data cm_smsc911x_cfg[] = {
+	{
+		.id		= 0,
+		.cs             = CM_T35_SMSC911X_CS,
+		.gpio_irq       = CM_T35_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT
+				| SMSC911X_SAVE_MAC_ADDRESS,
+	},
+	{
+		.id		= 1,
+		.cs             = SB_T35_SMSC911X_CS,
+		.gpio_irq       = SB_T35_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT
+				| SMSC911X_SAVE_MAC_ADDRESS,
+	}
 };
 
 static void __init cm_t35_init_ethernet(void)
 {
-	gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
-	gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
+	gpmc_smsc911x_init(cm_smsc911x_cfg, ARRAY_SIZE(cm_smsc911x_cfg));
 }
 #else
 static inline void __init cm_t35_init_ethernet(void) { return; }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a59ace0..b5523b5 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -206,16 +206,19 @@ static void __init igep_flash_init(void) {}
 #include <linux/smsc911x.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.cs             = IGEP2_SMSC911X_CS,
-	.gpio_irq       = IGEP2_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+static struct omap_smsc911x_platform_data smsc911x_cfg[] = {
+	{
+		.cs             = IGEP2_SMSC911X_CS,
+		.gpio_irq       = IGEP2_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT
+				| SMSC911X_SAVE_MAC_ADDRESS,
+	},
 };
 
 static inline void __init igep2_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	gpmc_smsc911x_init(smsc911x_cfg, ARRAY_SIZE(smsc911x_cfg));
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 2d2a61f..af67098 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -171,16 +171,18 @@ static struct platform_device ldp_gpio_keys_device = {
 	},
 };
 
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.cs             = LDP_SMSC911X_CS,
-	.gpio_irq       = LDP_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT,
+static struct omap_smsc911x_platform_data smsc911x_cfg[] = {
+	{
+		.cs             = LDP_SMSC911X_CS,
+		.gpio_irq       = LDP_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT,
+	},
 };
 
 static inline void __init ldp_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	gpmc_smsc911x_init(smsc911x_cfg, ARRAY_SIZE(smsc911x_cfg));
 }
 
 /* LCD */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c877236..76543b3 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -105,11 +105,14 @@ static void __init omap3_evm_get_revision(void)
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.cs             = OMAP3EVM_SMSC911X_CS,
-	.gpio_irq       = OMAP3EVM_ETHR_GPIO_IRQ,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+static struct omap_smsc911x_platform_data smsc911x_cfg[] = {
+	{
+		.cs             = OMAP3EVM_SMSC911X_CS,
+		.gpio_irq       = OMAP3EVM_ETHR_GPIO_IRQ,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT
+				| SMSC911X_SAVE_MAC_ADDRESS,
+	},
 };
 
 static inline void __init omap3evm_init_smsc911x(void)
@@ -126,12 +129,14 @@ static inline void __init omap3evm_init_smsc911x(void)
 	/* Configure ethernet controller reset gpio */
 	if (cpu_is_omap3430()) {
 		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
-			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN1_ETHR_GPIO_RST;
+			smsc911x_cfg[0].gpio_reset =
+				OMAP3EVM_GEN1_ETHR_GPIO_RST;
 		else
-			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
+			smsc911x_cfg[0].gpio_reset =
+				OMAP3EVM_GEN2_ETHR_GPIO_RST;
 	}
 
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	gpmc_smsc911x_init(smsc911x_cfg, ARRAY_SIZE(smsc911x_cfg));
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4198dd0..20b3cd2 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -131,10 +131,12 @@ static void __init board_mmc_init(void)
 	omap2_hsmmc_init(board_mmc_info);
 }
 
-static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
-	.cs             = OMAP3LOGIC_SMSC911X_CS,
-	.gpio_irq       = -EINVAL,
-	.gpio_reset     = -EINVAL,
+static struct omap_smsc911x_platform_data __initdata board_smsc911x_data[] = {
+	{
+		.cs             = OMAP3LOGIC_SMSC911X_CS,
+		.gpio_irq       = -EINVAL,
+		.gpio_reset     = -EINVAL,
+	},
 };
 
 /* TODO/FIXME (comment by Peter Barada, LogicPD):
@@ -166,12 +168,13 @@ static inline void __init board_smsc911x_init(void)
 {
 	if (machine_is_omap3530_lv_som()) {
 		/* OMAP3530 LV SOM board */
-		board_smsc911x_data.gpio_irq =
+		board_smsc911x_data[0].gpio_irq =
 					OMAP3530_LV_SOM_SMSC911X_GPIO_IRQ;
 		omap_mux_init_signal("gpio_152", OMAP_PIN_INPUT);
 	} else if (machine_is_omap3_torpedo()) {
 		/* OMAP3 Torpedo board */
-		board_smsc911x_data.gpio_irq = OMAP3_TORPEDO_SMSC911X_GPIO_IRQ;
+		board_smsc911x_data[0].gpio_irq =
+					OMAP3_TORPEDO_SMSC911X_GPIO_IRQ;
 		omap_mux_init_signal("gpio_129", OMAP_PIN_INPUT);
 	} else {
 		/* unsupported board */
@@ -179,7 +182,8 @@ static inline void __init board_smsc911x_init(void)
 		return;
 	}
 
-	gpmc_smsc911x_init(&board_smsc911x_data);
+	gpmc_smsc911x_init(board_smsc911x_data,
+		ARRAY_SIZE(board_smsc911x_data));
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index cb089a4..0489826 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -63,11 +63,14 @@
 #define OMAP3STALKER_ETHR_GPIO_IRQ	19
 #define OMAP3STALKER_SMC911X_CS	5
 
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.cs             = OMAP3STALKER_SMC911X_CS,
-	.gpio_irq       = OMAP3STALKER_ETHR_GPIO_IRQ,
-	.gpio_reset     = -EINVAL,
-	.flags		= (SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS),
+static struct omap_smsc911x_platform_data smsc911x_cfg[] = {
+	{
+		.cs             = OMAP3STALKER_SMC911X_CS,
+		.gpio_irq       = OMAP3STALKER_ETHR_GPIO_IRQ,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT
+				| SMSC911X_SAVE_MAC_ADDRESS,
+	},
 };
 
 static inline void __init omap3stalker_init_eth(void)
@@ -82,7 +85,7 @@ static inline void __init omap3stalker_init_eth(void)
 		rate = clk_get_rate(l3ck);
 
 	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	gpmc_smsc911x_init(smsc911x_cfg, ARRAY_SIZE(smsc911x_cfg));
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52c0cef..f4f5b7a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -118,26 +118,26 @@ static inline void __init overo_ads7846_init(void) { return; }
 #include <linux/smsc911x.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.id		= 0,
-	.cs             = OVERO_SMSC911X_CS,
-	.gpio_irq       = OVERO_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT,
-};
-
-static struct omap_smsc911x_platform_data smsc911x2_cfg = {
-	.id		= 1,
-	.cs             = OVERO_SMSC911X2_CS,
-	.gpio_irq       = OVERO_SMSC911X2_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT,
+static struct omap_smsc911x_platform_data smsc911x_cfg[] = {
+	{
+		.id		= 0,
+		.cs             = OVERO_SMSC911X_CS,
+		.gpio_irq       = OVERO_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT,
+	},
+	{
+		.id		= 1,
+		.cs             = OVERO_SMSC911X2_CS,
+		.gpio_irq       = OVERO_SMSC911X2_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT,
+	}
 };
 
 static void __init overo_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
-	gpmc_smsc911x_init(&smsc911x2_cfg);
+	gpmc_smsc911x_init(smsc911x_cfg, ARRAY_SIZE(smsc911x_cfg));
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 369c2eb..8860dac 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -28,16 +28,18 @@
 #define DEBUG_BASE		0x08000000
 #define ZOOM_ETHR_START	DEBUG_BASE
 
-static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
-	.cs             = ZOOM_SMSC911X_CS,
-	.gpio_irq       = ZOOM_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT,
+static struct omap_smsc911x_platform_data zoom_smsc911x_cfg[] = {
+	{
+		.cs             = ZOOM_SMSC911X_CS,
+		.gpio_irq       = ZOOM_SMSC911X_GPIO,
+		.gpio_reset     = -EINVAL,
+		.flags		= SMSC911X_USE_32BIT,
+	},
 };
 
 static inline void __init zoom_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&zoom_smsc911x_cfg);
+	gpmc_smsc911x_init(zoom_smsc911x_cfg, ARRAY_SIZE(zoom_smsc911x_cfg));
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index bbb870c..9085fcf 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -26,8 +26,6 @@
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct omap_smsc911x_platform_data *gpmc_cfg;
-
 static struct resource gpmc_smsc911x_resources[] = {
 	[0] = {
 		.flags		= IORESOURCE_MEM,
@@ -41,12 +39,6 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_16BIT,
-};
-
-static struct regulator_consumer_supply gpmc_smsc911x_supply[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
 };
 
 /* Generic regulator definition to satisfy smsc911x */
@@ -59,8 +51,6 @@ static struct regulator_init_data gpmc_smsc911x_reg_init_data = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(gpmc_smsc911x_supply),
-	.consumer_supplies	= gpmc_smsc911x_supply,
 };
 
 static struct fixed_voltage_config gpmc_smsc911x_fixed_reg_data = {
@@ -93,20 +83,13 @@ static struct platform_device gpmc_smsc911x_regulator = {
  * assume that pin multiplexing is done in the board-*.c file,
  * or in the bootloader.
  */
-void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
+static void __init gpmc_smsc911x_init_one(
+		struct omap_smsc911x_platform_data *gpmc_cfg)
 {
 	struct platform_device *pdev;
 	unsigned long cs_mem_base;
 	int ret;
 
-	gpmc_cfg = board_data;
-
-	ret = platform_device_register(&gpmc_smsc911x_regulator);
-	if (ret < 0) {
-		pr_err("Unable to register smsc911x regulators: %d\n", ret);
-		return;
-	}
-
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
 		pr_err("Failed to request GPMC mem region\n");
 		return;
@@ -136,8 +119,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
 	}
 
-	if (gpmc_cfg->flags)
-		gpmc_smsc911x_config.flags = gpmc_cfg->flags;
+	gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
 
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
@@ -157,3 +139,58 @@ free1:
 
 	pr_err("Could not initialize smsc911x device\n");
 }
+
+static const char * const smsc911x_refs[] = {
+	"vddvario",
+	"vdd33a",
+};
+
+void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data,
+		unsigned int num)
+{
+	int ret;
+	int i;
+	struct regulator_consumer_supply *supplies;
+
+	supplies = kcalloc(ARRAY_SIZE(smsc911x_refs) * num,
+			sizeof(struct regulator_consumer_supply), GFP_KERNEL);
+	if (!supplies) {
+		pr_err("Failed to allocate memory\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(smsc911x_refs) * num; i++) {
+		int id;
+		char *name;
+
+		id = board_data[i / num].id;
+		if (id != -1)
+			name = kasprintf(GFP_KERNEL, "smsc911x.%d", id);
+		else
+			name = kstrdup("smsc911x", GFP_KERNEL);
+		if (!name) {
+			pr_err("Failed to allocate memory\n");
+			goto out;
+		}
+
+		supplies[i].dev_name = name;
+		supplies[i].supply = smsc911x_refs[i % num];
+	}
+
+	gpmc_smsc911x_reg_init_data.num_consumer_supplies = num;
+	gpmc_smsc911x_reg_init_data.consumer_supplies = supplies;
+
+	ret = platform_device_register(&gpmc_smsc911x_regulator);
+	if (ret < 0) {
+		pr_err("Unable to register smsc911x regulators: %d\n", ret);
+		goto out;
+	}
+
+	for (i = 0; i < num; i++)
+		gpmc_smsc911x_init_one(&board_data[i]);
+
+out:
+	for (i = 0; i < ARRAY_SIZE(smsc911x_refs) * num; i++)
+		kfree(supplies[i].dev_name);
+	kfree(supplies);
+}
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index ea6c9c8..16c709f 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -23,11 +23,13 @@ struct omap_smsc911x_platform_data {
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
-extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
+extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d,
+	unsigned int num);
 
 #else
 
-static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
+static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d,
+	unsigned int num)
 {
 }
 
-- 
1.7.9.1

