From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/4] [OMAP] omap_udc: Updates for omap7xx IRQs and config
Date: Mon, 5 Oct 2009 07:50:27 -0700
Message-ID: <6cb013310910050750q183abe82qbfd60064d774fe62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f173.google.com ([209.85.210.173]:65506 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZJEOvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 10:51:24 -0400
Received: by yxe3 with SMTP id 3so2902509yxe.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 07:50:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

There was a FIXME in usb.c:

    /* FIXME patch IRQ numbers for omap730 */

I replaced that with the correct resources for omap7xx CPUs.
Additionally, I disabled USB_TRANSCEIVER_CTRL manipulations
for omap7xx as this causes problems sending data to the
host.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/plat-omap/usb.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 3c40b85..1ac252a 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -159,11 +159,14 @@ static u32 __init omap_usb0_init(unsigned
nwires, unsigned is_device)
 		 *  - OTG support on this port not yet written
 		 */

-		l = omap_readl(USB_TRANSCEIVER_CTRL);
-		l &= ~(7 << 4);
-		if (!is_device)
-			l |= (3 << 1);
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		/* Don't do this for omap7xx -- it causes USB to not work correctly */
+		if (!cpu_is_omap7xx()) {
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l &= ~(7 << 4);
+			if (!is_device)
+				l |= (3 << 1);
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}

 		return 3 << 16;
 	}
@@ -603,7 +606,12 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg || config->register_dev) {
 		syscon &= ~DEV_IDLE_EN;
 		udc_device.dev.platform_data = config;
-		/* FIXME patch IRQ numbers for omap730 */
+		/* IRQ numbers for omap7xx */
+		if(cpu_is_omap7xx()) {
+			udc_resources[1].start = INT_7XX_USB_GENI;
+			udc_resources[2].start = INT_7XX_USB_NON_ISO;
+			udc_resources[3].start = INT_7XX_USB_ISO;
+		}
 		status = platform_device_register(&udc_device);
 		if (status)
 			pr_debug("can't register UDC device, %d\n", status);
-- 
1.5.6.3
