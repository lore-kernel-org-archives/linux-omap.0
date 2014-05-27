From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/6] mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle
Date: Tue, 27 May 2014 11:09:00 -0700
Message-ID: <1401214140-9828-7-git-send-email-tony@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401214140-9828-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some oscillators can be turned off during off-idle saving few
a little bit power at the cost of the oscillator start up
latency.

If you board can do this, you can now enable it by using the
ti,twl4030-power-idle-osc-off compatible flag.

Cc: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
index 4846c7b..3bc969a 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -761,6 +761,19 @@ static struct twl4030_power_data omap3_idle = {
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
@@ -770,6 +783,10 @@ static struct of_device_id twl4030_power_of_match[] = {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
