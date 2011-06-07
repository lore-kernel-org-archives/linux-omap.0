From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Tue, 07 Jun 2011 14:44:58 +0300
Message-ID: <1307447098.1858.31.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505130204.GK11744@opensource.wolfsonmicro.com>
	 <1304955274.2215.26.camel@deskari>
	 <20110509191912.GA6546@opensource.wolfsonmicro.com>
	 <1305030652.2045.49.camel@deskari>
	 <20110510134730.GB25877@opensource.wolfsonmicro.com>
	 <1305105825.2097.49.camel@deskari>
	 <20110511121243.GB5487@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52579 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab1FGLpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 07:45:05 -0400
Received: by wye20 with SMTP id 20so3993066wye.6
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 04:45:03 -0700 (PDT)
In-Reply-To: <20110511121243.GB5487@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

Hi Mark,

Waking up this old thread again.

On Wed, 2011-05-11 at 14:12 +0200, Mark Brown wrote:
> On Wed, May 11, 2011 at 12:23:45PM +0300, Tomi Valkeinen wrote:
> 
> > So how should the regulator be set up?
> 
> You need to create a new regulator of some kind and then provide a way
> for machines to set the supply_regulator in the init_data.

What should this "new regulator of some kind" be? I was trying out with
fixed regulator, but I'm not quite sure if that's good here.

I don't want a full controllable regulator, but just a virtual "route"
regulator, which mirrors the state of the parent regulator.

(Well, I don't actually want that, I want to dynamically add some
REGULATOR_SUPPLYs to an existing regulator, but afaik that's not
possible.)

Can the fixed regulator be used like that?

Using a new regulator like this also means that there is a dependency
between the new regulator and the used source supply. I haven't solved
this yet, as the twl driver seems to add the regulators at some later
stage.

Below is my test patch for reference. It doesn't do the work in a common
file, so it's just for testing.

 Tomi

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 2647a95..fb477f1 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -22,6 +22,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
 
@@ -277,10 +278,47 @@ static int omap_ethernet_init(void)
 	return status;
 }
 
+static struct regulator_consumer_supply fixed_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+};
+
+static struct regulator_init_data fixed_reg_init_data = {
+	.supply_regulator = "VCXIO",
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(fixed_supply),
+	.consumer_supplies      = fixed_supply,
+};
+
+static struct fixed_voltage_config omap_dss_fixed_reg_data = {
+	.gpio = -EINVAL,
+	.supply_name = "dss-regulator",
+	.init_data = &fixed_reg_init_data,
+	.enabled_at_boot = 1,
+	.microvolts = 1800000,
+};
+
+static struct platform_device omap_dss_fixed_reg_device = {
+	.name   = "reg-fixed-voltage",
+	.id     = 3,
+	.dev    = {
+		.platform_data  = &omap_dss_fixed_reg_data,
+	},
+};
+
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
+	&omap_dss_fixed_reg_device,
 };
 
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
@@ -339,8 +377,6 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	},
 };
 static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)


