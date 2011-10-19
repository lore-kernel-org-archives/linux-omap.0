From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for ads7846
Date: Wed, 19 Oct 2011 11:39:17 +0200
Message-ID: <1319017160-20391-2-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49170
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754873Ab1JSJjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 05:39:40 -0400
In-Reply-To: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e15d39b..6d93db0 100644
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

