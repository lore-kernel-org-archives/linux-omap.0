From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap] OMAP1: OMAP_TAG_USB buildfix (OSK)
Date: Wed, 11 Mar 2009 02:20:05 -0800
Message-ID: <200903110320.06011.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n7.bullet.mud.yahoo.com ([216.252.100.58]:25545 "HELO
	n7.bullet.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755478AbZCKKnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 06:43:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Build fix:

  CC      arch/arm/mach-omap1/board-osk.o
  arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
  arch/arm/mach-omap1/board-osk.c:512: error: implicit declaration of function 'omap_usb_init'
  make[1]: *** [arch/arm/mach-omap1/board-osk.o] Error 1

The error is twofold.  First, USB is on the mainboard, not the Mistral card;
that's specific to the OSK.  Second, header goofage -- hurts all OMAP1 boards.

I'm puzzled by the notion tha the "OMAP1: get rid of OMAP_TAG_USB" patch could
have been compile-tested.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-osk.c       |    3 ++-
 arch/arm/plat-omap/include/mach/usb.h |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -509,7 +509,6 @@ static void __init osk_mistral_init(void
 	i2c_register_board_info(1, mistral_i2c_board_info,
 			ARRAY_SIZE(mistral_i2c_board_info));
 
-	omap_usb_init(&osk_usb_config);
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
@@ -541,6 +540,8 @@ static void __init osk_init(void)
 	l |= (3 << 1);
 	omap_writel(l, USB_TRANSCEIVER_CTRL);
 
+	omap_usb_init(&osk_usb_config);
+
 	/* irq for tps65010 chip */
 	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
 	if (gpio_request(OMAP_MPUIO(1), "tps65010") == 0)
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -33,9 +33,7 @@ extern void usb_musb_init(void);
 static inline void usb_musb_init(void)
 {
 }
-#endif
-
-void omap_usb_init(struct omap_usb_config *pdata);
+#endif	/* !OMAP1 && !MUSB */
 
 #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
 extern void usb_ehci_init(void);
@@ -43,9 +41,11 @@ extern void usb_ehci_init(void);
 static inline void usb_ehci_init(void)
 {
 }
-#endif
+#endif	/* !OMAP1 && !EHCI */
 
-#endif
+#endif	/* !OMAP1 */
+
+void omap_usb_init(struct omap_usb_config *pdata);
 
 /*-------------------------------------------------------------------------*/
 

