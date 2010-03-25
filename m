From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 (v2) 01/11] usb: musb: debugfs: musb_exit_debugfs() can be called on probe
Date: Thu, 25 Mar 2010 13:25:18 +0200
Message-ID: <1269516328-28267-2-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

when we fail to probe(), we can call musb_exit_debugfs().
Allow that by removing section annotations.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---

If wanted, this patch can amended with patch available
at:

http://kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-07-usb/usb-musb-add-debugfs-support.patch

 drivers/usb/musb/musb_core.c    |    7 +++++--
 drivers/usb/musb/musb_debugfs.c |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 80bc72c..e2f8bcf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2057,12 +2057,12 @@ bad_config:
 
 	status = musb_init_debugfs(musb);
 	if (status < 0)
-		goto fail2;
+		goto fail4;
 
 #ifdef CONFIG_SYSFS
 	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
 	if (status)
-		goto fail4;
+		goto fail5;
 #endif
 
 	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
@@ -2079,6 +2079,9 @@ bad_config:
 
 	return 0;
 
+fail5:
+	musb_exit_debugfs(musb);
+
 fail4:
 	if (!is_otg_enabled(musb) && is_host_enabled(musb))
 		usb_remove_hcd(musb_to_hcd(musb));
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index b6a27ba..7768634 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -289,7 +289,7 @@ err0:
 	return ret;
 }
 
-void __exit musb_exit_debugfs(struct musb *musb)
+void /* __init_or_exit */ musb_exit_debugfs(struct musb *musb)
 {
 	debugfs_remove_recursive(musb_debugfs_root);
 }
-- 
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
