From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] usb: gadget: introduce gadget_is_dwc3()
Date: Fri, 19 Aug 2011 18:10:57 +0300
Message-ID: <1313766659-28360-3-git-send-email-balbi@ti.com>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313766659-28360-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

... to check whether we're running on DesignWare
USB3 DRD Controller.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/gadget_chips.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index f3a83cd..a8855d0 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -31,6 +31,7 @@
 #define gadget_is_ci13xxx_msm(g)	(!strcmp("ci13xxx_msm", (g)->name))
 #define gadget_is_ci13xxx_pci(g)	(!strcmp("ci13xxx_pci", (g)->name))
 #define gadget_is_dummy(g)		(!strcmp("dummy_udc", (g)->name))
+#define gadget_is_dwc3(g)		(!strcmp("dwc3-gadget", (g)->name))
 #define gadget_is_fsl_qe(g)		(!strcmp("fsl_qe_udc", (g)->name))
 #define gadget_is_fsl_usb2(g)		(!strcmp("fsl-usb2-udc", (g)->name))
 #define gadget_is_goku(g)		(!strcmp("goku_udc", (g)->name))
@@ -115,6 +116,8 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x30;
 	else if (gadget_is_net2272(gadget))
 		return 0x31;
+	else if (gadget_is_dwc3(gadget))
+		return 0x32;
 
 	return -ENOENT;
 }
-- 
1.7.6.396.ge0613

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
