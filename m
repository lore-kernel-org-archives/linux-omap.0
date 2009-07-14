From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] OMAP: OHCI: hc_driver's stop method should call ohci_stop
Date: Tue, 14 Jul 2009 16:41:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305D662CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33762 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZGNLLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 07:11:11 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Anand Gadiyar <gadiyar@ti.com>

OMAP: OHCI: hc_driver's stop method should call ohci_stop

Without this, the ohci-omap driver will not cleanup the debugfs
nodes when the driver is unloaded. So the next insmod will fail,
if CONFIG_DEBUG_FS and CONFIG_USB_DEBUG are both selected.

Reported-by: vikram pandita <vikram.pandita@ti.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Not tested. I don't have any hardware that uses this driver.

 drivers/usb/host/ohci-omap.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6/drivers/usb/host/ohci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-omap.c
+++ linux-2.6/drivers/usb/host/ohci-omap.c
@@ -282,6 +282,7 @@ static int ohci_omap_init(struct usb_hcd
 static void ohci_omap_stop(struct usb_hcd *hcd)
 {
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
+	ohci_stop(hcd);
 	omap_ohci_clock_power(0);
 }
 
