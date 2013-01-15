From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH] usb: dwc3: Remove dwc3 dependency on host AND gadget.
Date: Tue, 15 Jan 2013 16:09:21 +0530
Message-ID: <1358246361-16200-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, Doug Anderson <dianders@chromium.org>
List-Id: linux-omap@vger.kernel.org

DWC3 controller curretly depends on USB && USB_GADGET.
Some hardware may like to use only host feature on dwc3,
or only gadget feature.
So, removing this dependency of USB_DWC3 on USB and USB_GADGET.
Adding the mode of operaiton of DWC3 also here
HOST/GADGET/DUAL_ROLE based on which features are enabled.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Doug Anderson <dianders@chromium.org>
---

This patch is outcome of discussion happened on:
[PATCH RFC] usb: dwc3: Remove dwc3 dependency on gadget
http://comments.gmane.org/gmane.linux.ports.arm.omap/91328

Changes from RFC:
        - Making both HOST as well as GADGET optional for dwc3.
        - Adding mode of working of DWC3 controller here:
          HOST/GADGET/DUAL_ROLE
        - Build gadget related features for debugfs in dwc3_debugfs_init()
          only with USB_DWC3_GADGET or USB_DWC3_DUAL_ROLE.

 drivers/usb/dwc3/Kconfig   |   31 +++++++++++++++++++++++++++++--
 drivers/usb/dwc3/Makefile  |   10 ++++++++--
 drivers/usb/dwc3/core.h    |   16 +++++++++++++++-
 drivers/usb/dwc3/debugfs.c |    2 ++
 4 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index f6a6e07..418d058 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -1,6 +1,6 @@
-config USB_DWC3
+menuconfig USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
-	depends on (USB && USB_GADGET)
+	depends on (USB || USB_GADGET)
 	select USB_OTG_UTILS
 	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
 	help
@@ -12,6 +12,33 @@ config USB_DWC3
 
 if USB_DWC3
 
+choice
+	bool "DWC3 mode of working"
+	default USB_DWC3_DUAL_ROLE
+
+config USB_DWC3_HOST
+	bool "Host only mode"
+	depends on USB
+	help
+	  Select this when you want to use DWC3 in host mode only,
+	  thereby the gadget feature will be regressed.
+
+config USB_DWC3_GADGET
+	bool "Gadget only mode"
+	depends on USB_GADGET
+	help
+	  Select this when you want to use DWC3 in gadget mode only,
+	  thereby the host feature will be regressed.
+
+config USB_DWC3_DUAL_ROLE
+	bool "Dual role mode"
+	depends on (USB && USB_GADGET)
+	help
+	  This is the default mode of working of DWC3 controller where
+	  both host and gadget features are enabled.
+
+endchoice
+
 config USB_DWC3_DEBUG
 	bool "Enable Debugging Messages"
 	help
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 4502648..0c7ac92 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -4,8 +4,14 @@ ccflags-$(CONFIG_USB_DWC3_VERBOSE)	+= -DVERBOSE_DEBUG
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
-dwc3-y					+= host.o
-dwc3-y					+= gadget.o ep0.o
+
+ifneq ($(filter y,$(CONFIG_USB_DWC3_HOST) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
+	dwc3-y				+= host.o
+endif
+
+ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
+	dwc3-y				+= gadget.o ep0.o
+endif
 
 ifneq ($(CONFIG_DEBUG_FS),)
 	dwc3-y				+= debugfs.o
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5f79d9f..829b11b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -864,10 +864,24 @@ union dwc3_event {
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 
+#if defined CONFIG_USB_DWC3_HOST || defined CONFIG_USB_DWC3_DUAL_ROLE
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
-
+#else
+static inline int dwc3_host_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_host_exit(struct dwc3 *dwc)
+{ }
+#endif
+
+#if defined CONFIG_USB_DWC3_GADGET || defined CONFIG_USB_DWC3_DUAL_ROLE
 int dwc3_gadget_init(struct dwc3 *dwc);
 void dwc3_gadget_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_gadget_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_gadget_exit(struct dwc3 *dwc)
+{ }
+#endif
 
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index d4a30f1..fc0af8b 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -673,6 +673,7 @@ int __devinit dwc3_debugfs_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
+#if defined CONFIG_USB_DWC3_GADGET || defined CONFIG_USB_DWC3_DUAL_ROLE
 	file = debugfs_create_file("mode", S_IRUGO | S_IWUSR, root,
 			dwc, &dwc3_mode_fops);
 	if (!file) {
@@ -693,6 +694,7 @@ int __devinit dwc3_debugfs_init(struct dwc3 *dwc)
 		ret = -ENOMEM;
 		goto err1;
 	}
+#endif
 
 	return 0;
 
-- 
1.7.6.5
