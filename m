From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 2/4] usb: ch9: add function defines from ch9, USB 3.0 spec
Date: Mon, 15 Aug 2011 18:57:23 +0300
Message-ID: <1313423845-2288-3-git-send-email-balbi@ti.com>
References: <1313423845-2288-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51300 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1HOP5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Aug 2011 11:57:35 -0400
In-Reply-To: <1313423845-2288-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

not to confuse with Table 9-7 in USB 2.0 spec

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/usb/ch9.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 0fd3fbd..b777e24 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -143,6 +143,11 @@
 #define USB_INTRF_FUNC_SUSPEND	0	/* function suspend */
 
 #define USB_INTR_FUNC_SUSPEND_OPT_MASK	0xFF00
+/*
+ * Suspend Options, Table 9-7 USB 3.0 spec
+ */
+#define USB_INTRF_FUNC_SUSPEND_LP	(1 << (8 + 0))
+#define USB_INTRF_FUNC_SUSPEND_RW	(1 << (8 + 1))
 
 #define USB_ENDPOINT_HALT		0	/* IN/OUT will STALL */
 
-- 
1.7.6.396.ge0613

