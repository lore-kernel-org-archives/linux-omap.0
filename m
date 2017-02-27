From: Franck Demathieu <fdemathieu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: dwc3: Fix incorrect type for utmi mode
Date: Mon, 27 Feb 2017 11:52:46 +0100
Message-ID: <20170227105246.28634-1-fdemathieu@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The utmi mode is unsigned according the dt-bindings.
Fix sparse issue (-Wtypesign):

  drivers/usb/dwc3/dwc3-omap.c:391:50: warning: incorrect type in argument 3 (different signedness)
  drivers/usb/dwc3/dwc3-omap.c:391:50:    expected unsigned int [usertype] *out_value
  drivers/usb/dwc3/dwc3-omap.c:391:50:    got int *<noident>

Signed-off-by: Franck Demathieu <fdemathieu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 2092e46..4a59577 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -392,7 +392,7 @@ static void dwc3_omap_set_utmi_mode(struct dwc3_omap *omap)
 {
 	u32			reg;
 	struct device_node	*node = omap->dev->of_node;
-	int			utmi_mode = 0;
+	u32			utmi_mode = 0;
 
 	reg = dwc3_omap_read_utmi_ctrl(omap);
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
