From: Matt Porter <mporter@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x regulators
Date: Mon, 13 Feb 2012 11:43:42 -0500
Message-ID: <1329151422-2146-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes smsc911x support on platforms using gpmc_smsc911x_init().
Commit c7e963f6888816f04d1f5da0e07bec4e0092f227 added the requirement
that platforms provide vdd33a and vddvario supplies.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |   44 +++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 9970331..da8399e 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 
 #include <plat/board.h>
 #include <plat/gpmc.h>
@@ -42,6 +44,43 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
 	.flags		= SMSC911X_USE_16BIT,
 };
 
+static struct regulator_consumer_supply gpmc_smsc911x_supply[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
+/* Generic regulator definition to satisfy smsc911x */
+static struct regulator_init_data gpmc_smsc911x_reg_init_data = {
+	.constraints = {
+		.min_uV			= 3300000,
+		.max_uV			= 3300000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(gpmc_smsc911x_supply),
+	.consumer_supplies	= gpmc_smsc911x_supply,
+};
+
+static struct fixed_voltage_config gpmc_smsc911x_fixed_reg_data = {
+	.supply_name		= "gpmc_smsc911x",
+	.microvolts		= 3300000,
+	.gpio			= -EINVAL,
+	.startup_delay		= 0,
+	.enable_high		= 0,
+	.enabled_at_boot	= 1,
+	.init_data		= &gpmc_smsc911x_reg_init_data,
+};
+
+static struct platform_device gpmc_smsc911x_regulator = {
+	.name		= "reg-fixed-voltage",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &gpmc_smsc911x_fixed_reg_data,
+	},
+};
+
 /*
  * Initialize smsc911x device connected to the GPMC. Note that we
  * assume that pin multiplexing is done in the board-*.c file,
@@ -55,6 +94,11 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 
 	gpmc_cfg = board_data;
 
+	if (platform_device_register(&gpmc_smsc911x_regulator) < 0) {
+		pr_err("Unable to register smsc911x regulators\n");
+		return;
+	}
+
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
 		pr_err("Failed to request GPMC mem region\n");
 		return;
-- 
1.7.5.4
