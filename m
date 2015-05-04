From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix pmic for boards that need AC
 charger disabled
Date: Mon, 4 May 2015 07:32:14 -0700
Message-ID: <20150504143213.GF24469@atomide.com>
References: <1427736974-1842-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427736974-1842-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Lee,

* Tony Lindgren <tony@atomide.com> [150330 10:41]:
> I noticed the PMIC configuration on 37xx-evm won't actually shut down
> the voltages during off-idle. Turns out 37xx-evm needs the AC charger
> state transitions disabled like we are doing for SDP and LDP in the
> legacy booting case.
> 
> Let's fix this for device tree based booting by setting up the quirk
> flag based on the compatible flag. And let's also use the existing
> define for STARTON_CHG.
> 
> Note that SDP and EVM do not have the PMIC clken wired to gate the
> the oscillator while LDP has.

Looks like this fix is still pending?

Seems to require a minor update for the const changes, updated
version below.

Regards,

Tony

8< ------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Apr 2015 10:18:14 -0700
Subject: [PATCH] mfd: twl4030-power: Fix pmic for boards that need AC charger
 disabled

I noticed the PMIC configuration on 37xx-evm won't actually shut down
the voltages during off-idle. Turns out 37xx-evm needs the AC charger
state transitions disabled like we are doing for SDP and LDP in the
legacy booting case.

Let's fix this for device tree based booting by setting up the quirk
flag based on the compatible flag. And let's also use the existing
define for STARTON_CHG.

Note that SDP and EVM do not have the PMIC clken wired to gate the
the oscillator while LDP has.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -264,7 +264,9 @@ out:
 	return err;
 }
 
-static int twl4030_config_wakeup12_sequence(u8 address)
+static int
+twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pdata,
+				 u8 address)
 {
 	int err = 0;
 	u8 data;
@@ -293,13 +295,14 @@ static int twl4030_config_wakeup12_sequence(u8 address)
 	if (err)
 		goto out;
 
-	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
+	if (pdata->ac_charger_quirk || machine_is_omap_3430sdp() ||
+	    machine_is_omap_ldp()) {
 		/* Disabling AC charger effect on sleep-active transitions */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data,
 				      R_CFG_P1_TRANSITION);
 		if (err)
 			goto out;
-		data &= ~(1<<1);
+		data &= ~STARTON_CHG;
 		err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data,
 				       R_CFG_P1_TRANSITION);
 		if (err)
@@ -459,8 +462,9 @@ static int twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	return 0;
 }
 
-static int load_twl4030_script(struct twl4030_script *tscript,
-	       u8 address)
+static int load_twl4030_script(const struct twl4030_power_data *pdata,
+			       struct twl4030_script *tscript,
+			       u8 address)
 {
 	int err;
 	static int order;
@@ -487,7 +491,7 @@ static int load_twl4030_script(struct twl4030_script *tscript,
 		if (err)
 			goto out;
 
-		err = twl4030_config_wakeup12_sequence(address);
+		err = twl4030_config_wakeup12_sequence(pdata, address);
 		if (err)
 			goto out;
 		order = 1;
@@ -567,7 +571,7 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
 	u8 address = twl4030_start_script_address;
 
 	for (i = 0; i < pdata->num; i++) {
-		err = load_twl4030_script(pdata->scripts[i], address);
+		err = load_twl4030_script(pdata, pdata->scripts[i], address);
 		if (err)
 			return err;
 		address += pdata->scripts[i]->size;
@@ -829,6 +833,21 @@ static struct twl4030_power_data osc_off_idle = {
 	.board_config		= osc_off_rconfig,
 };
 
+static struct twl4030_power_data omap3_idle_ac_quirk = {
+	.scripts		= omap3_idle_scripts,
+	.num			= ARRAY_SIZE(omap3_idle_scripts),
+	.resource_config	= omap3_idle_rconfig,
+	.ac_charger_quirk	= true,
+};
+
+static struct twl4030_power_data omap3_idle_ac_quirk_osc_off = {
+	.scripts		= omap3_idle_scripts,
+	.num			= ARRAY_SIZE(omap3_idle_scripts),
+	.resource_config	= omap3_idle_rconfig,
+	.board_config		= osc_off_rconfig,
+	.ac_charger_quirk	= true,
+};
+
 static const struct of_device_id twl4030_power_of_match[] = {
 	{
 		.compatible = "ti,twl4030-power",
@@ -845,6 +864,18 @@ static const struct of_device_id twl4030_power_of_match[] = {
 		.compatible = "ti,twl4030-power-idle-osc-off",
 		.data = &osc_off_idle,
 	},
+	{
+		.compatible = "ti,twl4030-power-omap3-sdp",
+		.data = &omap3_idle_ac_quirk,
+	},
+	{
+		.compatible = "ti,twl4030-power-omap3-ldp",
+		.data = &omap3_idle_ac_quirk_osc_off,
+	},
+	{
+		.compatible = "ti,twl4030-power-omap3-evm",
+		.data = &omap3_idle_ac_quirk,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -675,6 +675,7 @@ struct twl4030_power_data {
 	struct twl4030_resconfig *board_config;
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 	bool use_poweroff;	/* Board is wired for TWL poweroff */
+	bool ac_charger_quirk;	/* Disable AC charger on board */
 };
 
 extern int twl4030_remove_script(u8 flags);
