From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 03/21] SPI: TSC2301: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:11 +0200
Message-ID: <1225280189-6559-4-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34546 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbYJ2LhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBacUZ005853
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:05 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/spi/tsc2301-core.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/tsc2301-core.c b/drivers/spi/tsc2301-core.c
index 715e400..4b565b7 100644
--- a/drivers/spi/tsc2301-core.c
+++ b/drivers/spi/tsc2301-core.c
@@ -22,13 +22,10 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2301.h>
 
-#ifdef CONFIG_ARCH_OMAP
-#include <mach/gpio.h>
-#endif
-
 u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
 {
 	struct spi_transfer t[2];
@@ -157,14 +154,12 @@ static int __devinit tsc2301_probe(struct spi_device *spi)
 
 	if (pdata->reset_gpio >= 0) {
 		tsc->reset_gpio = pdata->reset_gpio;
-#ifdef CONFIG_ARCH_OMAP
-		r = omap_request_gpio(tsc->reset_gpio);
+		r = gpio_request(tsc->reset_gpio, "TSC2301 reset");
 		if (r < 0)
 			goto err1;
 		gpio_direction_output(tsc->reset_gpio, 1);
 		mdelay(1);
 		gpio_set_value(tsc->reset_gpio, 0);
-#endif
 	} else
 		tsc->reset_gpio = -1;
 
@@ -229,8 +224,10 @@ static int __devexit tsc2301_remove(struct spi_device *spi)
 	struct tsc2301 *tsc = dev_get_drvdata(&spi->dev);
 
 	tsc2301_mixer_exit(tsc);
-        tsc2301_ts_exit(tsc);
-        tsc2301_kp_exit(tsc);
+	tsc2301_ts_exit(tsc);
+	tsc2301_kp_exit(tsc);
+	if (tsc->reset_gpio >= 0)
+		gpio_free(tsc->reset_gpio);
 	kfree(tsc);
 
 	return 0;
-- 
1.5.6.5

