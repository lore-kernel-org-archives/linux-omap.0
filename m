From: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [patch] dwc3: add a kfree() on error to dwc3_testmode_open()
Date: Fri, 26 Aug 2011 12:21:13 +0300
Message-ID: <20110826092113.GO5975@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We may as well fix this potential leak so we don't have to listen to
the static checkers complain.

Signed-off-by: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Btw.  This function returns -EBUSY on success.  Was that really what
you want?

diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 432df53..dd861c4 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -445,8 +445,10 @@ static int dwc3_testmode_open(struct inode *inode, struct file *file)
 	if (!buf0)
 		return -ENOMEM;
 	buf1 = kmalloc(BUF_SIZE, GFP_KERNEL);
-	if (!buf1)
+	if (!buf1) {
+		kfree(buf0);
 		return -ENOMEM;
+	}
 
 	memset(buf0, 0xaa, BUF_SIZE);
 	memset(buf1, 0x33, BUF_SIZE);
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
