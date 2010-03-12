From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19/19] omap: McBSP: Drop unnecessary status/error bit
 clearing on reg_cacheretrieved register values
Date: Thu, 11 Mar 2010 16:00:59 -0800
Message-ID: <20100312000059.GY2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52027 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab0CKX7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:59:38 -0500
Content-Disposition: inline
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

>From eee91441bf26c6ea88656eb9866e706b1e07d30b Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Date: Tue, 23 Feb 2010 15:50:38 +0000
Subject: [PATCH] omap: McBSP: Drop unnecessary status/error bit clearing on reg_cacheretrieved register values

The MsBSP register cache will never have any error/status flags set, since
these flags are never written to the reg_cache. So it is kind of not
necessary to clear these flags, which are actually always 0.

In other words, clearing the status/error flags are not necessary, since the
reg_cache will never got these bits set. We can just write back the
register content from the cache as it is when clearing an error condition.

Tested on Amstrad Delta.

Reported-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e47686e..52dfcc8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -133,8 +133,7 @@ static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
 			irqst_spcr2);
 		/* Writing zero to XSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_tx, SPCR2,
-			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
+		MCBSP_WRITE(mcbsp_tx, SPCR2, MCBSP_READ_CACHE(mcbsp_tx, SPCR2));
 	} else {
 		complete(&mcbsp_tx->tx_irq_completion);
 	}
@@ -154,8 +153,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
 		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
 			irqst_spcr1);
 		/* Writing zero to RSYNC_ERR clears the IRQ */
-		MCBSP_WRITE(mcbsp_rx, SPCR1,
-			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
+		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
 	} else {
 		complete(&mcbsp_rx->tx_irq_completion);
 	}
@@ -934,8 +932,7 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR2,
-				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR2, MCBSP_READ_CACHE(mcbsp, SPCR2));
 		/* resend */
 		return -1;
 	} else {
@@ -975,8 +972,7 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 	/* if frame sync error - clear the error */
 	if (MCBSP_READ(mcbsp, SPCR1) & RSYNC_ERR) {
 		/* clear error */
-		MCBSP_WRITE(mcbsp, SPCR1,
-				MCBSP_READ_CACHE(mcbsp, SPCR1) & (~RSYNC_ERR));
+		MCBSP_WRITE(mcbsp, SPCR1, MCBSP_READ_CACHE(mcbsp, SPCR1));
 		/* resend */
 		return -1;
 	} else {
