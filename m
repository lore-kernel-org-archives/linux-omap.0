From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/2] ads7846: enable pendown GPIO debounce time setting
Date: Mon, 19 Nov 2012 18:03:57 +0200
Message-ID: <1353341038-14381-2-git-send-email-grinberg@compulab.co.il>
References: <1353341038-14381-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:39454 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab2KSQEJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 11:04:09 -0500
In-Reply-To: <1353341038-14381-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Some platforms need the pendown GPIO debounce time setting programmed.
Since the pendown GPIO is handled by the driver, the debounce time
should also be handled along with the pendown GPIO request.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/input/touchscreen/ads7846.c |    6 +++++-
 include/linux/spi/ads7846.h         |    5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f02028e..78e5d9a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -955,7 +955,8 @@ static int ads7846_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
-static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads7846 *ts)
+static int __devinit ads7846_setup_pendown(struct spi_device *spi,
+					   struct ads7846 *ts)
 {
 	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
@@ -981,6 +982,9 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 
 		ts->gpio_pendown = pdata->gpio_pendown;
 
+		if (pdata->gpio_pendown_debounce)
+			gpio_set_debounce(pdata->gpio_pendown,
+					  pdata->gpio_pendown_debounce);
 	} else {
 		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
 		return -EINVAL;
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index c64de9d..2e94187 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -46,8 +46,9 @@ struct ads7846_platform_data {
 	u16	debounce_rep;		/* additional consecutive good readings
 					 * required after the first two */
 	int	gpio_pendown;		/* the GPIO used to decide the pendown
-					 * state if get_pendown_state == NULL
-					 */
+					 * state if get_pendown_state == NULL */
+	int	gpio_pendown_debounce;	/* platform specific debounce time for
+					   the gpio_pendown */
 	int	(*get_pendown_state)(void);
 	int	(*filter_init)	(const struct ads7846_platform_data *pdata,
 				 void **filter_data);
-- 
1.7.3.4

