From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] OMAP3: RX51: Define TWL4030 USB transceiver in board file
Date: Wed, 05 Aug 2009 17:18:41 +0300
Message-ID: <20090805141841.1964.11641.stgit@localhost>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57890 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934465AbZHEOSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:18:43 -0400
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>

From: Roger Quadros <ext-roger.quadros@nokia.com>

Add OTG transceiver to RX51 platform data to prevent kernel NULL pointer
dereference during MUSB initialisation.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

