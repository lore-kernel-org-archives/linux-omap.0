From: Mathias Nyman <mathias.nyman@nokia.com>
Subject: [PATCH] omap: dma: Add read-back to DMA interrupt handler to avoid spurious interrupts
Date: Mon, 25 Oct 2010 17:35:24 +0300
Message-ID: <1288017324-2181-1-git-send-email-mathias.nyman@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:52832 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab0JYOba (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 10:31:30 -0400
Received: from nokia.com (localhost [127.0.0.1])
	by mgw-sa01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o9PEVTFr025356
	for <linux-omap@vger.kernel.org>; Mon, 25 Oct 2010 17:31:29 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>

Flush the writes to IRQSTATUS_L0 register in the DMA interrupt handler by reading the register
directly after write. This prevents the spurious DMA interrupts noted when using VDD_OPP 1

Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 arch/arm/plat-omap/dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index f5c5b8d..2c28265 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1983,6 +1983,8 @@ static int omap2_dma_handle_ch(int ch)
 
 	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
 	dma_write(1 << ch, IRQSTATUS_L0);
+	/* read back the register to flush the write */
+	dma_read(IRQSTATUS_L0);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
-- 
1.5.6.5

