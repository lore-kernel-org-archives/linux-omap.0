From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] omap: Fix race condition in omap dma driver
Date: Tue, 10 Nov 2009 19:00:32 -0800
Message-ID: <20091111030032.31793.59189.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55063 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZKKDA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:00:29 -0500
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fei Yang <AFY095@motorola.com>, linux-omap@vger.kernel.org, Tao Hu <taohu@motorola.com>

From: Tao Hu <taohu@motorola.com>

The bug could cause irq enable bit of one DMA channel is
cleared/set unexpectedly when 2 (or more) drivers are calling
omap_request_dma()/omap_free_dma() simultaneously

Signed-off-by: Fei Yang <AFY095@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index b53125f..02ed945 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -691,13 +691,16 @@ static inline void disable_lnk(int lch)
 static inline void omap2_enable_irq_lch(int lch)
 {
 	u32 val;
+	unsigned long flags;
 
 	if (!cpu_class_is_omap2())
 		return;
 
+	spin_lock_irqsave(&dma_chan_lock, flags);
 	val = dma_read(IRQENABLE_L0);
 	val |= 1 << lch;
 	dma_write(val, IRQENABLE_L0);
+	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
 int omap_request_dma(int dev_id, const char *dev_name,
@@ -799,10 +802,13 @@ void omap_free_dma(int lch)
 
 	if (cpu_class_is_omap2()) {
 		u32 val;
+
+		spin_lock_irqsave(&dma_chan_lock, flags);
 		/* Disable interrupts */
 		val = dma_read(IRQENABLE_L0);
 		val &= ~(1 << lch);
 		dma_write(val, IRQENABLE_L0);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 
 		/* Clear the CSR register and IRQ status register */
 		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(lch));

