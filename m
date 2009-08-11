From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/2] arm: omap: beagle: add missing twl4030 usb platform_data
Date: Tue, 11 Aug 2009 11:43:12 +0300
Message-ID: <1249980192-17843-1-git-send-email-felipe.balbi@nokia.com>
References: <20090811080450.GP1938@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27448 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbZHKMSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 08:18:55 -0400
Received: from mgw-mx06.nokia.com (mgw-mx06.nokia.com [192.100.122.233])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7B92igh028629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 12:02:44 +0300
In-Reply-To: <20090811080450.GP1938@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

without it twl4030_usb driver will not probe.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Oops, mis-wrote the struct name, here's updated version.

 arch/arm/mach-omap2/board-omap3beagle.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..cf0244b 100644
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
+	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
-- 
1.6.3.3.385.g60647

