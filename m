From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH v2] omap: 4430sdp board support for the the GPIO keys
Date: Tue, 31 Aug 2010 13:58:27 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C1CA4ACC@dbde02.ent.ti.com>
References: <1282627653-31510-1-git-send-email-shubhrajyoti@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CFA1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab0HaI2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 04:28:37 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7V8SXx0014643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 03:28:35 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7V8SXr2005695
	for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 13:58:33 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CFA1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Gopinath, Thara
> Subject: RE: [PATCH v2] omap: 4430sdp board support for the the GPIO keys
> 
> 
> 
> >>-----Original Message-----
> >>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> >>Shubhrajyoti D
> >>Sent: Tuesday, August 24, 2010 10:58 AM
> >>To: linux-omap@vger.kernel.org
> >>Cc: Datta, Shubhrajyoti
> >>Subject: [PATCH v2] omap: 4430sdp board support for the the GPIO keys
> >>
> >>omap 4430sdp board support for the GPIO keys.
> >>The proximity sensor is connected to GPIO and is registered as a
> >>GPIO key.
> >>- Making the default state of the sensor off at bootup
> >>
> >>Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> >>---
> >> arch/arm/mach-omap2/board-4430sdp.c |   61
> +++++++++++++++++++++++++++++++++++
> >> 1 files changed, 61 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> >>index 9447644..85b0e0c 100644
> >>--- a/arch/arm/mach-omap2/board-4430sdp.c
> >>+++ b/arch/arm/mach-omap2/board-4430sdp.c
> >>@@ -20,6 +20,7 @@
> >> #include <linux/usb/otg.h>
> >> #include <linux/spi/spi.h>
> >> #include <linux/i2c/twl.h>
> >>+#include <linux/gpio_keys.h>
> >> #include <linux/regulator/machine.h>
> >> #include <linux/leds.h>
> >>
> >>@@ -40,6 +41,8 @@
> >> #define ETH_KS8851_IRQ			34
> >> #define ETH_KS8851_POWER_ON		48
> >> #define ETH_KS8851_QUART		138
> >>+#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
> >>+#define OMAP4_SFH7741_ENABLE_GPIO		188
> >>
> >> static struct gpio_led sdp4430_gpio_leds[] = {
> >> 	{
> >>@@ -77,11 +80,47 @@ static struct gpio_led sdp4430_gpio_leds[] = {
> >>
> >> };
> >>
> >>+static struct gpio_keys_button sdp4430_gpio_keys[] = {
> >>+	{
> >>+		.desc			= "Proximity Sensor",
> >>+		.type			= EV_SW,
> >>+		.code			= SW_FRONT_PROXIMITY,
> >>+		.gpio			= OMAP4_SFH7741_SENSOR_OUTPUT_GPIO,
> >>+		.active_low		= 0,
> >>+	}
> >>+};
> >>+
> >> static struct gpio_led_platform_data sdp4430_led_data = {
> >> 	.leds	= sdp4430_gpio_leds,
> >> 	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
> >> };
> >>
> >>+static int omap_prox_activate(struct device *dev)
> >>+{
> >>+	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
> >>+	return 0;
> >>+}
> >>+
> >>+static void omap_prox_deactivate(struct device *dev)
> >>+{
> >>+	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 0);
> >>+}
> >>+
> >>+static struct gpio_keys_platform_data sdp4430_gpio_keys_data = {
> >>+	.buttons	= sdp4430_gpio_keys,
> >>+	.nbuttons	= ARRAY_SIZE(sdp4430_gpio_keys),
> >>+	.enable		= omap_prox_activate,
> >>+	.disable	= omap_prox_deactivate,
> >>+};
> >>+
> >>+static struct platform_device sdp4430_gpio_keys_device = {
> >>+	.name	= "gpio-keys",
> >>+	.id	= -1,
> >>+	.dev	= {
> >>+		.platform_data	= &sdp4430_gpio_keys_data,
> >>+	},
> >>+};
> >>+
> >> static struct platform_device sdp4430_leds_gpio = {
> >> 	.name	= "leds-gpio",
> >> 	.id	= -1,
> >>@@ -161,6 +200,7 @@ static struct platform_device sdp4430_lcd_device = {
> >>
> >> static struct platform_device *sdp4430_devices[] __initdata = {
> >> 	&sdp4430_lcd_device,
> >>+	&sdp4430_gpio_keys_device,
> >> 	&sdp4430_leds_gpio,
> >> };
> >>
> >>@@ -426,6 +466,26 @@ static int __init omap4_i2c_init(void)
> >> 	omap_register_i2c_bus(4, 400, NULL, 0);
> >> 	return 0;
> >> }
> >>+
> >>+static void __init omap_sfh7741prox_init(void)
> >>+{
> >>+	int  error;
> >>+
> >>+	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
> >>+	if (error < 0) {
> >>+		pr_err("%s:failed to request GPIO %d, error %d\n",
> >>+			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
> >>+		return;
> >>+	}
> >>+
> >>+	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 0);
> >>+	if (error < 0) {
> >>+		pr_err("%s: GPIO configuration failed: GPIO %d,error %d\n",
> >>+			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
> >>+		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
> >>+	}
> >>+}
> >>+
> >> static void __init omap_4430sdp_init(void)
> >> {
> >> 	int status;
> >>@@ -448,6 +508,7 @@ static void __init omap_4430sdp_init(void)
> >> 		spi_register_board_info(sdp4430_spi_board_info,
> >> 				ARRAY_SIZE(sdp4430_spi_board_info));
> >> 	}
> >>+	omap_sfh7741prox_init();
> 
> Hello Shubro,
> 
> I believe you are calling omap_sfh7741prox_init at the end of
> omap_4430sdp_init
> which means your sdp4430_gpio_keys_device is registered much before this.
> This could mean that the probe of your gpio-keys driver could get called
> before
> omap_sfh7741prox_init. Assume this is the case and your probe calls into
> pdata->enable
> or pdata->disable which is omap_prox_activate/omap_prox_deactivate as per
> this
> patch, these API's will try accessing gpio APIs for
> OMAP4_SFH7741_ENABLE_GPIO without
> a gpio_request happening for this pin as omap_sfh7741prox_init is called
> later.
> Maybe such a case might never arise. But I would say you should do a
> request_gpio for
> OMAP4_SFH7741_ENABLE_GPIO before the driver probe is called.
Hi Thara,
Thanks for your review. Will send another patch.
> 
> Regards
> Thara
