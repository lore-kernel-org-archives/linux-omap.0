From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 19/21] ARM: OMAP: LEDS: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:27 +0200
Message-ID: <1225280189-6559-20-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59956 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbYJ2Lh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:58 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbbi2018092
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:55 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/leds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index 540434e..8cbf256 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -47,13 +47,13 @@ omap_leds_init(void)
 		 * that's a different kind of LED (just one color at a time).
 		 */
 		omap_cfg_reg(P18_1610_GPIO3);
-		if (omap_request_gpio(3) == 0)
+		if (gpio_request(3, "LED red") == 0)
 			gpio_direction_output(3, 1);
 		else
 			printk(KERN_WARNING "LED: can't get GPIO3/red?\n");
 
 		omap_cfg_reg(MPUIO4);
-		if (omap_request_gpio(OMAP_MPUIO(4)) == 0)
+		if (gpio_request(OMAP_MPUIO(4), "LED green") == 0)
 			gpio_direction_output(OMAP_MPUIO(4), 1);
 		else
 			printk(KERN_WARNING "LED: can't get MPUIO4/green?\n");
-- 
1.5.6.5

