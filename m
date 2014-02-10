From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 03/17] i2c: i2c-omap: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:03:57 +0100
Message-ID: <1392026654-5343-4-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <khali@linux-fr.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <khali@linux-fr.org>
---

 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 90dcc2e..8e29004 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1238,7 +1238,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
-- 
1.8.5.1
