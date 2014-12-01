From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: Fix randconfig build issues for Kconfig options
Date: Mon, 1 Dec 2014 11:10:15 -0800
Message-ID: <20141201191015.GC2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Commit 82c02f58ba3a ("usb: musb: Allow multiple glue layers to be
built in") enabled selecting multiple glue layers, which in turn
exposed things more for randconfig builds. If NOP_USB_XCEIV is
built-in and TUSB6010 is a loadable module, we will get:

drivers/built-in.o: In function `tusb_remove':
tusb6010.c:(.text+0x16a817): undefined reference to `usb_phy_generic_unregister'
drivers/built-in.o: In function `tusb_probe':
tusb6010.c:(.text+0x16b24e): undefined reference to `usb_phy_generic_register'
make: *** [vmlinux] Error 1

Let's fix this the same way as commit 70c1ff4b3c86 ("usb: musb:
tusb-dma can't be built-in if tusb is not").

And while at it, let's not allow selecting the glue layers except
on platforms really using them unless COMPILE_TEST is specified:

- TUSB6010 is in practise only used on omaps

- DSPS is only used on TI platforms

- UX500 is only used on STE platforms

Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

---

Felipe, this is against current linux next for v3.19

--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -72,6 +72,8 @@ config USB_MUSB_DA8XX
 
 config USB_MUSB_TUSB6010
 	tristate "TUSB6010"
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on NOP_USB_XCEIV = USB_MUSB_HDRC # both built-in or both modules
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
@@ -85,6 +87,7 @@ config USB_MUSB_AM35X
 config USB_MUSB_DSPS
 	tristate "TI DSPS platforms"
 	select USB_MUSB_AM335X_CHILD
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on OF_IRQ
 
 config USB_MUSB_BLACKFIN
@@ -93,6 +96,7 @@ config USB_MUSB_BLACKFIN
 
 config USB_MUSB_UX500
 	tristate "Ux500 platforms"
+	depends on ARCH_U8500 || COMPILE_TEST
 
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
