From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2] omap: rx51: Add SI4713 FM transmitter
Date: Mon, 21 Feb 2011 10:09:21 +0200
Message-ID: <1298275761-21486-1-git-send-email-jhnikula@gmail.com>
References: <20110221095421.6576a98d.jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f180.google.com ([209.85.215.180]:45861 "EHLO
	mail-ey0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1BUIIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 03:08:44 -0500
Received: by eyg24 with SMTP id 24so92125eyg.11
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:08:43 -0800 (PST)
In-Reply-To: <20110221095421.6576a98d.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Varadarajan Charulatha <charu@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Add SI4713 FM transmitter supplies, platform data and setup to RX-51/N900.
It is connected to line output signals of TLV320AIC34 codec A part.
Driver can be either built-in or a module. It can be tuned with v4l2-ctl
from ivtv-utils. Following examples illustrate the use of it:

	v4l2-ctl -d /dev/radio0 --set-ctrl=mute=0 (power up)
	v4l2-ctl -d /dev/radio0 -f 107900 (tune 107.9 MHz)

	v4l2-ctl -d /dev/radio0 --set-ctrl=mute=1 (power down)

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
v2: Using pr_err instead of printk. Thanks to
"Varadarajan, Charulatha" <charu@ti.com> for noticing.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   44 ++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..17ef1af 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -36,6 +36,8 @@
 
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
+#include <media/radio-si4713.h>
+#include <media/si4713.h>
 
 #include <../drivers/staging/iio/light/tsl2563.h>
 
@@ -47,6 +49,8 @@
 
 #define RX51_WL1251_POWER_GPIO		87
 #define RX51_WL1251_IRQ_GPIO		42
+#define RX51_FMTX_RESET_GPIO		163
+#define RX51_FMTX_IRQ			53
 
 /* list all spi devices here */
 enum {
@@ -357,10 +361,14 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	REGULATOR_SUPPLY("DVDD", "2-0018"),
 	REGULATOR_SUPPLY("IOVDD", "2-0019"),
 	REGULATOR_SUPPLY("DVDD", "2-0019"),
+	/* Si4713 IO supply */
+	REGULATOR_SUPPLY("vio", "2-0063"),
 };
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	/* Si4713 supply */
+	REGULATOR_SUPPLY("vdd", "2-0063"),
 };
 
 static struct regulator_consumer_supply rx51_vdac_supply[] = {
@@ -511,6 +519,41 @@ static struct regulator_init_data rx51_vio = {
 	.consumer_supplies	= rx51_vio_supplies,
 };
 
+static struct si4713_platform_data rx51_si4713_i2c_data __initdata_or_module = {
+	.gpio_reset	= RX51_FMTX_RESET_GPIO,
+};
+
+static struct i2c_board_info rx51_si4713_board_info __initdata_or_module = {
+	I2C_BOARD_INFO("si4713", SI4713_I2C_ADDR_BUSEN_HIGH),
+	.platform_data	= &rx51_si4713_i2c_data,
+};
+
+static struct radio_si4713_platform_data rx51_si4713_data __initdata_or_module = {
+	.i2c_bus	= 2,
+	.subdev_board_info = &rx51_si4713_board_info,
+};
+
+static struct platform_device rx51_si4713_dev __initdata_or_module = {
+	.name	= "radio-si4713",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &rx51_si4713_data,
+	},
+};
+
+static __init void rx51_init_si4713(void)
+{
+	int err;
+
+	err = gpio_request_one(RX51_FMTX_IRQ, GPIOF_DIR_IN, "si4713 irq");
+	if (err) {
+		pr_err("Cannot request si4713 irq gpio. %d\n", err);
+		return;
+	}
+	rx51_si4713_board_info.irq = gpio_to_irq(RX51_FMTX_IRQ);
+	platform_device_register(&rx51_si4713_dev);
+}
+
 static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
@@ -921,6 +964,7 @@ void __init rx51_peripherals_init(void)
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_si4713();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
 
-- 
1.7.2.3

