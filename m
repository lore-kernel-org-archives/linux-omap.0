From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 08/21] INPUT: TS_Hx: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:16 +0200
Message-ID: <1225280189-6559-9-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59927 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYJ2Lhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:40 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbbha018092
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:38 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/input/touchscreen/omap/ts_hx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/omap/ts_hx.c b/drivers/input/touchscreen/omap/ts_hx.c
index 0ef7f6c..9d3ec97 100644
--- a/drivers/input/touchscreen/omap/ts_hx.c
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -28,8 +28,8 @@
 
 #include <linux/input.h>
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <asm/mach-types.h>
-#include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/hardware.h>
 #include <asm/hardware/tsc2101.h>
@@ -92,7 +92,7 @@ static int __init hx_ts_probe(struct omap_ts_t *ts)
 		return -ENODEV;
 
 	ts->irq = gpio_to_irq(gpio);
-	if (omap_request_gpio(gpio) != 0) {
+	if (gpio_request(gpio, "TS irq") != 0) {
 		printk(KERN_ERR "hX_ts_init.c: Could not reserve GPIO!\n");
 		return -EINVAL;
 	};
@@ -177,8 +177,8 @@ static void hx_ts_disable(void)
 static void __exit hx_ts_remove(void)
 {
 	if (machine_is_omap_h2())
-		omap_free_gpio(H2_GPIO_NUM);
+		gpio_free(H2_GPIO_NUM);
 	else if (machine_is_omap_h3())
-		omap_free_gpio(H3_GPIO_NUM);
+		gpio_free(H3_GPIO_NUM);
 }
 #endif
-- 
1.5.6.5

