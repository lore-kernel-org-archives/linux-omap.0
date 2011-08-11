From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH 3/3] BeagleBoard: add support for the twl4030-madc
Date: Wed, 10 Aug 2011 22:27:52 -0500
Message-ID: <1313033272-16774-4-git-send-email-kyle@kylemanna.com>
References: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:33978 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab1HKD17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 23:27:59 -0400
Received: from homiemail-a26.g.dreamhost.com (caiajhbdccac.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E884F17E59A
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 20:27:58 -0700 (PDT)
In-Reply-To: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kyle Manna <kyle@kylemanna.com>

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..a82d53b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -362,11 +362,16 @@ static struct regulator_init_data beagle_vsim = {
 	.consumer_supplies	= beagle_vsim_supply,
 };
 
+static struct twl4030_madc_platform_data beagle_madc = {
+	.irq_line       = 1,
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.gpio		= &beagle_gpio_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
+	.madc		= &beagle_madc,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
@@ -456,9 +461,15 @@ static void __init omap3_beagle_init_irq(void)
 	omap3_init_irq();
 }
 
+static struct platform_device madc_hwmon = {
+	.name		= "twl4030_madc_hwmon",
+	.id		= -1,
+};
+
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
+	&madc_hwmon,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-- 
1.7.4.1

