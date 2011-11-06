From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 1/4] ARM: OMAP3: cm-t35: fix ads7846 touchscreen
Date: Sun,  6 Nov 2011 16:16:23 +0200
Message-ID: <1320588986-9480-1-git-send-email-grinberg@compulab.co.il>
References: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47327
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752335Ab1KFOQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 09:16:41 -0500
In-Reply-To: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

ads7846 driver fails to find the regulator supply and
as a result the touchscreen is not working.
Fix this by adding a regulator supply for the ads7846 driver.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2:	- Rebase on top of fixes branch
	- Elaborate on the problem in the commit message

 arch/arm/mach-omap2/board-cm-t35.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index bd1bcac..7141cb6 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -343,6 +343,10 @@ static struct regulator_consumer_supply cm_t35_vdvi_supply[] = {
 	REGULATOR_SUPPLY("vdvi", "omapdss"),
 };
 
+static struct regulator_consumer_supply cm_t35_vio_supplies[] = {
+	REGULATOR_SUPPLY("vcc", "spi1.0"),
+};
+
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data cm_t35_vmmc1 = {
 	.constraints = {
@@ -373,6 +377,19 @@ static struct regulator_init_data cm_t35_vsim = {
 	.consumer_supplies	= cm_t35_vsim_supply,
 };
 
+static struct regulator_init_data cm_t35_vio = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(cm_t35_vio_supplies),
+	.consumer_supplies	= cm_t35_vio_supplies,
+};
+
 static uint32_t cm_t35_keymap[] = {
 	KEY(0, 0, KEY_A),	KEY(0, 1, KEY_B),	KEY(0, 2, KEY_LEFT),
 	KEY(1, 0, KEY_UP),	KEY(1, 1, KEY_ENTER),	KEY(1, 2, KEY_DOWN),
@@ -456,6 +473,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.gpio		= &cm_t35_gpio_data,
 	.vmmc1		= &cm_t35_vmmc1,
 	.vsim		= &cm_t35_vsim,
+	.vio		= &cm_t35_vio,
 };
 
 static void __init cm_t35_init_i2c(void)
-- 
1.7.3.4

