From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/3] USB: MUSB: Add OMAP4 support in MUSB driver
Date: Thu, 11 Mar 2010 17:29:21 +0530
Message-ID: <1268308761-21982-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds CONFIG_ARCH_OMAP4 macro within 
MUSB driver.

Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
Index: mainline/drivers/usb/musb/musb_core.c
===================================================================
--- mainline.orig/drivers/usb/musb/musb_core.c
+++ mainline/drivers/usb/musb/musb_core.c
@@ -982,7 +982,8 @@ static void musb_shutdown(struct platfor
  * more than selecting one of a bunch of predefined configurations.
  */
 #if defined(CONFIG_USB_TUSB6010) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
+	|| defined(CONFIG_ARCH_OMAP4)
 static ushort __initdata fifo_mode = 4;
 #else
 static ushort __initdata fifo_mode = 2;
@@ -1457,7 +1458,8 @@ static int __init musb_core_init(u16 mus
 
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
@@ -213,7 +213,8 @@ enum musb_g_ep0_state {
  */
 
 #if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430) \
-		|| defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_BLACKFIN)
+		|| defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_BLACKFIN) \
+		|| defined(CONFIG_ARCH_OMAP4)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
@@ -596,7 +597,8 @@ extern void musb_hnp_stop(struct musb *m
 extern int musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 
 #if defined(CONFIG_USB_TUSB6010) || defined(CONFIG_BLACKFIN) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 #else
 #define musb_platform_try_idle(x, y)		do {} while (0)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
