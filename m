From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 18/21] ARM: OMAP: Complete OMAP1 serial.c gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:26 +0200
Message-ID: <1225280189-6559-19-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34623 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbYJ2LiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:38:00 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbcu1006609
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:57 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index b63da3f..0002084 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -244,7 +244,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 {
 	int ret;
 
-	ret = omap_request_gpio(gpio_nr);
+	ret = gpio_request(gpio_nr, "UART wake");
 	if (ret < 0) {
 		printk(KERN_ERR "Could not request UART wake GPIO: %i\n",
 		       gpio_nr);
@@ -254,7 +254,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
-		omap_free_gpio(gpio_nr);
+		gpio_free(gpio_nr);
 		printk(KERN_ERR "No interrupt for UART wake GPIO: %i\n",
 		       gpio_nr);
 		return;
-- 
1.5.6.5

