From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP: Fixes to omap_mcbsp_request function
Date: Wed, 24 Sep 2008 16:29:15 +0300
Message-ID: <1222262955-13599-6-git-send-email-tony@atomide.com>
References: <1222262955-13599-1-git-send-email-tony@atomide.com>
 <1222262955-13599-2-git-send-email-tony@atomide.com>
 <1222262955-13599-3-git-send-email-tony@atomide.com>
 <1222262955-13599-4-git-send-email-tony@atomide.com>
 <1222262955-13599-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62189 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYIXN3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:29:53 -0400
In-Reply-To: <1222262955-13599-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Bootloader may let McBSP logic running so make sure that block is idle
before requesting IRQs. Also make sure that TX and RX waitqueues are
initialized before request_irq.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f27e641..af33fc7 100644
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
1.5.6.rc3.21.g8c6b5

