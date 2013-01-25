From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
Date: Fri, 25 Jan 2013 08:03:26 +0530
Message-ID: <1359081206-5602-7-git-send-email-kishon@ti.com>
References: <1359081206-5602-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359081206-5602-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The OMAP glue has been modified to get PHY by phandle for dt boot.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
There were some comments w.r.t this patch for returning EPROBE_DEFER if
not able to get the phy, in my previous version.
Currently we can't have that because the gadget driver doesn't do a
EPROBE_DEFER. We have a separate activity planned for making gadget driver
also do EPROBE_DEFER for 3.10.
 drivers/usb/musb/omap2430.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index be6d259..08814d2 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -345,7 +345,12 @@ static int omap2430_musb_init(struct musb *musb)
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
 	 */
-	musb->xceiv = devm_usb_get_phy_dev(dev, 0);
+	if (dev->parent->of_node)
+		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
+		    "usb_phy", 0);
+	else
+		musb->xceiv = devm_usb_get_phy_dev(dev, 0);
+
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		pr_err("HS USB OTG: no transceiver configured\n");
 		return -ENODEV;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
