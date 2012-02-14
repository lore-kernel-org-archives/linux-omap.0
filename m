From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] usb: host: ehci: allow ehci_* symbols to be unused
Date: Tue, 14 Feb 2012 11:14:55 +0200
Message-ID: <1329210895-32513-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33940 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712Ab2BNJPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 04:15:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

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
__maybe_unused annotation to those functions. We're
also trying to cope with other platforms which might
have similar issues with different methods by adding
the same annotation to all ehci_* functions.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Alan, what do you think about this patch ? It fixes our warnings
and tries to cope with other possible such cases.

 drivers/usb/host/ehci-hub.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 77bbb23..d50571b 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -107,7 +107,7 @@ static void ehci_handover_companion_ports(struct ehci_hcd *ehci)
 	ehci->owned_ports = 0;
 }
 
-static int ehci_port_change(struct ehci_hcd *ehci)
+static int __maybe_unused ehci_port_change(struct ehci_hcd *ehci)
 {
 	int i = HCS_N_PORTS(ehci->hcs_params);
 
@@ -201,7 +201,7 @@ static __maybe_unused void ehci_adjust_port_wakeup_flags(struct ehci_hcd *ehci,
 	spin_unlock_irqrestore(&ehci->lock, flags);
 }
 
-static int ehci_bus_suspend (struct usb_hcd *hcd)
+static int __maybe_unused ehci_bus_suspend (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	int			port;
@@ -335,7 +335,7 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
 
 
 /* caller has locked the root hub, and should reset/reinit on error */
-static int ehci_bus_resume (struct usb_hcd *hcd)
+static int __maybe_unused ehci_bus_resume (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	u32			temp;
@@ -550,7 +550,7 @@ static int check_reset_complete (
 
 /* build "status change" packet (one or two bytes) from HC registers */
 
-static int
+static int __maybe_unused
 ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 {
 	struct ehci_hcd	*ehci = hcd_to_ehci (hcd);
@@ -623,7 +623,7 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 
 /*-------------------------------------------------------------------------*/
 
-static void
+static void __maybe_unused
 ehci_hub_descriptor (
 	struct ehci_hcd			*ehci,
 	struct usb_hub_descriptor	*desc
@@ -658,7 +658,7 @@ ehci_hub_descriptor (
 
 /*-------------------------------------------------------------------------*/
 
-static int ehci_hub_control (
+static int __maybe_unused ehci_hub_control (
 	struct usb_hcd	*hcd,
 	u16		typeReq,
 	u16		wValue,
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

