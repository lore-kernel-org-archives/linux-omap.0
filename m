From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure pendown_gpio
Date: Thu,  3 Feb 2011 20:51:46 +0530
Message-ID: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: LW@karo-electronics.de
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>, Dmitry Torokhov <dtor@mail.ru>
List-Id: linux-omap@vger.kernel.org

The ads7846 driver requests a gpio but does not currently
configure it explicitly as an input. Use gpio_request_one
to request and configure it at one shot.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Cc: Dmitry Torokhov <dtor@mail.ru>

---
 Links related to the previous discussions:
 http://permalink.gmane.org/gmane.linux.ports.arm.omap/51300

 drivers/input/touchscreen/ads7846.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index ce5baee..7480460 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -956,7 +956,8 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		return 0;
 	}
 
-	err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
+	err = gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN,
+						"ads7846_pendown");
 	if (err) {
 		dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
 			pdata->gpio_pendown);
-- 
1.7.0.4

