From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: McSPI: Fix Null pointer check
Date: Thu, 20 May 2010 19:59:50 +0530
Message-ID: <1274365792-24938-2-git-send-email-manjugk@ti.com>
References: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56259 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076Ab0ETOa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 10:30:26 -0400
In-Reply-To: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Satish <x0124230@ti.com>, Tony Lindgren <tony@atomide.com>

From: Satish <x0124230@ti.com>

Fix Null pointer check for pointer r in omap2_mcspi_remove() function.

Signed-off-by: Satish Kumar <x0124230@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/spi/omap2_mcspi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index e0de0d0..a95d306 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1198,6 +1198,8 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
 	clk_put(mcspi->ick);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -EINVAL;
 	release_mem_region(r->start, (r->end - r->start) + 1);
 
 	base = mcspi->base;
-- 
1.7.0.4

