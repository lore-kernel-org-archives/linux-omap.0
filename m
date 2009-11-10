From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] usbtest: make module param pattern writeable
Date: Mon,  9 Nov 2009 21:24:32 -0600
Message-ID: <1257823472-19369-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366AbZKJDZX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Nov 2009 22:25:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Allow module_param to be writeable. This allows us to change
the parameter if usbtest is built-in in the kernel.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/misc/usbtest.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index a9f06d7..0aa04b7 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -213,8 +213,9 @@ static struct urb *simple_alloc_urb (
 }
 
 static unsigned pattern = 0;
-module_param (pattern, uint, S_IRUGO);
-MODULE_PARM_DESC(pattern, "i/o pattern (0 == zeroes)");
+static unsigned mod_pattern = 0;
+module_param_named(pattern, mod_pattern, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(mod_pattern, "i/o pattern (0 == zeroes)");
 
 static inline void simple_fill_buf (struct urb *urb)
 {
@@ -1567,6 +1568,8 @@ usbtest_ioctl (struct usb_interface *intf, unsigned int code, void *buf)
 
 	// FIXME USBDEVFS_CONNECTINFO doesn't say how fast the device is.
 
+	pattern = mod_pattern;
+
 	if (code != USBTEST_REQUEST)
 		return -EOPNOTSUPP;
 
-- 
1.6.5.1.69.g36942

