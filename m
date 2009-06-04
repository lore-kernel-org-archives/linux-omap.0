From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Thu,  4 Jun 2009 16:26:17 +0300
Message-ID: <1244121977-24927-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57600 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZFDN0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 09:26:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index c3d8a02..f41e153 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -665,7 +665,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 }
 
 /* This function provides IO interface to the bridge driver. */
-static int bridge_ioctl(struct file *filp, unsigned int code,
+static long bridge_ioctl(struct file *filp, unsigned int code,
 		unsigned long args)
 {
 	int status;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.h b/drivers/dsp/bridge/rmgr/drv_interface.h
index 3e77ed0..dc49210 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.h
+++ b/drivers/dsp/bridge/rmgr/drv_interface.h
@@ -34,7 +34,7 @@ static int __init bridge_init(void);	/* Initialize bridge */
 static void __exit bridge_exit(void);	/* Opposite of initialize */
 static int bridge_open(struct inode *, struct file *);	/* Open */
 static int bridge_release(struct inode *, struct file *);	/* Release */
-static int bridge_ioctl(struct file *, unsigned int,
+static long bridge_ioctl(struct file *, unsigned int,
 			unsigned long);
 static int bridge_mmap(struct file *filp, struct vm_area_struct *vma);
 #endif				/* ifndef _DRV_INTERFACE_H_ */
-- 
1.6.2.4

