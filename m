From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 21/21] ARM: OMAP: Complete debug board gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:29 +0200
Message-ID: <1225280189-6559-22-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53270 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYJ2Lhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:48 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBast5031312
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 06:37:46 -0500
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/debug-devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 7d9c87c..f668483 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -72,7 +72,7 @@ int __init debug_card_init(u32 addr, unsigned gpio)
 	smc91x_resources[1].start = gpio_to_irq(gpio);
 	smc91x_resources[1].end   = gpio_to_irq(gpio);
 
-	status = omap_request_gpio(gpio);
+	status = gpio_request(gpio, "SMC91x irq");
 	if (status < 0) {
 		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;
-- 
1.5.6.5

