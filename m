From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v4 1/4] USB : Add empty functions in otg.h
Date: Tue,  2 Feb 2010 17:10:01 +0530
Message-ID: <1265110801-26986-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab0BBLkM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 06:40:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

USB : Add empty functions in otg.h

Add empty functions for usb_nop_xceiv_register()
and usb_nop_xceiv_unregister() in otg.h so that
these functions can be called even when
CONFIG_NOP_USB_XCEIV is not enabled.

It allows to remove ifdef's from board file.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Gupta, Ajay Kumar <ajay.gupta@ti.com>
---
Index: linux-2.6/include/linux/usb/otg.h
===================================================================
--- linux-2.6.orig/include/linux/usb/otg.h
+++ linux-2.6/include/linux/usb/otg.h
@@ -110,9 +110,19 @@ struct otg_transceiver {
 /* for board-specific init logic */
 extern int otg_set_transceiver(struct otg_transceiver *);
 
+#if defined(CONFIG_NOP_USB_XCEIV) || defined(CONFIG_NOP_USB_XCEIV_MODULE)
 /* sometimes transceivers are accessed only through e.g. ULPI */
 extern void usb_nop_xceiv_register(void);
 extern void usb_nop_xceiv_unregister(void);
+#else
+static inline void usb_nop_xceiv_register(void)
+{
+}
+
+static inline void usb_nop_xceiv_unregister(void)
+{
+}
+#endif
 
 /* helpers for direct access thru low-level io interface */
 static inline int otg_io_read(struct otg_transceiver *otg, u32 reg)
