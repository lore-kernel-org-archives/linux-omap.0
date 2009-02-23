From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 10/23] usb: host: ehci: move some comments
Date: Mon, 23 Feb 2009 20:55:22 +0200
Message-ID: <1235415335-17408-11-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42664 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbZBWS52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:57:28 -0500
In-Reply-To: <1235415335-17408-10-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Move some of the comments used to separate the code
to more logical places. No functional changes.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f5ffc5b..b7f02f6 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -77,6 +77,7 @@ struct ehci_omap_clock_defs {
 #define USBHOST_48M_FCLK	"usbhost_48m_fck"
 #define USBHOST_TLL_ICKL	"usbtll_ick"
 #define USBHOST_TLL_FCLK	"usbtll_fck"
+
 /*-------------------------------------------------------------------------*/
 
 #ifndef CONFIG_OMAP_EHCI_PHY_MODE
@@ -147,6 +148,7 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 # define omap_usb_utmi_init(x, y)	0
 #endif
 
+/*-------------------------------------------------------------------------*/
 
 /* omap_start_ehc
  *	- Start the TI USBHOST controller
@@ -330,8 +332,6 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
 static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
 	struct ehci_omap_clock_defs *ehci_clocks;
@@ -397,9 +397,10 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 		"Clock to USB host has been disabled\n");
 }
 
+/*-------------------------------------------------------------------------*/
+
 static const struct hc_driver ehci_omap_hc_driver;
 
-/*-------------------------------------------------------------------------*/
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
-- 
1.6.1.3

