From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: refresh nop transceiver support for musb
Date: Tue, 7 Apr 2009 10:08:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427EE8FCD@dbde02.ent.ti.com>
References: <1239024889-28597-1-git-send-email-ajay.gupta@ti.com>
 <20090406134406.GG22170@scadufax.research.nokia.com>
 <19F8576C6E063C45BE387C64729E73940427EE8F27@dbde02.ent.ti.com>
 <200904061130.38325.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZDGEjB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 00:39:01 -0400
In-Reply-To: <200904061130.38325.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, April 07, 2009 12:01 AM
> To: Gupta, Ajay Kumar
> Cc: felipe.balbi@nokia.com; linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH] musb: refresh nop transceiver support for musb
> 
> On Monday 06 April 2009, Gupta, Ajay Kumar wrote:
> > David, what's your comment on this?
> 
> It was wrong to try registering the transceiver in
> the mach-map2/usb2.c file in any case.  That's a
> board-specific issue for OMAP3; and TUSB60x0 chips
> have an integrated one.  See

I have updated the patch with below changes,
	-removed NOP transceiver code from arch/arm/mach-omap2/usb-musb.c
	-Added NOP transceiver at drivers/usb/musb/omap2430.c in musb_platform_init()
	 same as done in davinci/BlackFin/tusb6010 in your queued patch.
	-Modified include/linux/usb/otg.h with Felipe's suggestion which removes the #ifdef
	 from drivers/usb/musb/omap2430.c file.
Please review this one attached below. 
====== cut here ==============
[PATCH] musb: refresh NOP transceiver support for OMAP35x EVM

Removing NOP support code from usb-musb.c and adding its support at
Drivers/usb/musb/omap2430.c.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
It is against latest l-o tree + Queued patches from David (21 patches).

 arch/arm/mach-omap2/usb-musb.c |   21 ---------------------
 drivers/usb/musb/omap2430.c    |    4 ++++
 include/linux/usb/otg.h        |    6 +++++-
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 927c2d9..6f768d6 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -145,20 +145,6 @@ static struct platform_device musb_device = {
 	.resource	= musb_resources,
 };
 
-#ifdef CONFIG_NOP_USB_XCEIV
-static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device nop_xceiv_device = {
-	.name		= "nop_usb_xceiv",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &nop_xceiv_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-		.platform_data		= NULL,
-	},
-};
-#endif
-
 void __init usb_musb_init(void)
 {
 	if (cpu_is_omap243x()) {
@@ -171,13 +157,6 @@ void __init usb_musb_init(void)
 
 	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
 
-#ifdef CONFIG_NOP_USB_XCEIV
-	if (platform_device_register(&nop_xceiv_device) < 0) {
-		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
-		return;
-	}
-#endif
-
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3fbc807..abfe061 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -209,6 +209,9 @@ int __init musb_platform_init(struct musb *musb)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
+	/* OMAP35x EVM needs to regsiter NOP transceiver */
+	usb_nop_xceiv_register();
+
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
@@ -313,5 +316,6 @@ int musb_platform_exit(struct musb *musb)
 	clk_put(musb->clock);
 	musb->clock = 0;
 
+	usb_nop_xceiv_unregister();
 	return 0;
 }
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 2443c0e..9778268 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -82,9 +82,13 @@ struct otg_transceiver {
 extern int otg_set_transceiver(struct otg_transceiver *);
 
 /* sometimes transceivers are accessed only through e.g. ULPI */
+#ifdef CONFIG_NOP_USB_XCEIV
 extern void usb_nop_xceiv_register(void);
 extern void usb_nop_xceiv_unregister(void);
-
+#else
+static inline void usb_nop_xceiv_register(void) {}
+static inline void usb_nop_xceiv_unregister(void) {}
+#endif
 
 /* for usb host and peripheral controller drivers */
 extern struct otg_transceiver *otg_get_transceiver(void);
-- 
1.6.0.3
==============================
