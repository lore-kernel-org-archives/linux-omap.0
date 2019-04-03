From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 12/12] i2c: gpio: flag atomic capability if possible
Date: Wed,  3 Apr 2019 14:40:19 +0200
Message-ID: <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

If switching GPIOs does not sleep, then we can support atomic transfers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index bba5c4627de3..9684a0ac2a6d 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -413,6 +413,8 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 
 	if (gpiod_cansleep(priv->sda) || gpiod_cansleep(priv->scl))
 		dev_warn(dev, "Slow GPIO pins might wreak havoc into I2C/SMBus bus timing");
+	else
+		bit_data->can_do_atomic = true;
 
 	bit_data->setsda = i2c_gpio_setsda_val;
 	bit_data->setscl = i2c_gpio_setscl_val;
-- 
2.11.0
