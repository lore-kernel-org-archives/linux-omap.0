From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC 1/2] i2c: omap: drop class based instantiation of slaves
Date: Wed, 19 Jun 2013 21:22:11 +0300
Message-ID: <1371666132-29655-1-git-send-email-grygorii.strashko@ti.com>
References: <1370596166-12404-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370596166-12404-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Class based instantiation mechanism can cause huge delays when booting.
For example: when CONFIG_SENSORS_LM75 option is enabled for omap4-sdp board -
it introduces 5-6 ms boot delay.
It's not recommended to use this mechanism with embedded I2C, so disable
it by leaving I2C adapter "class" field undefined (remove I2C_CLASS_HWMON).

CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f06109f..ae2b27f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1231,7 +1231,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
+	adap->class = I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
-- 
1.7.9.5
