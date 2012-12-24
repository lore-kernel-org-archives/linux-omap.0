From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC] usb: dwc3: Remove dwc3 dependency on gadget.
Date: Mon, 24 Dec 2012 19:28:33 +0530
Message-ID: <1356357513-8892-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39507 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab2LXNv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Dec 2012 08:51:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, Doug Anderson <dianders@chromium.org>

DWC3 controller curretly depends on CONFIG_USB and CONFIG_USB_GADGET.
Some hardware may like to use only host feature on dwc3.
So, removing the dependency of USB_DWC3 on USB_GADGET
and further modulating the dwc3 core to enable gadget features
only with USB_GADGET.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/Kconfig   |    4 ++--
 drivers/usb/dwc3/Makefile  |    2 +-
 drivers/usb/dwc3/core.h    |    7 +++++++
 drivers/usb/dwc3/debugfs.c |    6 ++++--
 drivers/usb/dwc3/gadget.h  |    8 ++++++++
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index f6a6e07..b70dcf1 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -1,7 +1,7 @@
 config USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
-	depends on (USB && USB_GADGET)
-	select USB_OTG_UTILS
+	depends on USB
+	select USB_OTG_UTILS if USB_GADGET
 	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system has a Dual Role SuperSpeed
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 4502648..8f469cb 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
 dwc3-y					+= host.o
-dwc3-y					+= gadget.o ep0.o
+obj-$(CONFIG_USB_GADGET)               += gadget.o ep0.o
 
 ifneq ($(CONFIG_DEBUG_FS),)
 	dwc3-y				+= debugfs.o
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4999563..4dc7ef2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -865,7 +865,14 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
 
+#ifdef CONFIG_USB_GADGET
 int dwc3_gadget_init(struct dwc3 *dwc);
 void dwc3_gadget_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_gadget_init(struct dwc3 *dwc)
+{ return -EINVAL; }
+static inline void dwc3_gadget_exit(struct dwc3 *dwc)
+{ }
+#endif
 
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index d4a30f1..553bbaa 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -535,7 +535,8 @@ static ssize_t dwc3_testmode_write(struct file *file,
 		testmode = 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_gadget_set_test_mode(dwc, testmode);
+	if (dwc3_gadget_set_test_mode(dwc, testmode))
+		dev_dbg(dwc->dev, "host: Invalid request\n");
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return count;
@@ -638,7 +639,8 @@ static ssize_t dwc3_link_state_write(struct file *file,
 		return -EINVAL;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_gadget_set_link_state(dwc, state);
+	if (dwc3_gadget_set_link_state(dwc, state))
+		dev_dbg(dwc->dev, "host: Invalid request\n");
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return count;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 99e6d72..28e82db 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -105,8 +105,16 @@ static inline void dwc3_gadget_move_request_queued(struct dwc3_request *req)
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status);
 
+#ifdef CONFIG_USB_GADGET
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
 int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
+#else
+static inline int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
+{ return -EINVAL; }
+static inline int dwc3_gadget_set_link_state(struct dwc3 *dwc,
+						enum dwc3_link_state state)
+{ return -EINVAL; }
+#endif
 
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event);
-- 
1.7.6.5

