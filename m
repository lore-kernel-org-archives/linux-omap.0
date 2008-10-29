From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 12/21] ARM: OMAP: Complete TUSB-OMAP interface gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:20 +0200
Message-ID: <1225280189-6559-13-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53271 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYJ2Lhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:48 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbA4j031633
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 06:37:46 -0500
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index d59855c..32b7c85 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -12,11 +12,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <linux/usb/musb.h>
 
 #include <mach/gpmc.h>
-#include <mach/gpio.h>
 #include <mach/mux.h>
 
 
@@ -290,7 +290,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			);
 
 	/* IRQ */
-	status = omap_request_gpio(irq);
+	status = gpio_request(irq, "TUSB6010 irq");
 	if (status < 0) {
 		printk(error, 3, status);
 		return status;
-- 
1.5.6.5

