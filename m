From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 03/16] mfd: omap-usb-tll: introduce and use mode_needs_tll()
Date: Thu, 15 Nov 2012 16:34:01 +0200
Message-ID: <1352990054-14680-4-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52156 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767923Ab2KOOeU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:20 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

This is a handy macro to check if the port requires the
USB TLL module or not. Use it to Enable the TLL module and manage
the clocks.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 943ac14..7054395e 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -99,6 +99,10 @@
 
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
+/* only PHY and UNUSED modes don't need TLL */
+#define mode_needs_tll(x)	((x != OMAP_USBHS_PORT_MODE_UNUSED) && \
+				 (x != OMAP_EHCI_PORT_MODE_PHY))
+
 struct usbtll_omap {
 	void __iomem				*base;
 	int					nch;	/* number of channels */
@@ -216,6 +220,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	unsigned long				flags;
 	int					ret = 0;
 	int					i, ver;
+	bool needs_tll;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
@@ -282,12 +287,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		tll->ch_clk[i] = fck;
 	}
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
-	    is_ehci_tll_mode(pdata->port_mode[1]) ||
-	    is_ehci_tll_mode(pdata->port_mode[2]) ||
-	    is_ohci_port(pdata->port_mode[0]) ||
-	    is_ohci_port(pdata->port_mode[1]) ||
-	    is_ohci_port(pdata->port_mode[2])) {
+	needs_tll = false;
+	for (i = 0; i < tll->nch; i++)
+		needs_tll |= mode_needs_tll(pdata->port_mode[i]);
+
+	if (needs_tll) {
 
 		/* Program Common TLL register */
 		reg = usbtll_read(base, OMAP_TLL_SHARED_CONF);
@@ -386,7 +390,7 @@ static int usbtll_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+		if (mode_needs_tll(pdata->port_mode[i])) {
 			int r;
 			r = clk_enable(tll->ch_clk[i]);
 			if (r) {
@@ -419,7 +423,7 @@ static int usbtll_runtime_suspend(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (is_ehci_tll_mode(pdata->port_mode[i]))
+		if (mode_needs_tll(pdata->port_mode[i]))
 			clk_disable(tll->ch_clk[i]);
 	}
 
-- 
1.7.4.1

