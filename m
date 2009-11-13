From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/14] omap: update plat/usb.h to allow ehci driver to build
Date: Thu, 12 Nov 2009 16:07:22 -0800
Message-ID: <20091113000722.9034.21826.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53991 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbZKMAHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:07:20 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Add missing declarations to allow the recently introduced
ehci-omap driver to build on OMAP3

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/plat-omap/include/plat/usb.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 33e72ca..33a500e 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -5,6 +5,21 @@
 
 #include <plat/board.h>
 
+#define OMAP3_HS_USB_PORTS	3
+enum ehci_hcd_omap_mode {
+	EHCI_HCD_OMAP_MODE_UNKNOWN,
+	EHCI_HCD_OMAP_MODE_PHY,
+	EHCI_HCD_OMAP_MODE_TLL,
+};
+
+struct ehci_hcd_omap_platform_data {
+	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
+	unsigned			phy_reset:1;
+
+	/* have to be valid if phy_reset is true and portx is in phy mode */
+	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
+};
+
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -29,6 +44,8 @@
 
 extern void usb_musb_init(void);
 
+extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
+
 #endif
 
 void omap_usb_init(struct omap_usb_config *pdata);

