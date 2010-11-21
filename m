From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/11] usb: ehci-omap: use clkdev aliases for functional clocks
Date: Mon, 22 Nov 2010 00:10:08 +0530
Message-ID: <1290364814-4417-6-git-send-email-gadiyar@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290364814-4417-5-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use the recently updated aliases to get functional clocks needed by
the driver. This allows the driver to acquire OMAP4-specific clocks
without having to use different clock names for OMAP3 and OMAP4.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index d60efdc..7a4682c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -287,14 +287,14 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 	clk_enable(omap->usbhost_ick);
 
-	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+	omap->usbhost_hs_fck = clk_get(omap->dev, "hs_fck");
 	if (IS_ERR(omap->usbhost_hs_fck)) {
 		ret = PTR_ERR(omap->usbhost_hs_fck);
 		goto err_host_120m_fck;
 	}
 	clk_enable(omap->usbhost_hs_fck);
 
-	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+	omap->usbhost_fs_fck = clk_get(omap->dev, "fs_fck");
 	if (IS_ERR(omap->usbhost_fs_fck)) {
 		ret = PTR_ERR(omap->usbhost_fs_fck);
 		goto err_host_48m_fck;
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
