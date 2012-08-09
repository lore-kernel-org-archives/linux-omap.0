From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH] staging: omapdrm: Fix DMM sparse warnings
Date: Thu, 9 Aug 2012 00:14:56 -0500
Message-ID: <1344489296-16722-1-git-send-email-andy.gross@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39303 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab2HIFPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 01:15:10 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Rob Clark <rob@ti.com>, Greg Kroah-Hartman <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

Fix the following sparse warnings:

drivers/staging/omapdrm/omap_dmm_tiler.c:123:13:
   warning: symbol 'omap_dmm_irq_handler' was not declared.
   Should it be static?

drivers/staging/omapdrm/omap_dmm_tiler.c:370:24:
   warning: Using plain integer as NULL pointer

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 drivers/staging/omapdrm/omap_dmm_tiler.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index 8619783..ec7a5c8 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -120,7 +120,7 @@ static int wait_status(struct refill_engine *engine, uint32_t wait_mask)
 	return 0;
 }
 
-irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
+static irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
 {
 	struct dmm *dmm = arg;
 	uint32_t status = readl(dmm->base + DMM_PAT_IRQSTATUS);
@@ -367,7 +367,7 @@ struct tiler_block *tiler_reserve_1d(size_t size)
 	int num_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	if (!block)
-		return 0;
+		return ERR_PTR(-ENOMEM);
 
 	block->fmt = TILFMT_PAGE;
 
-- 
1.7.5.4

