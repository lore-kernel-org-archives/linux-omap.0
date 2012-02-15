From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev dma mask
Date: Wed, 15 Feb 2012 15:53:33 +0530
Message-ID: <1329301414-31003-2-git-send-email-govindraj.raja@ti.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982Ab2BOKY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 05:24:28 -0500
In-Reply-To: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

Remove the hardcoded magic values for dma mask and use the dma
mask macros available.

CC: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 68ac2c5..3109b0a 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -170,7 +170,7 @@ struct usbhs_hcd_omap {
 /*-------------------------------------------------------------------------*/
 
 const char usbhs_driver_name[] = USBHS_DRIVER_NAME;
-static u64 usbhs_dmamask = ~(u32)0;
+static u64 usbhs_dmamask = DMA_BIT_MASK(32);
 
 /*-------------------------------------------------------------------------*/
 
@@ -223,7 +223,7 @@ static struct platform_device *omap_usbhs_alloc_child(const char *name,
 	}
 
 	child->dev.dma_mask		= &usbhs_dmamask;
-	child->dev.coherent_dma_mask	= 0xffffffff;
+	child->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
 	child->dev.parent		= dev;
 
 	ret = platform_device_add(child);
-- 
1.7.5.4

