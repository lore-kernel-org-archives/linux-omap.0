From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH] usb: dwc3: Fix compilation break when building with
 USB_DWC3_DUAL_ROLE=y
Date: Tue, 14 May 2013 17:32:16 +0530
Message-ID: <1368532936-3768-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iG9eGsJT3PcjN3DMwEF1z2vzmQUK+0spx6JV9FsacRRhw@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAFp+6iG9eGsJT3PcjN3DMwEF1z2vzmQUK+0spx6JV9FsacRRhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org, jencce.kernelmentor@gmail.com, sfr@canb.auug.org.au, gautam.vivek@samsung.com, Felipe Balbi <balbi@ti.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

The commit:
388e5c5 usb: dwc3: remove dwc3 dependency on host AND gadget
breaks compilation when
USB=y, USB_GADGET=m, USB_DWC3=y and USB_DWC3_DUAL_ROLE=y.

drivers/built-in.o: In function `dwc3_gadget_giveback':
drivers/usb/dwc3/gadget.c:271: undefined reference to `usb_gadget_unmap_request'
drivers/built-in.o: In function `__dwc3_gadget_kick_transfer':
drivers/usb/dwc3/gadget.c:1005: undefined reference to `usb_gadget_unmap_request'
drivers/built-in.o: In function `__dwc3_gadget_ep_queue':
drivers/usb/dwc3/gadget.c:1073: undefined reference to `usb_gadget_map_request'
drivers/built-in.o: In function `dwc3_gadget_reset_interrupt':
drivers/usb/dwc3/gadget.c:2165: undefined reference to `usb_gadget_set_state'
drivers/built-in.o: In function `dwc3_gadget_init':
drivers/usb/dwc3/gadget.c:2647: undefined reference to `usb_add_gadget_udc'
drivers/built-in.o: In function `dwc3_gadget_exit':
drivers/usb/dwc3/gadget.c:2681: undefined reference to `usb_del_gadget_udc'
drivers/built-in.o: In function `__dwc3_ep0_do_control_data':
drivers/usb/dwc3/ep0.c:929: undefined reference to `usb_gadget_map_request'
drivers/usb/dwc3/ep0.c:906: undefined reference to `usb_gadget_map_request'
drivers/built-in.o: In function `dwc3_ep0_set_config':
drivers/usb/dwc3/ep0.c:575: undefined reference to `usb_gadget_set_state'
drivers/built-in.o: In function `dwc3_ep0_set_address':
drivers/usb/dwc3/ep0.c:520: undefined reference to `usb_gadget_set_state'
drivers/usb/dwc3/ep0.c:522: undefined reference to `usb_gadget_set_state'
drivers/built-in.o: In function `dwc3_ep0_set_config':
drivers/usb/dwc3/ep0.c:556: undefined reference to `usb_gadget_set_state'

Making changes similar to patch:
71a5e61 usb: chipidea: fix and improve dependencies if usb host or gadget support is built as module

Let us limit the DWC3 mode to depend on corresponding usb-subsystem
and USB_DWC3.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/usb/dwc3/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index ea5ee9c..757aa18 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -19,21 +19,21 @@ choice
 
 config USB_DWC3_HOST
 	bool "Host only mode"
-	depends on USB
+	depends on USB=y || USB=USB_DWC3
 	help
 	  Select this when you want to use DWC3 in host mode only,
 	  thereby the gadget feature will be regressed.
 
 config USB_DWC3_GADGET
 	bool "Gadget only mode"
-	depends on USB_GADGET
+	depends on USB_GADGET=y || USB_GADGET=USB_DWC3
 	help
 	  Select this when you want to use DWC3 in gadget mode only,
 	  thereby the host feature will be regressed.
 
 config USB_DWC3_DUAL_ROLE
 	bool "Dual Role mode"
-	depends on (USB && USB_GADGET)
+	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
 	help
 	  This is the default mode of working of DWC3 controller where
 	  both host and gadget features are enabled.
-- 
1.7.6.5
