From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/10] usb: phy: make it a menuconfig
Date: Thu, 7 Mar 2013 11:36:04 +0200
Message-ID: <1362648969-13737-6-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36490 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab3CGJgd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:33 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

We already have a considerable amount of USB
PHY drivers, making it a menuconfig just
prevents us from adding too much churn to
USB's menuconfig.

While at that, also select USB_OTG_UTILS from
this new menuconfig just to keep backwards
compatibility until we manage to remove
that symbol.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/Makefile         |  2 +-
 drivers/usb/phy/Kconfig  | 17 ++++++++++++-----
 drivers/usb/phy/Makefile |  2 +-
 include/linux/usb/phy.h  |  2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index dce39a9..3c200a2 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
-obj-$(CONFIG_USB_OTG_UTILS)	+= usb/
+obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 32ce740..832cd69 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -1,8 +1,17 @@
 #
 # Physical Layer USB driver configuration
 #
-comment "USB Physical Layer drivers"
-	depends on USB || USB_GADGET
+menuconfig USB_PHY
+	tristate "USB Physical Layer drivers"
+	select USB_OTG_UTILS
+	help
+	  USB controllers (those which are host, device or DRD) need a
+	  device to handle the physical layer signalling, commonly called
+	  a PHY.
+
+	  The following drivers add support for such PHY devices.
+
+if USB_PHY
 
 config USB_OTG_UTILS
 	bool
@@ -10,8 +19,6 @@ config USB_OTG_UTILS
 	  Select this to make sure the build includes objects from
 	  the OTG infrastructure directory.
 
-if USB || USB_GADGET
-
 #
 # USB Transceiver Drivers
 #
@@ -206,4 +213,4 @@ config USB_ULPI_VIEWPORT
 	  Provides read/write operations to the ULPI phy register set for
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
 
-endif # USB || OTG
+endif # USB_PHY
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 34488ce..d10a8b3 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -4,7 +4,7 @@
 
 ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
 
-obj-$(CONFIG_USB_OTG_UTILS)		+= phy.o
+obj-$(CONFIG_USB_PHY)			+= phy.o
 
 # transceiver drivers, keep the list sorted
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 15847cb..b001dc3 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -161,7 +161,7 @@ usb_phy_shutdown(struct usb_phy *x)
 }
 
 /* for usb host and peripheral controller drivers */
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 extern struct usb_phy *usb_get_phy(enum usb_phy_type type);
 extern struct usb_phy *devm_usb_get_phy(struct device *dev,
 	enum usb_phy_type type);
-- 
1.8.1.rc1.5.g7e0651a

