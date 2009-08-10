From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/2] arm: omap: beagle: add missing twl4030 usb platform_data
Date: Mon, 10 Aug 2009 14:48:58 +0300
Message-ID: <1249904939-3213-2-git-send-email-felipe.balbi@nokia.com>
References: <1249904939-3213-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29537 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbZHJLrq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 07:47:46 -0400
In-Reply-To: <1249904939-3213-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

without it twl4030_usb driver will not probe.

Reported-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..f9f011f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -249,11 +249,16 @@ static struct regulator_init_data beagle_vpll2 = {
 	.consumer_supplies	= &beagle_vdvi_supply,
 };
 
+static struct twl4030_usb_data beagle_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.usb		= &beag_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
-- 
1.6.3.3.385.g60647

