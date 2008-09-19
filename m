From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix possible un-initialized waitqueue in McBSP
Date: Fri, 19 Sep 2008 16:36:38 +0300
Message-ID: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62620 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYISNhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 09:37:07 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8JDaZ3D028311
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 08:37:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

TX or RX irq waitqueues are un-initialized if interrupt would occur
immediately after requesting it. I don't know is it HW failure, but one
Beagle board is showing spurious TX interrupt from McBSP2 (and only from it)
just after requesting it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 7d32437..1b5d709 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -236,6 +236,7 @@ int omap_mcbsp_request(unsigned int id)
 
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
+		init_completion(&mcbsp->tx_irq_completion);
 		err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler,
 					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
@@ -245,8 +246,7 @@ int omap_mcbsp_request(unsigned int id)
 			return err;
 		}
 
-		init_completion(&mcbsp->tx_irq_completion);
-
+		init_completion(&mcbsp->rx_irq_completion);
 		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
 					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
@@ -256,8 +256,6 @@ int omap_mcbsp_request(unsigned int id)
 			free_irq(mcbsp->tx_irq, (void *)mcbsp);
 			return err;
 		}
-
-		init_completion(&mcbsp->rx_irq_completion);
 	}
 
 	return 0;
-- 
1.5.6.5

