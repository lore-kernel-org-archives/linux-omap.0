From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap-git 3/5] add missing otg_put_transceiver() call
Date: Mon, 1 Dec 2008 13:17:25 -0800
Message-ID: <200812011317.25762.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:40061 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751516AbYLAVyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 16:54:35 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Philipp Zabel <philipp.zabel@gmail.com>

As Russell King points out, calling put_device(otg_transceiver->dev)
directly in driver cleanup paths makes assumptions about otg_transceiver
internals.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/plat-omap/usb.c      |    6 ++++++
 drivers/usb/gadget/omap_udc.c |    4 ++--
 include/linux/usb/otg.h       |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -96,6 +96,12 @@ struct otg_transceiver *otg_get_transcei
 }
 EXPORT_SYMBOL(otg_get_transceiver);
 
+void otg_put_transceiver(struct otg_transceiver *x)
+{
+	put_device(x->dev);
+}
+EXPORT_SYMBOL(otg_put_transceiver);
+
 int otg_set_transceiver(struct otg_transceiver *x)
 {
 	if (xceiv && x)
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -3006,7 +3006,7 @@ cleanup1:
 
 cleanup0:
 	if (xceiv)
-		put_device(xceiv->dev);
+		otg_put_transceiver(xceiv);
 
 	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		clk_disable(hhc_clk);
@@ -3034,7 +3034,7 @@ static int __exit omap_udc_remove(struct
 
 	pullup_disable(udc);
 	if (udc->transceiver) {
-		put_device(udc->transceiver->dev);
+		otg_put_transceiver(udc->transceiver);
 		udc->transceiver = NULL;
 	}
 	omap_writew(0, UDC_SYSCON1);
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -84,6 +84,7 @@ extern int otg_set_transceiver(struct ot
 
 /* for usb host and peripheral controller drivers */
 extern struct otg_transceiver *otg_get_transceiver(void);
+extern void otg_put_transceiver(struct otg_transceiver *);
 
 static inline int
 otg_start_hnp(struct otg_transceiver *otg)
