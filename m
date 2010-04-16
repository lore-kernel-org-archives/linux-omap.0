From: Viral Mehta <viral.vkm@gmail.com>
Subject: [PATCH v2] Add OHCI USB platform init
Date: Fri, 16 Apr 2010 10:23:51 +0530
Message-ID: <z2j94efb1e51004152153kbfe3aacdi2bc55d37e9cb5d98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64206 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0DPExw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 00:53:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Add platform init code for OHCI USB on OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
---
One more effort,
V2: no mangling between tabs and spaces, hopefully :)

 arch/arm/mach-omap2/board-2430sdp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c
b/arch/arm/mach-omap2/board-2430sdp.c
index 346e1d2..047d5ae 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -206,6 +206,15 @@ static struct omap_musb_board_data musb_board_data = {
 	.mode			= MUSB_OTG,
 	.power			= 100,
 };
+static struct omap_usb_config sdp2430_usb_config __initdata = {
+	.otg		= 1,
+#ifdef  CONFIG_USB_GADGET_OMAP
+	.hmc_mode	= 0x0,
+#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	.hmc_mode	= 0x1,
+#endif
+	.pins[0]	= 3,
+}

 static void __init omap_2430sdp_init(void)
 {
@@ -216,6 +225,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
+	omap_usb_init(&sdp2430_usb_config);
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();

-- 
1.6.6
