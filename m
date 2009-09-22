From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 4/4] ehci: update driver with another generic change
Date: Tue, 22 Sep 2009 18:42:12 +0530
Message-ID: <1253625132-15050-4-git-send-email-ajay.gupta@ti.com>
References: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com>
 <1253625132-15050-2-git-send-email-ajay.gupta@ti.com>
 <1253625132-15050-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55549 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499AbZIVNMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 09:12:20 -0400
In-Reply-To: <1253625132-15050-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Update the OMAP EHCI driver in accordance with below patch
introduced in generic EHCI driver.

commit 914b701280a76f96890ad63eb0fa99bf204b961c
USB: EHCI: use the new clear_tt_buffer interface

Without this EHCI becomes unusable when a compound device
DELL USB keyboard)is connected and disconnected.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index a10ecd9..2bf2fff 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -784,6 +784,8 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	.hub_control		= ehci_hub_control,
 	.bus_suspend		= ehci_bus_suspend,
 	.bus_resume		= ehci_bus_resume,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
 MODULE_ALIAS("platform:omap-ehci");
-- 
1.6.2.4

