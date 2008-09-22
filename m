From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Fixes to omap_mcbsp_request function
Date: Mon, 22 Sep 2008 16:47:51 +0300
Message-ID: <1222091271-22546-1-git-send-email-jarkko.nikula@nokia.com>
References: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23153 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIVNsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 09:48:35 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8MDmG3c029944
	for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2008 08:48:33 -0500
In-Reply-To: <1221831398-10700-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Bootloader may let McBSP logic running so make sure that block is idle
before requesting IRQs. Also make sure that TX and RX waitqueues are
initialized before request_irq.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 7d32437..798c91e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -234,8 +234,16 @@ int omap_mcbsp_request(unsigned int id)
 	mcbsp->free = 0;
 	spin_unlock(&mcbsp->lock);
 
+	/*
+	 * Make sure that transmitter, receiver and sample-rate generator are
+	 * not running before activating IRQs.
+	 */
+	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR1, 0);
+	OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR2, 0);
+
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
+		init_completion(&mcbsp->tx_irq_completion);
 		err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler,
 					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
@@ -245,8 +253,7 @@ int omap_mcbsp_request(unsigned int id)
 			return err;
 		}
 
-		init_completion(&mcbsp->tx_irq_completion);
-
+		init_completion(&mcbsp->rx_irq_completion);
 		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
 					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
@@ -256,8 +263,6 @@ int omap_mcbsp_request(unsigned int id)
 			free_irq(mcbsp->tx_irq, (void *)mcbsp);
 			return err;
 		}
-
-		init_completion(&mcbsp->rx_irq_completion);
 	}
 
 	return 0;
-- 
1.5.6.5

