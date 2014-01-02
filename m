From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 01/26] dmaengine: omap-dma: use devm_kzalloc() to
 allocate omap_dmadev.
Date: Thu, 02 Jan 2014 15:07:01 +0000
Message-ID: <E1VyjrR-0004zN-P4@rmk-PC.arm.linux.org.uk>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751959AbaABPPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:03 -0500
In-Reply-To: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead, org@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Use devm_kzalloc() to allocate omap_dmadev() so that we don't need
complex error cleanup paths.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 2f66cf4e54fe..d9349be33bdf 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -594,7 +594,6 @@ static void omap_dma_free(struct omap_dmadev *od)
 		tasklet_kill(&c->vc.task);
 		kfree(c);
 	}
-	kfree(od);
 }
 
 static int omap_dma_probe(struct platform_device *pdev)
@@ -602,7 +601,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	struct omap_dmadev *od;
 	int rc, i;
 
-	od = kzalloc(sizeof(*od), GFP_KERNEL);
+	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
 		return -ENOMEM;
 
-- 
1.7.4.4

