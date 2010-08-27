From: tom.leiming@gmail.com
Subject: [PATCH] USB: musb: move musb debugfs entry under usb debugfs root dir
Date: Fri, 27 Aug 2010 23:45:39 +0800
Message-ID: <1282923939-14872-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33857 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab0H0PqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 11:46:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

All hcd's debugfs entries are under usb debugfs root dir already,
so musb should not be a exception.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/usb/musb/musb_debugfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index c79a5e3..b19c31c 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -257,7 +257,7 @@ int __init musb_init_debugfs(struct musb *musb)
 	struct dentry		*file;
 	int			ret;
 
-	root = debugfs_create_dir("musb", NULL);
+	root = debugfs_create_dir("musb", usb_debug_root);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto err0;
-- 
1.6.2.5

