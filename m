From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] omap: McBSP: Do not use extensive spin locks for
	dma_op_mode
Date: Thu, 12 Nov 2009 16:08:24 -0800
Message-ID: <20091113000824.9034.79893.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52049 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919AbZKMAIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:08:19 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

The use of the spin lock, which supposed to protect the the
dma_op_mode causing "INFO: inconsistent lock state" on
playback start.
Remove the spin locks around the dma_op_mode, when it's
purpuse is to protect the dma_op_mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 9277033..2cc1cc3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -298,9 +298,7 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	spin_lock_irq(&mcbsp->lock);
 	dma_op_mode = mcbsp->dma_op_mode;
-	spin_unlock_irq(&mcbsp->lock);
 
 	return dma_op_mode;
 }
@@ -318,7 +316,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
-		spin_lock_irq(&mcbsp->lock);
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
 					CLOCKACTIVITY(0x02));
@@ -327,7 +324,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		} else {
 			syscon |= SIDLEMODE(0x01);
 		}
-		spin_unlock_irq(&mcbsp->lock);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 	}
@@ -1145,9 +1141,7 @@ static ssize_t dma_op_mode_show(struct device *dev,
 	ssize_t len = 0;
 	const char * const *s;
 
-	spin_lock_irq(&mcbsp->lock);
 	dma_op_mode = mcbsp->dma_op_mode;
-	spin_unlock_irq(&mcbsp->lock);
 
 	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++) {
 		if (dma_op_mode == i)

