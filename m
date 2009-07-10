From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] ehci: update driver with generic change
Date: Fri, 10 Jul 2009 19:55:20 +0530
Message-ID: <1247235920-13400-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43146 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbZGJOZg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jul 2009 10:25:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Update the OMAP EHCI driver in accordance with below patch
introduced in generic EHCI driver.

commit: b18ffd49e86102a9ed0a1cc83fdafe3891e844e5
USB: EHCI: update toggle state for linked QHs

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index c0f9a19..858bf11 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -762,6 +762,7 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	.urb_enqueue		= ehci_urb_enqueue,
 	.urb_dequeue		= ehci_urb_dequeue,
 	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
 
 	/*
 	 * scheduling support
-- 
1.6.2.4

