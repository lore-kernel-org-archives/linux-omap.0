From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH v2 4/4] musb: omap2430: avoid pm_runtime_disable()
Date: Mon, 19 Dec 2011 22:17:51 +0200
Message-ID: <1324325871-15137-5-git-send-email-felipe.contreras@nokia.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:23471 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1LSUTy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 15:19:54 -0500
In-Reply-To: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

These are handled by drivers core, and in a way that doesn't wake up the
devices.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/usb/musb/omap2430.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 521d806..66c1b8d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -328,7 +328,6 @@ static int omap2430_musb_init(struct musb *musb)
 	return 0;
 
 err1:
-	pm_runtime_disable(dev);
 	return status;
 }
 
@@ -472,7 +471,6 @@ static int __exit omap2430_remove(struct platform_device *pdev)
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	kfree(glue);
 
 	return 0;
-- 
1.7.8

