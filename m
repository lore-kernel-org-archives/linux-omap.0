From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
Date: Tue, 19 Aug 2014 08:24:05 -0700
Message-ID: <20140819152405.GA12002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53886 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbaHSPYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 11:24:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn
off oscillator during off-idle) added support for configuring the PMIC
to cut off resources during deeper idle states to save power.

This however caused regression for n900 display power that needed the
PMIC configuration to be disabled with commit d937678ab625 (ARM: dts:
Revert enabling of twl configuration for n900).

Turns out the root cause of the problem is that we must use
TWL4030_RESCONFIG_UNDEF instead of DEV_GRP_NULL to avoid disabling
regulators that may have been enabled before the init function
for twl4030-power.c runs. With TWL4030_RESCONFIG_UNDEF we let the
regulator framework control the regulators like it should. Here we
need to only configure the sys_clken and sys_off_mode triggers for
the regulators that cannot be done by the regulator framework as
it's not running at that point.

This allows us to enable the PMIC configuration for n900.

Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)
Cc: stable@vger.kernel.org # v3.16
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Lee, can you please pick this one for the v3.17-rc series?

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -361,7 +361,7 @@
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900";
+		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
 		ti,use_poweroff;
 	};
 };
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -724,24 +724,24 @@ static struct twl4030_script *omap3_idle_scripts[] = {
  * above.
  */
 static struct twl4030_resconfig omap3_idle_rconfig[] = {
-	TWL_REMAP_SLEEP(RES_VAUX1, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VAUX2, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VAUX3, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VAUX4, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VMMC1, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VMMC2, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX1, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX2, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX3, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX4, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VMMC1, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VMMC2, TWL4030_RESCONFIG_UNDEF, 0, 0),
 	TWL_REMAP_OFF(RES_VPLL1, DEV_GRP_P1, 3, 1),
 	TWL_REMAP_SLEEP(RES_VPLL2, DEV_GRP_P1, 0, 0),
-	TWL_REMAP_SLEEP(RES_VSIM, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VDAC, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VSIM, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VDAC, TWL4030_RESCONFIG_UNDEF, 0, 0),
 	TWL_REMAP_SLEEP(RES_VINTANA1, TWL_DEV_GRP_P123, 1, 2),
 	TWL_REMAP_SLEEP(RES_VINTANA2, TWL_DEV_GRP_P123, 0, 2),
 	TWL_REMAP_SLEEP(RES_VINTDIG, TWL_DEV_GRP_P123, 1, 2),
 	TWL_REMAP_SLEEP(RES_VIO, TWL_DEV_GRP_P123, 2, 2),
 	TWL_REMAP_OFF(RES_VDD1, DEV_GRP_P1, 4, 1),
 	TWL_REMAP_OFF(RES_VDD2, DEV_GRP_P1, 3, 1),
-	TWL_REMAP_SLEEP(RES_VUSB_1V5, DEV_GRP_NULL, 0, 0),
-	TWL_REMAP_SLEEP(RES_VUSB_1V8, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VUSB_1V5, TWL4030_RESCONFIG_UNDEF, 0, 0),
+	TWL_REMAP_SLEEP(RES_VUSB_1V8, TWL4030_RESCONFIG_UNDEF, 0, 0),
 	TWL_REMAP_SLEEP(RES_VUSB_3V1, TWL_DEV_GRP_P123, 0, 0),
 	/* Resource #20 USB charge pump skipped */
 	TWL_REMAP_SLEEP(RES_REGEN, TWL_DEV_GRP_P123, 2, 1),
