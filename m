From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 22/23] ehci-omap: Remove defines for clock names
Date: Mon, 23 Feb 2009 20:55:34 +0200
Message-ID: <1235415335-17408-23-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
 <1235415335-17408-19-git-send-email-me@felipebalbi.com>
 <1235415335-17408-20-git-send-email-me@felipebalbi.com>
 <1235415335-17408-21-git-send-email-me@felipebalbi.com>
 <1235415335-17408-22-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43139 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbZBWTAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:00:10 -0500
In-Reply-To: <1235415335-17408-22-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

From: Tony Lindgren <tony@atomide.com>

This just makes it harder to figure out the clock names
when reading the code. If the clock change, they should
get set dynamically.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/host/ehci-omap.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e413601..ebfed95 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -163,13 +163,6 @@ struct ehci_hcd_omap {
 	void __iomem		*ehci_base;
 };
 
-/* Clock names as per clock framework: May change so keep as #defs */
-#define USBHOST_ICKL		"usbhost_ick"
-#define USBHOST_120M_FCLK	"usbhost_120m_fck"
-#define USBHOST_48M_FCLK	"usbhost_48m_fck"
-#define USBHOST_TLL_ICKL	"usbtll_ick"
-#define USBHOST_TLL_FCLK	"usbtll_fck"
-
 /*-------------------------------------------------------------------------*/
 
 static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
@@ -265,21 +258,21 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 
 	/* Enable Clocks for USBHOST */
-	omap->usbhost_ick = clk_get(omap->dev, USBHOST_ICKL);
+	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
 	if (IS_ERR(omap->usbhost_ick)) {
 		ret =  PTR_ERR(omap->usbhost_ick);
 		goto err_host_ick;
 	}
 	clk_enable(omap->usbhost_ick);
 
-	omap->usbhost2_120m_fck = clk_get(omap->dev, USBHOST_120M_FCLK);
+	omap->usbhost2_120m_fck = clk_get(omap->dev, "usbhost_120m_fck");
 	if (IS_ERR(omap->usbhost2_120m_fck)) {
 		ret = PTR_ERR(omap->usbhost2_120m_fck);
 		goto err_host_120m_fck;
 	}
 	clk_enable(omap->usbhost2_120m_fck);
 
-	omap->usbhost1_48m_fck = clk_get(omap->dev, USBHOST_48M_FCLK);
+	omap->usbhost1_48m_fck = clk_get(omap->dev, "usbhost_48m_fck");
 	if (IS_ERR(omap->usbhost1_48m_fck)) {
 		ret = PTR_ERR(omap->usbhost1_48m_fck);
 		goto err_host_48m_fck;
@@ -297,14 +290,14 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 
 	/* Configure TLL for 60Mhz clk for ULPI */
-	omap->usbtll_fck = clk_get(omap->dev, USBHOST_TLL_FCLK);
+	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
 	if (IS_ERR(omap->usbtll_fck)) {
 		ret = PTR_ERR(omap->usbtll_fck);
 		goto err_tll_fck;
 	}
 	clk_enable(omap->usbtll_fck);
 
-	omap->usbtll_ick = clk_get(omap->dev, USBHOST_TLL_ICKL);
+	omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
 	if (IS_ERR(omap->usbtll_ick)) {
 		ret = PTR_ERR(omap->usbtll_ick);
 		goto err_tll_ick;
-- 
1.6.1.3

