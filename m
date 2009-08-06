From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 9/9] ehci: update driver with generic change
Date: Thu,  6 Aug 2009 17:37:40 +0530
Message-ID: <1249560460-16306-9-git-send-email-ajay.gupta@ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-6-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-7-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-8-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40916 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbZHFMI5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 08:08:57 -0400
In-Reply-To: <1249560460-16306-8-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Update the OMAP EHCI driver in accordance with below patch
introduced in generic EHCI driver.

commit: b18ffd49e86102a9ed0a1cc83fdafe3891e844e5
USB: EHCI: update toggle state for linked QHs

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 81a0b65..8b944d7 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -761,6 +761,7 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	.urb_enqueue		= ehci_urb_enqueue,
 	.urb_dequeue		= ehci_urb_dequeue,
 	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
 
 	/*
 	 * scheduling support
-- 
1.6.2.4

