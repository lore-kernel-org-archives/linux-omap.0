From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 09/16] usb: musb: Fix cppi_channel_abort() function to handle Tx abort correctly
Date: Tue, 19 Jan 2010 15:14:08 +0200
Message-ID: <1263906855-28341-10-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27295 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0ASNOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:52 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Swaminathan S <swami.iyer@ti.com>

This patch fixes the Tx abort/teardown logic. We now wait for the teardown
completion interrupt and acknowledge the same by setting the tx_complete
register to 0.

This change is needed to ensure that abort processing works on DM365 platform.
Without this change after completion of abort processing the system is
overwhelmed with continuous stream of abort interrupts.

This change has been tested on all CPPI3.x platforms (DM644x, DM646x, DM35x,
DM36x).

Signed-off-by: Swaminathan S <swami.iyer@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/cppi_dma.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index a44a450..3c69a76 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1191,8 +1191,13 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 
 		bd = tx_ch->head;
 
+		/*
+		 * If Head is null then this could mean that a abort interrupt
+		 * that needs to be acknowledged.
+		 */
 		if (NULL == bd) {
 			DBG(1, "null BD\n");
+			tx_ram->tx_complete = 0;
 			continue;
 		}
 
@@ -1412,15 +1417,6 @@ static int cppi_channel_abort(struct dma_channel *channel)
 
 	if (cppi_ch->transmit) {
 		struct cppi_tx_stateram __iomem *tx_ram;
-		int			enabled;
-
-		/* mask interrupts raised to signal teardown complete.  */
-		enabled = musb_readl(tibase, DAVINCI_TXCPPI_INTENAB_REG)
-				& (1 << cppi_ch->index);
-		if (enabled)
-			musb_writel(tibase, DAVINCI_TXCPPI_INTCLR_REG,
-					(1 << cppi_ch->index));
-
 		/* REVISIT put timeouts on these controller handshakes */
 
 		cppi_dump_tx(6, cppi_ch, " (teardown)");
@@ -1435,7 +1431,6 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		do {
 			value = musb_readl(&tx_ram->tx_complete, 0);
 		} while (0xFFFFFFFC != value);
-		musb_writel(&tx_ram->tx_complete, 0, 0xFFFFFFFC);
 
 		/* FIXME clean up the transfer state ... here?
 		 * the completion routine should get called with
@@ -1448,23 +1443,15 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		musb_writew(regs, MUSB_TXCSR, value);
 		musb_writew(regs, MUSB_TXCSR, value);
 
-		/* While we scrub the TX state RAM, ensure that we clean
-		 * up any interrupt that's currently asserted:
+		/*
 		 * 1. Write to completion Ptr value 0x1(bit 0 set)
 		 *    (write back mode)
-		 * 2. Write to completion Ptr value 0x0(bit 0 cleared)
-		 *    (compare mode)
-		 * Value written is compared(for bits 31:2) and when
-		 * equal, interrupt is deasserted.
+		 * 2. Wait for abort interrupt and then put the channel in
+		 *    compare mode by writing 1 to the tx_complete register.
 		 */
 		cppi_reset_tx(tx_ram, 1);
-		musb_writel(&tx_ram->tx_complete, 0, 0);
-
-		/* re-enable interrupt */
-		if (enabled)
-			musb_writel(tibase, DAVINCI_TXCPPI_INTENAB_REG,
-					(1 << cppi_ch->index));
-
+		cppi_ch->head = 0;
+		musb_writel(&tx_ram->tx_complete, 0, 1);
 		cppi_dump_tx(5, cppi_ch, " (done teardown)");
 
 		/* REVISIT tx side _should_ clean up the same way
-- 
1.6.6.rc0

