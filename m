From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: RX51: Define TWL4030 USB transceiver in board file
Date: Mon,  6 Jul 2009 11:22:11 +0300
Message-ID: <1246868531-5023-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51429 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbZGFIWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 04:22:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a0bf67..56d931a 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -278,6 +278,10 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.setup			= rx51_twlgpio_setup,
 };
 
+static struct twl4030_usb_data rx51_usb_data = {
+	.usb_mode		= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data rx51_twldata = {
 	.irq_base		= TWL4030_IRQ_BASE,
 	.irq_end		= TWL4030_IRQ_END,
@@ -286,6 +290,7 @@ static struct twl4030_platform_data rx51_twldata = {
 	.gpio			= &rx51_gpio_data,
 	.keypad			= &rx51_kp_data,
 	.madc			= &rx51_madc_data,
+	.usb			= &rx51_usb_data,
 
 	.vaux1			= &rx51_vaux1,
 	.vaux2			= &rx51_vaux2,
-- 
1.6.0.4

