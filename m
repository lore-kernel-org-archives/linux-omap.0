From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/6] usb: gadget: omap_udc: let it work as a module
Date: Tue, 29 May 2012 15:15:58 +0300
Message-ID: <1338293761-9457-4-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338293761-9457-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

this also helps removing a few lines of boilerplate
code.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/omap_udc.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 5e7b891..814aafb 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2535,7 +2535,7 @@ static inline void remove_proc_file(void) {}
  * UDC_SYSCON_1.CFG_LOCK is set can now work.  We won't use that
  * capability yet though.
  */
-static unsigned __init
+static unsigned __devinit
 omap_ep_setup(char *name, u8 addr, u8 type,
 		unsigned buf, unsigned maxp, int dbuf)
 {
@@ -2653,7 +2653,7 @@ static void omap_udc_release(struct device *dev)
 	udc = NULL;
 }
 
-static int __init
+static int __devinit
 omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 {
 	unsigned	tmp, buf;
@@ -2790,7 +2790,7 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	return 0;
 }
 
-static int __init omap_udc_probe(struct platform_device *pdev)
+static int __devinit omap_udc_probe(struct platform_device *pdev)
 {
 	int			status = -ENODEV;
 	int			hmc;
@@ -3003,7 +3003,7 @@ cleanup0:
 	return status;
 }
 
-static int __exit omap_udc_remove(struct platform_device *pdev)
+static int __devexit omap_udc_remove(struct platform_device *pdev)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
@@ -3088,7 +3088,8 @@ static int omap_udc_resume(struct platform_device *dev)
 /*-------------------------------------------------------------------------*/
 
 static struct platform_driver udc_driver = {
-	.remove		= __exit_p(omap_udc_remove),
+	.probe		= omap_udc_probe,
+	.remove		= __devexit_p(omap_udc_remove),
 	.suspend	= omap_udc_suspend,
 	.resume		= omap_udc_resume,
 	.driver		= {
@@ -3097,17 +3098,7 @@ static struct platform_driver udc_driver = {
 	},
 };
 
-static int __init udc_init(void)
-{
-	return platform_driver_probe(&udc_driver, omap_udc_probe);
-}
-module_init(udc_init);
