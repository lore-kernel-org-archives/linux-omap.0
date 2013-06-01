From: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
Subject: [PATCH] usb: dwc3: core: Cocci spatch "odd_ptr_err.spatch"
Date: Sat, 01 Jun 2013 12:10:59 +0200
Message-ID: <1370081459.29224.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
---

diff -u -p a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -450,7 +450,7 @@ static int dwc3_probe(struct platform_de
 	}
 
 	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
+		ret = PTR_ERR(dwc->usb3_phy);
 
 		/*
 		 * if -ENXIO is returned, it means PHY layer wasn't



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
