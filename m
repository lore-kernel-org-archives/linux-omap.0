From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] Hook up twl4030 regulators to the relevant RX51 MMC slots.
Date: Fri, 13 Mar 2009 11:04:13 -0700
Message-ID: <20090313180412.1548.87222.stgit@localhost>
References: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62409 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZCMSEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:04:12 -0400
In-Reply-To: <20090313180123.1548.1188.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-flash.c       |   23 ------------
 arch/arm/mach-omap2/board-rx51-peripherals.c |   48 +++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-flash.c b/arch/arm/mach-omap2/board-rx51-flash.c
index 39b0659..fe9329d 100644
--- a/arch/arm/mach-omap2/board-rx51-flash.c
+++ b/arch/arm/mach-omap2/board-rx51-flash.c
@@ -10,34 +10,11 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/errno.h>
-
-#include "mmc-twl4030.h"
 
 extern void __init n800_flash_init(void);
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.name		= "external",
-		.mmc		= 1,
-		.wires		= 4,
-		.cover_only	= true,
-		.gpio_cd	= 160,
-		.gpio_wp	= -EINVAL,
-	},
-	{
-		.name		= "internal",
-		.mmc		= 2,
-		.wires		= 8,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-
 void __init rx51_flash_init(void)
 {
 	n800_flash_init();
-	twl4030_mmc_init(mmc);
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 88f9f43..b86e94d 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -28,7 +28,10 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 
-#define	SMC91X_CS			1
+#include "mmc-twl4030.h"
+
+
+#define SMC91X_CS			1
 #define SMC91X_GPIO_IRQ			54
 #define SMC91X_GPIO_RESET		164
 #define SMC91X_GPIO_PWRDWN		86
@@ -247,6 +250,37 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.name		= "external",
+		.mmc		= 1,
+		.wires		= 4,
+		.cover_only	= true,
+		.gpio_cd	= 160,
+		.gpio_wp	= -EINVAL,
+	},
+	{
+		.name		= "internal",
+		.mmc		= 2,
+		.wires		= 8,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{}	/* Terminator */
+};
+
+static struct regulator_consumer_supply rx51_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply rx51_vmmc2_supply = {
+	.supply			= "vmmc",
+};
+
+static struct regulator_consumer_supply rx51_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
 static struct regulator_init_data rx51_vaux1 = {
 	.constraints = {
 		.name			= "V28",
@@ -308,6 +342,8 @@ static struct regulator_init_data rx51_vmmc1 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &rx51_vmmc1_supply,
 };
 
 static struct regulator_init_data rx51_vmmc2 = {
@@ -322,6 +358,8 @@ static struct regulator_init_data rx51_vmmc2 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &rx51_vmmc2_supply,
 };
 
 static struct regulator_init_data rx51_vsim = {
@@ -335,6 +373,8 @@ static struct regulator_init_data rx51_vsim = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &rx51_vsim_supply,
 };
 
 static struct regulator_init_data rx51_vdac = {
@@ -357,7 +397,11 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 7, "speaker_en");
 	gpio_direction_output(gpio + 7, 1);
 
-	/* FIXME connect power supplies to devices; register MMC */
+	/* set up MMC adapters, linking their regulators to them */
+	twl4030_mmc_init(mmc);
+	rx51_vmmc1_supply.dev = mmc[0].dev;
+	rx51_vmmc2_supply.dev = mmc[1].dev;
+	rx51_vsim_supply.dev = mmc[1].dev;
 
 	return 0;
 }

