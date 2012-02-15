From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/2] mfd: omap-usb-host: Move usbhs init before allocing child dev
Date: Wed, 15 Feb 2012 15:53:34 +0530
Message-ID: <1329301414-31003-3-git-send-email-govindraj.raja@ti.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41145 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757981Ab2BOKYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 05:24:31 -0500
In-Reply-To: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

There could be possible race condition where the host dev's
are alloced and added to platform dev just before usbhs_init.
Just move usbhs_init before adding child dev.

CC: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/mfd/omap-usb-host.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 3109b0a..c5d48ce 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -799,14 +799,13 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 
+	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
 		dev_err(dev, "omap_usbhs_alloc_children failed\n");
 		goto err_alloc;
 	}
 
-	omap_usbhs_init(dev);
-
 	goto end_probe;
 
 err_alloc:
-- 
1.7.5.4

