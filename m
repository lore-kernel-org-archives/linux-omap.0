From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [RFC PATCH v2 2/4] ARM: OMAP1: nokia770: enable Tahvo
Date: Tue,  9 Apr 2013 22:51:26 +0300
Message-ID: <1365537088-23199-3-git-send-email-aaro.koskinen@iki.fi>
References: <1365537088-23199-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365537088-23199-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add platform data for Tahvo.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
