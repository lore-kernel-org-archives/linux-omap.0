From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [DSPBRIGDE PATCH 5/6] dsp: brigde: remove unnecessary memset()
Date: Fri, 21 Aug 2009 13:29:57 +0300
Message-ID: <20090821102957.GI31549@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39222 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbZHUKcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:32:11 -0400
Content-Disposition: inline
In-Reply-To: <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "x0095840@ti.com" <x0095840@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Fri, Aug 21, 2009 at 12:23:38PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> bridge_device is static and thus doesn't need
> to be zero-initialized.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

I changed this patch to the following:

==== cut here =====


>From 1a5699476007fdff6beb5a895c74bc15f0bdd223 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Fri, 21 Aug 2009 12:10:00 +0300
Subject: [DSPBRIGDE PATCH 5/6] dsp: brigde: convert kmalloc() memset() to kzalloc()

use kzalloc() instead of manually kmalloc() + memset() later.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 7763346..27e293b 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -329,13 +329,12 @@ static int __init bridge_init(void)
 
 	driver_major = MAJOR(dev);
 
-	bridge_device = kmalloc(sizeof(struct bridge_dev), GFP_KERNEL);
+	bridge_device = kzalloc(sizeof(struct bridge_dev), GFP_KERNEL);
 	if (!bridge_device) {
 		result = -ENOMEM;
 		unregister_chrdev_region(dev, 1);
 		return result;
 	}
-	memset(bridge_device, 0, sizeof(struct bridge_dev));
 	cdev_init(&bridge_device->cdev, &bridge_fops);
 	bridge_device->cdev.owner = THIS_MODULE;
 	bridge_device->cdev.ops = &bridge_fops;
-- 
1.6.3.3.385.g60647



-- 
balbi
