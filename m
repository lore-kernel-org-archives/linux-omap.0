From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH 1/4] usb: dwc3: core: Convert to module_platform_driver
Date: Tue, 28 Feb 2012 12:57:20 +0100
Message-ID: <1330430243-4391-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use the module_platform_driver macro.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/usb/dwc3/core.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7c9df63..85a2fbb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -605,19 +605,9 @@ static struct platform_driver dwc3_driver = {
 	},
 };
 
+module_platform_driver(dwc3_driver);
+
 MODULE_ALIAS("platform:dwc3");
 MODULE_AUTHOR("Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
-
-static int __devinit dwc3_init(void)
-{
-	return platform_driver_register(&dwc3_driver);
-}
-module_init(dwc3_init);
