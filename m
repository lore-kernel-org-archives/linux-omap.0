From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] omap2: ehci: Make Overo compile again
Date: Tue, 22 Sep 2009 10:04:14 -0500
Message-ID: <20090922150414.GA8975@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:56695 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774AbZIVOsV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Sep 2009 10:48:21 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, tony@atomide.com


Overo needs the same changes as the other boards do for the ehci changes.


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 17f2318..3994974 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -384,6 +384,19 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.chargepump = false,
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 183,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+
 static void __init overo_init(void)
 {
 	overo_i2c_init();
@@ -391,7 +404,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -EINVAL);
+	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
