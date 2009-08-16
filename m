From: Steve Sakoman <sakoman@gmail.com>
Subject: ARM: OMAP3: Overo: Fix EHCI initialization
Date: Sun, 16 Aug 2009 14:30:27 -0700
Message-ID: <5e088bd90908161430ka6c04f5m1cbf5e0df949f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:37263 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZHPVa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 17:30:26 -0400
Received: by qyk34 with SMTP id 34so1911944qyk.33
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 14:30:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Overo uses port 2, not port 1.  Use OVERO_GPIO_USBH_NRESET rather than
hard coded value

Note: this alone will not give functional EHCI.  Also required is:

[PATCH 4/9] ehci: fix phy_reset init in ehci probe
from Ajay Kumar Gupta

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index a9d7c2e..a220a54 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -394,7 +394,8 @@ static void __init overo_init(void)
 	omap_serial_init(&overo_uart_config);
 	overo_flash_init();
 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -EINVAL);
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true,
+			-EINVAL, OVERO_GPIO_USBH_NRESET);
 	overo_ads7846_init();
 	overo_init_smsc911x();

@@ -437,14 +438,6 @@ static void __init overo_init(void)
 	else
 		printk(KERN_ERR "could not obtain gpio for "
 					"OVERO_GPIO_USBH_CPEN\n");
-
-	if ((gpio_request(OVERO_GPIO_USBH_NRESET,
-			  "OVERO_GPIO_USBH_NRESET") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_USBH_NRESET, 1) == 0))
-		gpio_export(OVERO_GPIO_USBH_NRESET, 0);
-	else
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_USBH_NRESET\n");
 }

 static void __init overo_map_io(void)
-- 
1.6.0.4
