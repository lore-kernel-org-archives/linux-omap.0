From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 16/21] ARM: OMAP2: Complete gpiolib conversion in upstream merged board files
Date: Wed, 29 Oct 2008 13:36:24 +0200
Message-ID: <1225280189-6559-17-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59954 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbYJ2Lh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbbi0018092
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:54 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    4 ++--
 arch/arm/mach-omap2/board-apollon.c |    6 +++---
 arch/arm/mach-omap2/board-ldp.c     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 42e51d8..e6acac8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -213,7 +213,7 @@ static struct platform_device *sdp2430_devices[] __initdata = {
 
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(TS_GPIO) < 0)
+	if (gpio_request(TS_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 
 	gpio_direction_input(TS_GPIO);
@@ -307,7 +307,7 @@ static inline void __init sdp2430_init_smc91x(void)
 	sdp2430_smc91x_resources[0].end = cs_mem_base + 0x30f;
 	udelay(100);
 
-	if (omap_request_gpio(OMAP24XX_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(OMAP24XX_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			OMAP24XX_ETHR_GPIO_IRQ);
 		gpmc_cs_free(eth_cs);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index fcf2ab0..c68bf06 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -308,7 +308,7 @@ static inline void __init apollon_init_smc91x(void)
 	udelay(100);
 
 	omap_cfg_reg(W4__24XX_GPIO74);
-	if (omap_request_gpio(APOLLON_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(APOLLON_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			APOLLON_ETHR_GPIO_IRQ);
 		gpmc_cs_free(eth_cs);
@@ -391,7 +391,7 @@ static void __init apollon_usb_init(void)
 	/* USB device */
 	/* DEVICE_SUSPEND */
 	omap_cfg_reg(P21_242X_GPIO12);
-	omap_request_gpio(12);
+	gpio_request(12, "USB suspend");
 	gpio_direction_output(12, 0);
 }
 
@@ -399,7 +399,7 @@ static void __init apollon_tsc_init(void)
 {
 	/* TSC2101 */
 	omap_cfg_reg(N15_24XX_GPIO85);
-	omap_request_gpio(85);
+	gpio_request(85, "TSC2101 irq");
 	gpio_direction_input(85);
 
 	omap_cfg_reg(W14_24XX_SYS_CLKOUT);	/* mclk */
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index dc1c3c1..5401fb7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -94,7 +94,7 @@ out:
  */
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(ts_gpio) < 0) {
+	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
-- 
1.5.6.5

