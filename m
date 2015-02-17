From: Sneeker Yeh <sneeker.yeh@gmail.com>
Subject: [PATCH v4 1/5] xhci: add a quirk for device disconnection errata for Synopsis Designware USB3 core
Date: Tue, 17 Feb 2015 13:41:33 +0800
Message-ID: <1424151697-2084-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

This issue is defined by a three-way race at disconnect, between
1) Class driver interrupt endpoint resheduling attempts if the ISR gave an ep
   error event due to device detach (it would try 3 times)
2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
   asynchronously
3) The hardware IP was configured in silicon with
   - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1
   - Synopsys IP version is < 3.00a
The IP will auto-suspend itself on device detach with some phy-specific interval
after CSC is cleared by 2)

If 2) and 3) complete before 1), the interrupts it expects will not be generated
by the autosuspended IP, leading to a deadlock. Even later disconnection
procedure would detect that corresponding urb is still in-progress and issue a
ep stop command, auto-suspended IP still won't respond to that command.

this defect would result in this when device detached:
-------------------------------------------------------
[   99.603544] usb 4-1: USB disconnect, device number 2
[  104.615254] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  104.623362] xhci-hcd xhci-hcd.0.auto: Assuming host is dying, halting host.
[  104.653261] xhci-hcd xhci-hcd.0.auto: Host not halted after 16000 microseconds.
[  104.660584] xhci-hcd xhci-hcd.0.auto: Non-responsive xHCI host is not halting.
[  104.667817] xhci-hcd xhci-hcd.0.auto: Completing active URBs anyway.
[  104.674198] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
------------------------------------------------------
As a result, when device detached, we desired to postpone "PORTCSC clear" behind
"disable slot". it's found that all executed ep command related to disconnetion,
are executed before "disable slot".

Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
---
 drivers/usb/host/xhci-hub.c |    4 ++++
 drivers/usb/host/xhci.c     |   31 +++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |   24 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index a7865c4..3b8f7fc 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -368,6 +368,10 @@ static void xhci_clear_port_change_bit(struct xhci_hcd *xhci, u16 wValue,
 		port_change_bit = "warm(BH) reset";
 		break;
 	case USB_PORT_FEAT_C_CONNECTION:
+		if ((xhci->quirks & XHCI_DISCONNECT_QUIRK) &&
+		    !(readl(addr) & PORT_CONNECT))
+			return;
+
 		status = PORT_CSC;
 		port_change_bit = "connect";
 		break;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ec8ac16..1fb8c1c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3580,6 +3580,35 @@ command_cleanup:
 	return ret;
 }
 
+static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int dev_port_num)
+{
+	int max_ports;
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	__le32 __iomem **port_array;
+	u32 status;
+
+	/* print debug info */
+	if (hcd->speed == HCD_USB3) {
+		max_ports = xhci->num_usb3_ports;
+		port_array = xhci->usb3_ports;
+	} else {
+		max_ports = xhci->num_usb2_ports;
+		port_array = xhci->usb2_ports;
+	}
+
+	if (dev_port_num > max_ports) {
+		xhci_err(xhci, "%s() port number invalid", __func__);
+		return;
+	}
+	status = readl(port_array[dev_port_num - 1]);
+
+	/* write 1 to clear */
+	if (!(status & PORT_CONNECT) && (status & PORT_CSC)) {
+		status = xhci_port_state_to_neutral(status);
+		writel(status | PORT_CSC, port_array[dev_port_num - 1]);
+	}
+}
+
 /*
  * At this point, the struct usb_device is about to go away, the device has
  * disconnected, and all traffic has been stopped and the endpoints have been
@@ -3645,6 +3674,8 @@ void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
+	if (xhci->quirks & XHCI_DISCONNECT_QUIRK)
+		xhci_try_to_clear_csc(hcd, udev->portnum);
 	/*
 	 * Event command completion handler will free any data structures
 	 * associated with the slot.  XXX Can free sleep?
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 9745147..cb74706 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1560,6 +1560,30 @@ struct xhci_hcd {
 #define XHCI_SPURIOUS_WAKEUP	(1 << 18)
 /* For controllers with a broken beyond repair streams implementation */
 #define XHCI_BROKEN_STREAMS	(1 << 19)
+/*
+ * This issue is defined by a three-way race at disconnect in Synopsis USB3 IP,
+ * between
+ * 1) Class driver interrupt endpoint resheduling attempts if the ISR gave an ep
+ *    error event due to device detach (it would try 3 times)
+ * 2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
+ *    asynchronously
+ * 3) The hardware IP was configured in silicon with
+ *    - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1
+ *    - Synopsys IP version is < 3.00a
+ *    The IP will auto-suspend itself on device detach with some phy-specific
+ *    interval after CSC is cleared by 2)
+ *
+ * If 2) and 3) complete before 1), the interrupts it expects will not be
+ * generated by the autosuspended IP, leading to a deadlock. Even later
+ * disconnection procedure would detect that corresponding urb is still
+ * in-progress and issue a ep stop command, auto-suspended IP still won't
+ * respond to that command.
+ *
+ * As a result, when device detached, it's needed to postpone "PORTCSC clear"
+ * behind "disable slot". it's found that all executed ep command related to
+ * disconnetion, are executed before "disable slot".
+ */
+#define XHCI_DISCONNECT_QUIRK	(1 << 20)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
-- 
1.7.9.5
