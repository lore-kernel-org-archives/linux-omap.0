From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 5/6] dsp: brigde: remove unnecessary memset()
Date: Fri, 21 Aug 2009 13:23:38 +0300
Message-ID: <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65485 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbZHUK1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:27:16 -0400
In-Reply-To: <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

bridge_device is static and thus doesn't need
to be zero-initialized.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 7763346..559d14a 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -335,7 +335,6 @@ static int __init bridge_init(void)
 		unregister_chrdev_region(dev, 1);
 		return result;
 	}
-	memset(bridge_device, 0, sizeof(struct bridge_dev));
 	cdev_init(&bridge_device->cdev, &bridge_fops);
 	bridge_device->cdev.owner = THIS_MODULE;
 	bridge_device->cdev.ops = &bridge_fops;
-- 
1.6.3.3.385.g60647

