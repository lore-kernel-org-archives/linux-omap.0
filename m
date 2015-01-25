From: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata for Synopsis Designware USB3 core
Date: Sun, 25 Jan 2015 16:13:24 +0800
Message-ID: <1422173608-24355-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422173608-24355-1-git-send-email-Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
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

Signed-off-by: Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
---
 drivers/usb/host/xhci-hub.c |    4 ++++
 drivers/usb/host/xhci.c     |   29 +++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |   24 ++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

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
index c50d8d2..aa8e02a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3584,6 +3584,33 @@ command_cleanup:
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
+	if (!(status & PORT_CONNECT) && (status & PORT_CSC))
+		writel(status & PORT_CSC, port_array[0]);
+}
+
 /*
  * At this point, the struct usb_device is about to go away, the device has
  * disconnected, and all traffic has been stopped and the endpoints have been
@@ -3649,6 +3676,8 @@ void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
+	if (xhci->quirks & XHCI_DISCONNECT_QUIRK)
+		xhci_try_to_clear_csc(hcd, udev->portnum);
 	/*
 	 * Event command completion handler will free any data structures
 	 * associated with the slot.  XXX Can free sleep?
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index cc7c5bb..65a65cc 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
