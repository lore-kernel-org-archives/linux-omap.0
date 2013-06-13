From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP: dma: Remove the erroneous freeing of platform data
Date: Thu, 13 Jun 2013 19:47:11 +0530
Message-ID: <1371133031-29229-4-git-send-email-rnayak@ti.com>
References: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab3FMORy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 10:17:54 -0400
In-Reply-To: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Given p = pdev->dev.platform_data; and
      d = p->dma_attr;
the freeing of either one of these by the driver
seems just plain wrong.

Get rid of them in the .probe failure path as well as the
.remove.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/dma.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 8a71f75..4d463ca 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2111,8 +2111,6 @@ exit_dma_irq_fail:
 	}
 
 exit_dma_lch_fail:
-	kfree(p);
-	kfree(d);
 	kfree(dma_chan);
 	return ret;
 }
@@ -2133,8 +2131,6 @@ static int omap_system_dma_remove(struct platform_device *pdev)
 			free_irq(dma_irq, (void *)(irq_rel + 1));
 		}
 	}
-	kfree(p);
-	kfree(d);
 	kfree(dma_chan);
 	return 0;
 }
-- 
1.7.9.5

