From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [DSPBRIGDE PATCH 5/6] dsp: brigde: remove unnecessary memset()
Date: Fri, 28 Aug 2009 15:55:02 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF29F3@dlee06.ent.ti.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
 <20090821102957.GI31549@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53994 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbZH1UzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 16:55:14 -0400
In-Reply-To: <20090821102957.GI31549@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

Regards
-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
Sent: Friday, August 21, 2009 5:30 AM
To: Balbi Felipe (Nokia-D/Helsinki)
Cc: Doyu Hiroshi (Nokia-D/Helsinki); Palande Ameya (Nokia-D/Helsinki); Guzman Lugo, Fernando; Linux OMAP Mailing List
Subject: Re: [DSPBRIGDE PATCH 5/6] dsp: brigde: remove unnecessary memset()

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

