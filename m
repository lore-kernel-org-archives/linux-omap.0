From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 15/21] ARM: OMAP: Complete omap3evm board file gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:23 +0200
Message-ID: <1225280189-6559-16-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59953 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYJ2Lhz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:55 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbbhw018092
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:53 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8a8b2fa..7644cf6 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -75,7 +75,7 @@ static inline void __init omap3evm_init_smc911x(void)
 	else
 		rate = clk_get_rate(l3ck);
 
-	if (omap_request_gpio(OMAP3EVM_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
 		return;
@@ -171,7 +171,7 @@ static struct omap_lcd_config omap3_evm_lcd_config __initdata = {
 
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(OMAP3_EVM_TS_GPIO) < 0)
+	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
-- 
1.5.6.5

