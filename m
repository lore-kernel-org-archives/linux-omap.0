From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 7/8] omap: usb: ehci: introduce HSIC mode
Date: Mon, 29 Nov 2010 22:55:36 +0530
Message-ID: <1291051537-23743-8-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53607 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab0K2RZt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 12:25:49 -0500
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

The EHCI controller in OMAP4 supports a new interface mode - HSIC.
Add this to the list of modes supported on OMAP3.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
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

