From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: dma: Remove the wrong dev_id check
Date: Thu, 13 Jun 2013 18:39:18 +0530
Message-ID: <1371128960-24822-2-git-send-email-rnayak@ti.com>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36506 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab3FMNKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:10:01 -0400
In-Reply-To: <1371128960-24822-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Once a free channel is found, the check for dev_id == 0 does
not make any sense. Get rid of it.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index e06c34b..2f99331 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -701,8 +701,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
 			free_ch = ch;
-			if (dev_id == 0)
-				break;
+			/* Exit after first free channel found */
+			break;
 		}
 	}
 	if (free_ch == -1) {
-- 
1.7.9.5

