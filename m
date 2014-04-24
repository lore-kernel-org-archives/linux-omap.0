From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] mfd: twl4030power: Add a configuration to turn off oscillator during off-idle
Date: Wed, 23 Apr 2014 17:40:29 -0700
Message-ID: <1398300030-7386-4-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19777 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaDXAkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 20:40:37 -0400
In-Reply-To: <1398300030-7386-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

Some oscillators can be turned off during off-idle saving few
a little bit power at the cost of the oscillator start up
latency.

If you board can do this, you can now enable it by using the
ti,twl4030-power-idle-osc-off compatible flag.

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/mfd/twl4030-power.txt         |  6 ++++++
 drivers/mfd/twl4030-power.c                           | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
index bbd6603..b9ee7b9 100644
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
@@ -9,6 +9,7 @@ Required properties:
 	"ti,twl4030-power"
 	"ti,twl4030-power-reset"
 	"ti,twl4030-power-idle"
+	"ti,twl4030-power-idle-osc-off"
 
 The use of ti,twl4030-power-reset is recommended at least on
 3530 that needs a special configuration for warm reset to work.
@@ -16,6 +17,11 @@ The use of ti,twl4030-power-reset is recommended at least on
 When using ti,twl4030-power-idle, the TI recommended configuration
 for idle modes is loaded to the tlw4030 PMIC.
 
+When using ti,twl4030-power-idle-osc-off, the TI recommended
+configuration is used with the external oscillator being shut
+down during off-idle. Note that this does not work on all boards
+depending on how the external oscillator is wired.
+
 Optional properties:
 - ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-OFF or
 		   SLEEP-to-OFF transition when the system poweroffs.
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 89c6b1a..12e4abe 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -777,6 +777,21 @@ static struct twl4030_power_data omap3_idle = {
 	.resource_config	= omap3_idle_rconfig,
 };
 
+/* Disable 32 KiHz oscillator during idle */
+static struct twl4030_resconfig osc_off_rconfig[] = {
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 3, .type2 = 2, .remap_off = TWL_REMAP_OFF,
+	  .remap_sleep = TWL_REMAP_SLEEP, },
+	{ /* Terminator */ },
+};
+
+static struct twl4030_power_data osc_off_idle = {
+	.scripts		= omap3_idle_scripts,
+	.num			= ARRAY_SIZE(omap3_idle_scripts),
+	.resource_config	= omap3_idle_rconfig,
+	.board_config		= osc_off_rconfig,
+};
+
 static struct of_device_id twl4030_power_of_match[] = {
 	{
 		.compatible = "ti,twl4030-power-reset",
@@ -786,6 +801,10 @@ static struct of_device_id twl4030_power_of_match[] = {
 		.compatible = "ti,twl4030-power-idle",
 		.data = &omap3_idle,
 	},
+	{
+		.compatible = "ti,twl4030-power-idle-osc-off",
+		.data = &osc_off_idle,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
-- 
1.8.1.1

