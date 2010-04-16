From: Viral Mehta <viral.vkm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] Switch to subsys_initcall
Date: Fri, 16 Apr 2010 10:31:04 +0530
Message-ID: <z2g94efb1e51004152201i9b85a41awe00188b8731e855e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>

isp1301 transceiver driver init should be done before we do ohci omap init

Signed-off-by: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
---
V2: no change but sending again as v2 to be in sync with
other 3 patches sent as v2 for omap2430 fsusb fixes.

 drivers/usb/otg/isp1301_omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index 78a2097..4569694 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1654,7 +1654,7 @@ static int __init isp_init(void)
 {
 	return i2c_add_driver(&isp1301_driver);
 }
-module_init(isp_init);
+subsys_initcall(isp_init);

 static void __exit isp_exit(void)
 {
-- 
1.6.6
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
