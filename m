From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC 2/2] i2c: gpio: drop class based instantiation of slaves
Date: Wed, 19 Jun 2013 21:22:12 +0300
Message-ID: <1371666132-29655-2-git-send-email-grygorii.strashko@ti.com>
References: <1370596166-12404-1-git-send-email-wsa@the-dreams.de>
 <1371666132-29655-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371666132-29655-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-omap@vger.kernel.org

Class based instantiation mechanism can cause huge delays when booting.
For example: when CONFIG_SENSORS_LM75 option is enabled for or omap5-uevm board,
where i2c-gpio is used for HDMI edid reading - it introduces up to 5 sec boot
delay.
It's not recommended to use this mechanism with embedded I2C, so disable it by
leaving I2C adapter "class" field undefined (remove I2C_CLASS_HWMON and
I2C_CLASS_SPD) and add a deprecation warning to allow users, relying on this
mechanism, to switch to something better.

CC: Haavard Skinnemoen <hskinnemoen@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index bc6e139..33e3d0e 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -215,7 +215,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 
 	adap->algo_data = bit_data;
-	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->class = I2C_CLASS_DEPRECATED;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-- 
1.7.9.5
