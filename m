From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] arm: omap: usb: clock enable typo fix in usbhs driver
Date: Tue, 19 Jul 2011 19:41:43 +0530
Message-ID: <1311084703-10266-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The usbhs_disable function was invoking clk_enable api
instead of clk_disable; The clk_disable is called to
disble the port clocks of usbhs

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1717144..29601e7 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -998,9 +998,9 @@ static void usbhs_disable(struct device *dev)
 
 	if (is_omap_usbhs_rev2(omap)) {
 		if (is_ehci_tll_mode(pdata->port_mode[0]))
-			clk_enable(omap->usbtll_p1_fck);
+			clk_disable(omap->usbtll_p1_fck);
 		if (is_ehci_tll_mode(pdata->port_mode[1]))
-			clk_enable(omap->usbtll_p2_fck);
+			clk_disable(omap->usbtll_p2_fck);
 		clk_disable(omap->utmi_p2_fck);
 		clk_disable(omap->utmi_p1_fck);
 	}
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
