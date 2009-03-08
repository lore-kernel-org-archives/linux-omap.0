From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap] omap3 boards list voltage ranges for VMMC1, VMMC2, VSIM
Date: Sun, 8 Mar 2009 11:44:39 -0800
Message-ID: <200903081244.39744.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:42581 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753126AbZCHTon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Mar 2009 15:44:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

It seems the regulator framework is going to require boards
to explicitly configure voltage ranges, instead of letting
them just pick up the entire available range.  So this patch
updates OMAP3 board handling for VMMC1, VMMC2, and VSIM.

Also, change the label for the MMC1 DAT4..DAT7 supply to
"vmmc_aux", so the label isn't specific to MMC1.  Things
like SDIO and eMMC chips may also need a second voltage,
though in that case it's usually 1.8V for chip interface.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
This should go with the patches headed to mainline too.

 arch/arm/mach-omap2/board-3430sdp.c     |   26 +++++++++++++++-----------
 arch/arm/mach-omap2/board-omap3beagle.c |   26 +++++++++++++++-----------
 arch/arm/mach-omap2/board-overo.c       |   12 +++++++-----
 3 files changed, 37 insertions(+), 27 deletions(-)

--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -335,7 +335,7 @@ static struct regulator_consumer_supply 
 };
 
 static struct regulator_consumer_supply sdp3430_vsim_supply = {
-	.supply			= "vmmc_dat4..7",
+	.supply			= "vmmc_aux",
 };
 
 static struct regulator_consumer_supply sdp3430_vmmc2_supply = {
@@ -528,11 +528,13 @@ static struct regulator_init_data sdp343
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data sdp3430_vmmc1 = {
 	.constraints = {
-		.valid_modes_mask = REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
 	.consumer_supplies	= &sdp3430_vmmc1_supply,
@@ -556,11 +558,13 @@ static struct regulator_init_data sdp343
 /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
 static struct regulator_init_data sdp3430_vsim = {
 	.constraints = {
-		.valid_modes_mask = REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
 	.consumer_supplies	= &sdp3430_vsim_supply,
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -131,7 +131,7 @@ static struct regulator_consumer_supply 
 };
 
 static struct regulator_consumer_supply beagle_vsim_supply = {
-	.supply			= "vmmc_dat4..7",
+	.supply			= "vmmc_aux",
 };
 
 static struct gpio_led gpio_leds[];
@@ -179,11 +179,13 @@ static struct twl4030_gpio_platform_data
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data beagle_vmmc1 = {
 	.constraints = {
-		.valid_modes_mask = REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
 	.consumer_supplies	= &beagle_vmmc1_supply,
@@ -192,11 +194,13 @@ static struct regulator_init_data beagle
 /* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
 static struct regulator_init_data beagle_vsim = {
 	.constraints = {
-		.valid_modes_mask = REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
 	.consumer_supplies	= &beagle_vsim_supply,
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -279,11 +279,13 @@ static struct twl4030_usb_data overo_usb
 
 static struct regulator_init_data overo_vmmc1 = {
 	.constraints = {
-		.valid_modes_mask = REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
-				| REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
