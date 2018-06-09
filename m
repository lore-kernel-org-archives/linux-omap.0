From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 05/10] ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin
Date: Sat,  9 Jun 2018 16:02:19 +0200
Message-ID: <20180609140224.32606-5-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

"keybrd_dataout" GPIO pin used to be initialized by ams-delta-serio
driver to a state safe for ams-delta-serio device function and not
changed thereafter.  As such, it may be assumed not under the driver
control and responsibility for its initialization handed over to board
init file.

Introduce a GPIO hog table and take over control of the
"keybrd_dataout" GPIO pin from the ams-delta-serio driver.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 8 ++++++++
 drivers/input/serio/ams_delta_serio.c | 5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 706eb2f9301d..2821284aa0c9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -574,6 +574,12 @@ static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
+static struct gpiod_hog ams_delta_gpio_hogs[] = {
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	{},
+};
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -594,6 +600,8 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
+	gpiod_add_hogs(ams_delta_gpio_hogs);
+
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index d48beab1d00d..0b4d5a952ecb 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -121,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 		.flags	= GPIOF_DIR_IN,
 		.label	= "serio-clock",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-dataout",
-	},
 };
 
 static int ams_delta_serio_init(struct platform_device *pdev)
-- 
2.16.1
