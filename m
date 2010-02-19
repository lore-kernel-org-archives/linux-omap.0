From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] USB: Add empty functions in otg.h
Date: Fri, 19 Feb 2010 15:30:03 -0800
Message-ID: <20100219233003.10559.36613.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51875 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab0BSX3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:16 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Maulik Mankad <x0082077@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Olof Johansson <olof@lixom.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Maulik Mankad <x0082077@ti.com>

Add empty functions for usb_nop_xceiv_register()
and usb_nop_xceiv_unregister() in otg.h so that
these functions can be called even when
CONFIG_NOP_USB_XCEIV is not enabled.

It allows to remove ifdef's from board file.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/usb/otg.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 52bb917..fef0972 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
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

