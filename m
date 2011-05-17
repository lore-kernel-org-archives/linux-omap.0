From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 17 May 2011 13:33:40 +0300
Message-ID: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab1EQKdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 06:33:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>

On OMAP4 we have one interrupt line per McBSP port.
At proble time tx, and rx irq value will be -ENXIO,
and only the tx irq will get corrected.
In omap_mcbsp_request if the rx_irq is not 0 we proceed,
and try to request the interrupt, which will fail on
OMAP4 (rx_irq == -6).
To avoid this error, clear the rx_irq at probe time
on OMAP4.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 5587acf..1e4e32e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1867,8 +1867,10 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
 
 	/* From OMAP4 there will be a single irq line */
-	if (mcbsp->tx_irq == -ENXIO)
+	if (mcbsp->tx_irq == -ENXIO) {
 		mcbsp->tx_irq = platform_get_irq(pdev, 0);
+		mcbsp->rx_irq = 0;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
-- 
1.7.5.rc3

