From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/2] ehci: Fix EHCI init for OMAP3EVM
Date: Mon,  6 Jul 2009 13:28:11 +0530
Message-ID: <1246867091-13495-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51662 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZGFH6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 03:58:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Multimedia Daughter card on OMAP3EVM uses port2
as EHCI port. Other ports (port1 and port3)are
not used. 

Fixes done includes:
	- Port1 GPIO set to -EINVAL
	- GPIO 135 as port2 phy reset pin
	- Mux setup for GPIO 135
	- Chargepump workaround not required on OMAP3EVM

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 arch/arm/mach-omap2/usb-ehci.c       |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 595beac..ae32e72 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -308,7 +308,7 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, -EINVAL, 135);
 	ads7846_dev_init();
 }
 
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 53e6e85..bf4bf77 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -173,6 +173,10 @@ void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
 	if (cpu_is_omap34xx())
 		setup_ehci_io_mux(phy_mode);
 
+#ifdef CONFIG_MACH_OMAP3EVM
+	/* Setup phy reset pin for EHCI on OMAP3EVM */
+	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+#endif
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
 		return;
-- 
1.6.2.4

