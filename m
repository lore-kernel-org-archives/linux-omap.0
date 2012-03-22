From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 05/13] Remove regulator support from gmpc-smsc911x
Date: Wed, 21 Mar 2012 22:19:46 -0700
Message-ID: <1332393594-23993-6-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65308 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab2CVFU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:26 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so1236214obb.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:26 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Adding in support for regulators here creates several headaches.
 - Boards that declare their own regulator cannot use this function.
 - Multiple calls to this function require special handling.
 - Boards that declare id's other than '0' need special handling.

Now that there is a simple regulator_register_fixed, we can push
this registration back into the board files.

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |   55 -----------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index f9446ea..b6c77be 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -19,8 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
 
 #include <plat/board.h>
 #include <plat/gpmc.h>
@@ -41,50 +39,6 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
 };
 
-static struct regulator_consumer_supply gpmc_smsc911x_supply[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
-};
-
-/* Generic regulator definition to satisfy smsc911x */
-static struct regulator_init_data gpmc_smsc911x_reg_init_data = {
-	.constraints = {
-		.min_uV			= 3300000,
-		.max_uV			= 3300000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(gpmc_smsc911x_supply),
-	.consumer_supplies	= gpmc_smsc911x_supply,
-};
-
-static struct fixed_voltage_config gpmc_smsc911x_fixed_reg_data = {
-	.supply_name		= "gpmc_smsc911x",
-	.microvolts		= 3300000,
-	.gpio			= -EINVAL,
-	.startup_delay		= 0,
-	.enable_high		= 0,
-	.enabled_at_boot	= 1,
-	.init_data		= &gpmc_smsc911x_reg_init_data,
-};
-
-/*
- * Platform device id of 42 is a temporary fix to avoid conflicts
- * with other reg-fixed-voltage devices. The real fix should
- * involve the driver core providing a way of dynamically
- * assigning a unique id on registration for platform devices
- * in the same name space.
- */
-static struct platform_device gpmc_smsc911x_regulator = {
-	.name		= "reg-fixed-voltage",
-	.id		= 42,
-	.dev = {
-		.platform_data	= &gpmc_smsc911x_fixed_reg_data,
-	},
-};
-
 /*
  * Initialize smsc911x device connected to the GPMC. Note that we
  * assume that pin multiplexing is done in the board-*.c file,
@@ -96,15 +50,6 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 	unsigned long cs_mem_base;
 	int ret;
 
-	if (!gpmc_cfg->id) {
-		ret = platform_device_register(&gpmc_smsc911x_regulator);
-		if (ret < 0) {
-			pr_err("Unable to register smsc911x regulators: %d\n",
-			       ret);
-			return;
-		}
-	}
-
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
 		pr_err("Failed to request GPMC mem region\n");
 		return;
-- 
1.7.9.1

