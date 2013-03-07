From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/10] usb: otg: move usb_otg_state_string to usb-common.c
Date: Thu, 7 Mar 2013 11:36:01 +0200
Message-ID: <1362648969-13737-3-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43868 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab3CGJgd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:33 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

otg.c only had a single function definition
which might make more sense to be placed in
usb-common.c. While doing that, we also delete
otg.c since it's now empty.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/otg/Makefile |  3 ---
 drivers/usb/otg/otg.c    | 47 -----------------------------------------------
 drivers/usb/usb-common.c | 26 ++++++++++++++++++++++++++
 include/linux/usb/otg.h  |  7 -------
 4 files changed, 26 insertions(+), 57 deletions(-)
 delete mode 100644 drivers/usb/otg/otg.c

diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index a844b8d..6abc453 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -5,9 +5,6 @@
 ccflags-$(CONFIG_USB_DEBUG)		:= -DDEBUG
 ccflags-$(CONFIG_USB_GADGET_DEBUG)	+= -DDEBUG
 
-# infrastructure
-obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
-
 # transceiver drivers
 obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
deleted file mode 100644
index fd9a4b7..0000000
--- a/drivers/usb/otg/otg.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * otg.c -- USB OTG utility code
- *
- * Copyright (C) 2004 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#include <linux/export.h>
-#include <linux/usb/otg.h>
-
-const char *usb_otg_state_string(enum usb_otg_state state)
-{
-	switch (state) {
-	case OTG_STATE_A_IDLE:
-		return "a_idle";
-	case OTG_STATE_A_WAIT_VRISE:
-		return "a_wait_vrise";
-	case OTG_STATE_A_WAIT_BCON:
-		return "a_wait_bcon";
-	case OTG_STATE_A_HOST:
-		return "a_host";
-	case OTG_STATE_A_SUSPEND:
-		return "a_suspend";
-	case OTG_STATE_A_PERIPHERAL:
-		return "a_peripheral";
-	case OTG_STATE_A_WAIT_VFALL:
-		return "a_wait_vfall";
-	case OTG_STATE_A_VBUS_ERR:
-		return "a_vbus_err";
-	case OTG_STATE_B_IDLE:
-		return "b_idle";
-	case OTG_STATE_B_SRP_INIT:
-		return "b_srp_init";
-	case OTG_STATE_B_PERIPHERAL:
-		return "b_peripheral";
-	case OTG_STATE_B_WAIT_ACON:
-		return "b_wait_acon";
-	case OTG_STATE_B_HOST:
-		return "b_host";
-	default:
-		return "UNDEFINED";
-	}
-}
-EXPORT_SYMBOL(usb_otg_state_string);
diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
index 070b681..0db0a91 100644
--- a/drivers/usb/usb-common.c
+++ b/drivers/usb/usb-common.c
@@ -14,6 +14,32 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb/ch9.h>
+#include <linux/usb/otg.h>
+
+const char *usb_otg_state_string(enum usb_otg_state state)
+{
+	static const char *const names[] = {
+		[OTG_STATE_A_IDLE] = "a_idle",
+		[OTG_STATE_A_WAIT_VRISE] = "a_wait_vrise",
+		[OTG_STATE_A_WAIT_BCON] = "a_wait_bcon",
+		[OTG_STATE_A_HOST] = "a_host",
+		[OTG_STATE_A_SUSPEND] = "a_suspend",
+		[OTG_STATE_A_PERIPHERAL] = "a_peripheral",
+		[OTG_STATE_A_WAIT_VFALL] = "a_wait_vfall",
+		[OTG_STATE_A_VBUS_ERR] = "a_vbus_err",
+		[OTG_STATE_B_IDLE] = "b_idle",
+		[OTG_STATE_B_SRP_INIT] = "b_srp_init",
+		[OTG_STATE_B_PERIPHERAL] = "b_peripheral",
+		[OTG_STATE_B_WAIT_ACON] = "b_wait_acon",
+		[OTG_STATE_B_HOST] = "b_host",
+	};
+
+	if (state < 0 || state >= ARRAY_SIZE(names))
+		return "UNDEFINED";
+
+	return names[state];
+}
+EXPORT_SYMBOL_GPL(usb_otg_state_string);
 
 const char *usb_speed_string(enum usb_device_speed speed)
 {
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 9f9fb39..291e01b 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -36,14 +36,7 @@ struct usb_otg {
 
 };
 
-#ifdef CONFIG_USB_OTG_UTILS
 extern const char *usb_otg_state_string(enum usb_otg_state state);
-#else
-static inline const char *usb_otg_state_string(enum usb_otg_state state)
-{
-	return NULL;
-}
-#endif
 
 /* Context: can sleep */
 static inline int
-- 
1.8.1.rc1.5.g7e0651a

