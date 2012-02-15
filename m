From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] usb: host: ehci: allow ehci_* symbols to be unused
Date: Wed, 15 Feb 2012 09:34:26 +0200
Message-ID: <1329291266-15798-1-git-send-email-balbi@ti.com>
References: <Pine.LNX.4.44L0.1202141505400.1544-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1202141505400.1544-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

not all platforms will use all of those ehci_*
symbols on their hc_driver structure. Sometimes
we might need to provide a modified version of
a certain method or not provide it at all, as is
the case with OMAPs which don't support port handoff
feature.

Whenever we compile a kernel for an OMAP board with
EHCI enabled, we get compile warnings:

drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' \
	defined but not used
drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' \
	defined but not used

In order to cleanup those warnings, we're adding
__maybe_unused annotation to those functions.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

Changes from v1:
	- only add __maybe_used to relinquish_port, port_handed_over
		and port_change

 drivers/usb/host/ehci-hub.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 77bbb23..01011dd 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -107,7 +107,7 @@ static void ehci_handover_companion_ports(struct ehci_hcd *ehci)
 	ehci->owned_ports = 0;
 }
 
-static int ehci_port_change(struct ehci_hcd *ehci)
+static int __maybe_unused ehci_port_change(struct ehci_hcd *ehci)
 {
 	int i = HCS_N_PORTS(ehci->hcs_params);
 
@@ -1076,7 +1076,8 @@ error_exit:
 	return retval;
 }
 
-static void ehci_relinquish_port(struct usb_hcd *hcd, int portnum)
+static void __maybe_unused ehci_relinquish_port(struct usb_hcd *hcd,
+		int portnum)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 
@@ -1085,7 +1086,8 @@ static void ehci_relinquish_port(struct usb_hcd *hcd, int portnum)
 	set_owner(ehci, --portnum, PORT_OWNER);
 }
 
-static int ehci_port_handed_over(struct usb_hcd *hcd, int portnum)
+static int __maybe_unused ehci_port_handed_over(struct usb_hcd *hcd,
+		int portnum)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	u32 __iomem		*reg;
-- 
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
