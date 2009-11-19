From: "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Subject: [PATCH] USB: twl4030: Enable USB regulators before enabling USB
 charging
Date: Thu, 19 Nov 2009 12:34:55 -0600
Message-ID: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56919 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZKSSeu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 13:34:50 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

For TWL family of power management ICs, USB charging works only
when USB regulators are in enabled state: 3v1, 1v5, 1v8

On a USB cable attach, twl4030_phy_resume(twl) function enables
the regulators. Enable USB charging, only after all regulators
are enabled.

Its observed that enabling USB charging before regulators are
enabled, causes USB charging to fail.

Tested on: Zoom2: omap3430: ES3.1 + TWL5030
Needs T2-MADC and T2-BCI drivers which are still not upstreamed.

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Acked-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>

---
 drivers/usb/otg/twl4030-usb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..bd9883f 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -598,12 +598,12 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
 		 * starts to handle softconnect right.
 		 */
-		twl4030charger_usb_en(status == USB_LINK_VBUS);
-
 		if (status == USB_LINK_NONE)
 			twl4030_phy_suspend(twl, 0);
 		else
 			twl4030_phy_resume(twl);
+
+		twl4030charger_usb_en(status == USB_LINK_VBUS);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
-- 
1.6.0.4
