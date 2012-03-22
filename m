From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH RESEND] usb: musb: omap: fix crash when musb glue (omap) gets initialized
Date: Thu, 22 Mar 2012 16:05:45 +0530
Message-ID: <1332412545-32396-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49039 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2CVKip (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 06:38:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, stable@vger.kernel.org, linux-omap@vger.kernel.org
Cc: kishon@ti.com

Upstream Commit: 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
Upstream Kernel Tag: v2.6.38-rc5-94-g7acc619

pm_runtime_enable is being called after omap2430_musb_init. Hence
pm_runtime_get_sync in omap2430_musb_init does not have any effect (does
not enable clocks) resulting in a crash during register access. It is
fixed here.

Cc: stable@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Tested MUSB in 4430SDP.
 drivers/usb/musb/omap2430.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2ae0bb3..73bd5ed 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -452,14 +452,14 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err2;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 
 err2:
-- 
1.7.0.4

