From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] mfd: twl4030power: Add a configuration to turn off oscillator during off-idle
Date: Tue, 13 May 2014 18:34:09 -0700
Message-ID: <1400031250-29542-7-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44811 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752453AbaENBeX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 21:34:23 -0400
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

Some oscillators can be turned off during off-idle saving few
a little bit power at the cost of the oscillator start up
latency.

If you board can do this, you can now enable it by using the
ti,twl4030-power-idle-osc-off compatible flag.

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/mfd/twl4030-power.txt |  6 ++++++
 drivers/mfd/twl4030-power.c                             | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

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
index 4b3f192..4341961 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -748,6 +748,19 @@ static struct twl4030_power_data omap3_idle = {
 	.resource_config	= omap3_idle_rconfig,
 };
 
+/* Disable 32 KiHz oscillator during idle */
+static struct twl4030_resconfig osc_off_rconfig[] = {
+	TWL_REMAP_OFF(RES_CLKEN, DEV_GRP_P1 | DEV_GRP_P3, 3, 2),
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
@@ -757,6 +770,10 @@ static struct of_device_id twl4030_power_of_match[] = {
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

