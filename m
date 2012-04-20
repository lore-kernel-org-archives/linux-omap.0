From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] USB: OTG: isp1301_omap: resolve unused variable warning from
 gcc
Date: Fri, 20 Apr 2012 15:29:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204201527350.11306@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2DTV3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 17:29:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


Resolve this build warning:

drivers/usb/otg/isp1301_omap.c: In function 'isp1301_set_peripheral':
drivers/usb/otg/isp1301_omap.c:1340:6: warning: unused variable 'l'

This shows up when building with the 'omap1_defconfig' and
'5912osk_testconfig' configs from git://git.pwsan.com/omap_kconfigs.

Compile-tested only.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/usb/otg/isp1301_omap.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index 70cf5d7..33cd709 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1336,9 +1336,6 @@ static int
 isp1301_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
 {
 	struct isp1301	*isp = container_of(otg->phy, struct isp1301, phy);
-#ifndef	CONFIG_USB_OTG
-	u32 l;
-#endif
 
 	if (!otg || isp != the_transceiver)
 		return -ENODEV;
@@ -1365,10 +1362,14 @@ isp1301_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
 	otg->gadget = gadget;
 	// FIXME update its refcount
 
-	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
-	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
-	l |= OTG_ID;
-	omap_writel(l, OTG_CTRL);
+	{
+		u32 l;
+
+		l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+		l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
+		l |= OTG_ID;
+		omap_writel(l, OTG_CTRL);
+	}
 
 	power_up(isp);
 	isp->phy.state = OTG_STATE_B_IDLE;
-- 
1.7.10

