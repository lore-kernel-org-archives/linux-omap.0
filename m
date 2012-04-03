From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
Date: Tue, 3 Apr 2012 10:43:17 -0700
Message-ID: <20120403174317.GE8240@atomide.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
 <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
 <4F71E290.2050403@compulab.co.il>
 <CA+Bv8XYiv+gr4yB+k7sWSSjdYSsYdnRJuTO3A5zZhh4bkoziXw@mail.gmail.com>
 <4F72B0F5.4080705@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49750 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab2DCRnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 13:43:24 -0400
Content-Disposition: inline
In-Reply-To: <4F72B0F5.4080705@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Igor Grinberg <grinberg@compulab.co.il> [120327 23:37]:
> On 03/27/12 20:32, Russ Dill wrote:
> > No objection.
> 
> 10x Russ.

I've combined patches 5 - 12 into a single patch as they
pretty much do the same thing, and to cut down
the patch noise for fixes. Merging into fixes with the
updated patch below.

Regards,

Tony


From: Russ Dill <Russ.Dill@ti.com>
Date: Fri, 23 Mar 2012 02:21:37 -0700
Subject: [PATCH] ARM: OMAP2+: smsc911x: Add fixed board regulators

Initialize fixed regulators in the board files. Trying to
do this in a generic way in gpmc-smsc911x.c gets messy as
the regulator may be provided by drivers, such as twl4030,
for some boards.

Signed-off-by: Russ Dill <russ.dill@ti.com>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
[tony@atomide.com: combined into one patch, updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 41b0a2f..909a8b9 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -26,6 +26,7 @@
 
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/mmc/host.h>
 
@@ -81,8 +82,23 @@ static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg = {
 	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
+static struct regulator_consumer_supply cm_t35_smsc911x_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
+static struct regulator_consumer_supply sb_t35_smsc911x_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 static void __init cm_t35_init_ethernet(void)
 {
+	regulator_register_fixed(0, cm_t35_smsc911x_supplies,
+				 ARRAY_SIZE(cm_t35_smsc911x_supplies));
+	regulator_register_fixed(1, sb_t35_smsc911x_supplies,
+				 ARRAY_SIZE(sb_t35_smsc911x_supplies));
+
 	gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
 	gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
 }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index e558800..930c0d3 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -634,8 +634,14 @@ static void __init igep_wlan_bt_init(void)
 static inline void __init igep_wlan_bt_init(void) { }
 #endif
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init igep_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d50a562..1b60495 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/io.h>
@@ -410,8 +411,14 @@ static struct mtd_partition ldp_nand_partitions[] = {
 
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap_ldp_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	ldp_init_smsc911x();
 	omap_i2c_init();
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b90b319..49df127 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -623,9 +623,15 @@ static void __init omap3_evm_wl12xx_init(void)
 #endif
 }
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
 	if (cpu_is_omap3630())
 		omap3_mux_init(omap36x_board_mux, OMAP_PACKAGE_CBB);
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4a7d8c8..9b3c141 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c/twl.h>
@@ -188,8 +189,14 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap3logic_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index de95352..4dffc95 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
@@ -410,8 +411,14 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap3_stalker_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 668533e..33aa391 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -498,10 +498,18 @@ static struct gpio overo_bt_gpios[] __initdata = {
 	{ OVERO_GPIO_BT_NRESET, GPIOF_OUT_INIT_HIGH,	"lcd bl enable" },
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 static void __init overo_init(void)
 {
 	int ret;
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_hsmmc_init(mmc);
 	overo_i2c_init();
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 1e8540e..f64f441 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -14,6 +14,9 @@
 #include <linux/smsc911x.h>
 #include <linux/interrupt.h>
 
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
 
@@ -117,11 +120,17 @@ static struct platform_device *zoom_devices[] __initdata = {
 	&zoom_debugboard_serial_device,
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 int __init zoom_debugboard_init(void)
 {
 	if (!omap_zoom_debugboard_detect())
 		return 0;
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	zoom_init_smsc911x();
 	zoom_init_quaduart();
 	return platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
