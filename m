From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 09/11] omap: usb: ehci: introduce HSIC mode
Date: Mon, 22 Nov 2010 00:10:12 +0530
Message-ID: <1290364814-4417-10-git-send-email-gadiyar@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
 <1290364814-4417-6-git-send-email-gadiyar@ti.com>
 <1290364814-4417-7-git-send-email-gadiyar@ti.com>
 <1290364814-4417-8-git-send-email-gadiyar@ti.com>
 <1290364814-4417-9-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab0KUSk0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Nov 2010 13:40:26 -0500
In-Reply-To: <1290364814-4417-9-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

The EHCI controller in OMAP4 supports a new interface mode - HSIC.
Add this to the list of modes supported on OMAP3.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 59c7fe7..9b1893f 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -11,6 +11,7 @@ enum ehci_hcd_omap_mode {
 	EHCI_HCD_OMAP_MODE_UNKNOWN,
 	EHCI_HCD_OMAP_MODE_PHY,
 	EHCI_HCD_OMAP_MODE_TLL,
+	EHCI_HCD_OMAP_MODE_HSIC,
 };
 
 enum ohci_omap3_port_mode {
-- 
1.7.0.4

