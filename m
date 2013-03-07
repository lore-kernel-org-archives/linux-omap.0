From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 2/4] ARM: OMAP1: nokia770: enable Tahvo
Date: Thu,  7 Mar 2013 16:40:19 +0200
Message-ID: <1362667221-30659-3-git-send-email-aaro.koskinen@iki.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:40876 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294Ab3CGOkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 09:40:46 -0500
In-Reply-To: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Add platform data for Tahvo.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 62a15e2..91449c5 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -234,16 +234,26 @@ static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
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
1.7.10.4

