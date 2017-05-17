From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/4] usb: host: ohci-omap3: Print warning to get people to use ohci-platform
Date: Wed, 17 May 2017 15:59:21 -0700
Message-ID: <20170517225922.17723-4-tony@atomide.com>
References: <20170517225922.17723-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170517225922.17723-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We can't just remove ohci-omap3 as that could make some people's
systems unusable for keyboard and mouse. Let's print a warning for
now, and then remove the driver in a year or so.

Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/host/ohci-omap3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -130,6 +130,9 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 		dev_dbg(dev, "failed to add hcd with err %d\n", ret);
 		goto err_add_hcd;
 	}
+
+	WARN(1, "ohci-omap3 is deprecated, please use ohci-platform instead\n");
+
 	device_wakeup_enable(hcd->self.controller);
 
 	return 0;
-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
