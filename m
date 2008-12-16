From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH] USB: OTG: twl4030 build fix
Date: Mon, 15 Dec 2008 16:00:03 -0800
Message-ID: <1229385603-27035-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/usb/otg/twl4030-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index a000fb3..416e441 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -696,7 +696,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 
 static struct platform_driver twl4030_usb_driver = {
 	.probe		= twl4030_usb_probe,
-	.remove		= __exit_p(twl4030_remove),
+	.remove		= __exit_p(twl4030_usb_remove),
 	.driver		= {
 		.name	= "twl4030_usb",
 		.owner	= THIS_MODULE,
-- 
1.6.0.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
