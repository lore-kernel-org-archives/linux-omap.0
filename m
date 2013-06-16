From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 5/5] ARM: OMAP1: nokia770: enable Tahvo
Date: Sun, 16 Jun 2013 16:35:12 +0300
Message-ID: <1371389712-29516-6-git-send-email-aaro.koskinen@iki.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:39693 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab3FPNfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jun 2013 09:35:50 -0400
In-Reply-To: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add platform data for Tahvo.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 62a15e2..85089d8 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -156,6 +156,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 16,
 	.pins[0]	= 6,
+	.extcon		= "tahvo-usb",
 };
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
@@ -234,16 +235,26 @@ static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 	{
 		I2C_BOARD_INFO("retu-mfd", 0x01),
 	},
+	{
+		I2C_BOARD_INFO("tahvo-mfd", 0x02),
+	},
 };
 
 static void __init nokia770_cbus_init(void)
 {
 	const int retu_irq_gpio = 62;
+	const int tahvo_irq_gpio = 40;
 
 	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
 		return;
+	if (gpio_request_one(tahvo_irq_gpio, GPIOF_IN, "Tahvo IRQ")) {
+		gpio_free(retu_irq_gpio);
+		return;
+	}
 	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(gpio_to_irq(tahvo_irq_gpio), IRQ_TYPE_EDGE_RISING);
 	nokia770_i2c_board_info_2[0].irq = gpio_to_irq(retu_irq_gpio);
+	nokia770_i2c_board_info_2[1].irq = gpio_to_irq(tahvo_irq_gpio);
 	i2c_register_board_info(2, nokia770_i2c_board_info_2,
 				ARRAY_SIZE(nokia770_i2c_board_info_2));
 	platform_device_register(&nokia770_cbus_device);
-- 
1.8.3.1

