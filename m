From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] OMAP2/3: DMA errata correction
Date: Wed, 05 Aug 2009 17:14:27 +0300
Message-ID: <20090805141427.1964.66931.stgit@localhost>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52784 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934128AbZHEOOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:14:35 -0400
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Nishant Kamat <nskamat@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita@ti.com>

This errata is valid for:
OMAP2420 Errata 1.85 Impacts all 2420 ES rev
OMAP2430 Errata 1.10 Impacts only ES1.0
Description: DMA may hang when several channels are used in parallel
OMAP3430: Not impacted, so remove the errata fix for omap3

Fixed issue reported on cpu_is_omap24xx check reported by Nishant Kamat

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7677a4a..e3ac94f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -946,7 +946,9 @@ void omap_start_dma(int lch)
 
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-	} else if (cpu_class_is_omap2()) {
+	} else if (cpu_is_omap242x() ||
+		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
+
 		/* Errata: Need to write lch even if not using chaining */
 		dma_write(lch, CLNK_CTRL(lch));
 	}

