From: Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: musb: constify dev_pm_ops structures
Date: Sun, 15 Jan 2017 17:30:46 +0530
Message-ID: <1484481646-28544-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: julia.lawall-L2FTfq7BK8M@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Declare dev_pm_ops structures as const as they are only stored in the pm
field of a device_driver structure. This field is of type const, so
dev_pm_ops structures having similar properties can be declared const
too.

Size details after cross compiling the .o file for arm
architecture.

File size before: drivers/usb/musb/omap2430.o
   text	   data	    bss	    dec	    hex	filename
   4141	    400	      8	   4549	   11c5	usb/musb/omap2430.o

File size after: drivers/usb/musb/omap2430.o
   text	   data	    bss	    dec	    hex	filename
   4333	    200	      8	   4541	   11bd	usb/musb/omap2430.o

Signed-off-by: Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 8b73214..456f3e6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -575,7 +575,7 @@ static int omap2430_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap2430_pm_ops = {
+static const struct dev_pm_ops omap2430_pm_ops = {
 	.runtime_suspend = omap2430_runtime_suspend,
 	.runtime_resume = omap2430_runtime_resume,
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
