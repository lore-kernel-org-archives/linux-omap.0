From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: multi-omap: Allow build to work
Date: Tue, 16 Feb 2010 21:11:36 +0530
Message-ID: <1266334896-30686-24-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-14-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-17-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-18-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-19-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-20-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-21-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-22-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-23-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814Ab0BPPmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:42:20 -0500
In-Reply-To: <1266334896-30686-23-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The musb support is enable to omap3 platforms. For omap4 only board
support is available and the driver still isn't supported.
Because of this build with omap3_defconfig used for multi-omap
doesn't work on omap4430 sdp.

This patch hacks the musb probe to keep the multi-omap build
working on omap4430 sdp

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/usb/musb/musb_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index bcce8e8..13b1c4a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2124,6 +2124,10 @@ static int __init musb_probe(struct platform_device *pdev)
 	struct resource	*iomem;
 	void __iomem	*base;
 
+	/* FIXME: multi-omap build to work on omap4 */
+	if (cpu_is_omap44xx())
+		return 0;
+
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem || irq == 0)
 		return -ENODEV;
-- 
1.6.0.4

