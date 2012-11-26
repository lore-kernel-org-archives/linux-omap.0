From: Andy Green <andy.green@linaro.org>
Subject: [RFC PATCH 3/5] usb: hub: add device_path regulator control to
 generic hub
Date: Mon, 26 Nov 2012 12:45:45 +0000
Message-ID: <20121126124544.18106.60130.stgit@build.warmcat.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41661 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab2KZMpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 07:45:49 -0500
In-Reply-To: <20121126123427.18106.4112.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

This adds the config option to associate a regulator with each hub,
when the hub on a specific, interesting device path appears, then
the regular is powered while the logical hub exists.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/usb/core/Kconfig |   10 ++++++++++
 drivers/usb/core/hub.c   |   26 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index f70c1a1..4a91eb1 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -95,3 +95,13 @@ config USB_OTG_BLACKLIST_HUB
 	  and software costs by not supporting external hubs.  So
 	  are "Embedded Hosts" that don't offer OTG support.
 
+config USB_HUB_DEVICE_PATH_REGULATOR
+	bool "Support generic regulators at hubs"
+	select DEVICEPATH
+	depends on USB
+	default n
+	help
+	  Allows you to use the device_path APIs to associate kernel regulators
+	  with dynamically probed USB hubs, so the regulators are enabled
+	  as the appropriate hub instance gets created and disabled as it
+	  is destroyed.
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a815fd2..49ebb5e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/freezer.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -54,7 +55,9 @@ struct usb_hub {
 	struct usb_device	*hdev;
 	struct kref		kref;
 	struct urb		*urb;		/* for interrupt polling pipe */
-
+#ifdef CONFIG_USB_HUB_DEVICE_PATH_REGULATOR
+	struct regulator	*regulator;	/* optional power control */
+#endif
 	/* buffer for urb ... with extra space in case of babble */
 	char			(*buffer)[8];
 	union {
@@ -1594,6 +1597,12 @@ static void hub_disconnect(struct usb_interface *intf)
 	if (hub->hdev->speed == USB_SPEED_HIGH)
 		highspeed_hubs--;
 
+#ifdef CONFIG_USB_HUB_DEVICE_PATH_REGULATOR
+	if (hub->regulator && !IS_ERR(hub->regulator)) {
+		regulator_disable(hub->regulator);
+		regulator_put(hub->regulator);
+	}
+#endif
 	usb_free_urb(hub->urb);
 	kfree(hub->ports);
 	kfree(hub->descriptor);
@@ -1609,6 +1618,9 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+#ifdef CONFIG_USB_HUB_DEVICE_PATH_REGULATOR
+	char *dev_path;
+#endif
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1692,6 +1704,18 @@ descriptor_error:
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_USB_HUB_DEVICE_PATH_REGULATOR
+	/* if a regulator is associated on our device_path, use it */
+	dev_path = kmalloc(MAX_DEV_PATH_SIZE, GFP_KERNEL);
+	if (!device_path_generate(&hdev->dev, dev_path, MAX_DEV_PATH_SIZE)) {
+		dev_info(&hdev->dev, "device_path: %s\n", dev_path);
+		hub->regulator = regulator_get(&hdev->dev, dev_path);
+		if (!IS_ERR(hub->regulator))
+			regulator_enable(hub->regulator);
+	}
+	kfree(dev_path);
+#endif
+
 	kref_init(&hub->kref);
 	INIT_LIST_HEAD(&hub->event_list);
 	hub->intfdev = &intf->dev;

