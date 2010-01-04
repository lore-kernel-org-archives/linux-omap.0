From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Mon,  4 Jan 2010 16:39:59 +0530
Message-ID: <1262603399-13036-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0ADLK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 06:10:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

ARM : OMAP : Add empty functions in header file

Add empty functions for usb_nop_xceiv_register()
and usb_nop_xceiv_unregister() so that these functions
can be called even when CONFIG_NOP_USB_XCEIV is not 
enabled. 

It allows to remove ifdef's from board file.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Gupta, Ajay Kumar <ajay.gupta@ti.com>
---
Index: felipe_musb/include/linux/usb/otg.h
===================================================================
--- felipe_musb.orig/include/linux/usb/otg.h
+++ felipe_musb/include/linux/usb/otg.h
@@ -110,9 +110,19 @@ struct otg_transceiver {
 /* for board-specific init logic */
 extern int otg_set_transceiver(struct otg_transceiver *);
 
+#if defined(CONFIG_USB_NOP_XCEIV)
 /* sometimes transceivers are accessed only through e.g. ULPI */
 extern void usb_nop_xceiv_register(void);
 extern void usb_nop_xceiv_unregister(void);
+#else
+extern inline void usb_nop_xceiv_register()
+{
+}
+
+extern inline void usb_nop_xceiv_unregister()
+{
+}
+#endif
 
 /* helpers for direct access thru low-level io interface */
 static inline int otg_io_read(struct otg_transceiver *otg, u32 reg)
