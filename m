From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] USB: MUSB: Add OMAP4 support in MUSB driver
Date: Thu, 25 Feb 2010 12:06:25 +0530
Message-ID: <1267079785-14529-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds CONFIG_ARCH_OMAP4 macro within MUSB driver
code and builds the MUSB driver for OMAP4.

Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---
Index: mainline/drivers/usb/musb/Makefile
===================================================================
--- mainline.orig/drivers/usb/musb/Makefile
+++ mainline/drivers/usb/musb/Makefile
@@ -22,6 +22,10 @@ ifeq ($(CONFIG_ARCH_OMAP3430),y)
 	musb_hdrc-objs	+= omap2430.o
 endif
 
+ifeq ($(CONFIG_ARCH_OMAP4),y)
+	musb_hdrc-objs  += omap2430.o
+endif
+
 ifeq ($(CONFIG_BF54x),y)
 	musb_hdrc-objs	+= blackfin.o
 endif
Index: mainline/drivers/usb/musb/musb_core.c
===================================================================
--- mainline.orig/drivers/usb/musb/musb_core.c
+++ mainline/drivers/usb/musb/musb_core.c
@@ -982,7 +982,8 @@ static void musb_shutdown(struct platfor
  * more than selecting one of a bunch of predefined configurations.
  */
 #if defined(CONFIG_USB_TUSB6010) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) \
+	|| defined(CONFIG_ARCH_OMAP4)
 static ushort __initdata fifo_mode = 4;
 #else
 static ushort __initdata fifo_mode = 2;
@@ -1468,7 +1469,8 @@ static int __init musb_core_init(u16 mus
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430) || \
+	defined(CONFIG_ARCH_OMAP4)
 
 static irqreturn_t generic_interrupt(int irq, void *__hci)
 {
Index: mainline/drivers/usb/musb/musb_core.h
===================================================================
--- mainline.orig/drivers/usb/musb/musb_core.h
+++ mainline/drivers/usb/musb/musb_core.h
@@ -204,7 +204,8 @@ enum musb_g_ep0_state {
  */
 
 #if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430) \
-		|| defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_BLACKFIN)
+		|| defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_BLACKFIN) \
+		|| defined(CONFIG_ARCH_OMAP4)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
@@ -555,7 +556,8 @@ extern void musb_hnp_stop(struct musb *m
 extern int musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 
 #if defined(CONFIG_USB_TUSB6010) || defined(CONFIG_BLACKFIN) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) || \
+	defined(CONFIG_ARCH_OMAP4)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 #else
 #define musb_platform_try_idle(x, y)		do {} while (0)
Index: mainline/drivers/usb/musb/omap2430.h
===================================================================
--- mainline.orig/drivers/usb/musb/omap2430.h
+++ mainline/drivers/usb/musb/omap2430.h
@@ -10,7 +10,8 @@
 #ifndef __MUSB_OMAP243X_H__
 #define __MUSB_OMAP243X_H__
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430) \
+	|| defined(CONFIG_ARCH_OMAP4)
 #include <mach/hardware.h>
 #include <plat/usb.h>
 
@@ -23,6 +24,8 @@
 #define	OMAP_HSOTG_BASE		(OMAP243X_HS_BASE)
 #elif	defined(CONFIG_ARCH_OMAP3430)
 #define	OMAP_HSOTG_BASE		(OMAP34XX_HSUSB_OTG_BASE)
+#elif	defined(CONFIG_ARCH_OMAP4)
+#define OMAP_HSOTG_BASE		(OMAP44XX_HSUSB_OTG_BASE)
 #endif
 #define OMAP_HSOTG(offset)	(OMAP_HSOTG_BASE + 0x400 + (offset))
 #define OTG_REVISION		OMAP_HSOTG(0x0)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
