From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 01/11] usb: musb: debugfs: musb_exit_debugfs() can be called on probe
Date: Wed, 24 Mar 2010 14:55:08 +0200
Message-ID: <1269435318-29153-2-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56393 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab0CXM4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:56:02 -0400
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

when we fail to probe(), we can call musb_exit_debugfs().
Allow that by removing section annotations.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c    |    7 +++++--
 drivers/usb/musb/musb_debugfs.c |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 13f36bf..9b88727 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2056,12 +2056,12 @@ bad_config:
 
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
@@ -2078,6 +2078,9 @@ bad_config:
 
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

