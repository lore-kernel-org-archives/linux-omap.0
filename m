From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] omap: McBSP: Fix possible port lockout
Date: Wed, 06 Jan 2010 16:18:44 -0800
Message-ID: <20100107001844.21352.899.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54393 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398Ab0AGASo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:18:44 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

In its current form, the omap_mcbsp_request() function can return after
irq_request() failure without any cleanups, effectively locking out the port
forever with clocks left running. Fix it.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 2cc1cc3..f757672 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -436,7 +436,7 @@ int omap_mcbsp_request(unsigned int id)
 			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
 					"for McBSP%d\n", mcbsp->tx_irq,
 					mcbsp->id);
-			return err;
+			goto error;
 		}
 
 		init_completion(&mcbsp->rx_irq_completion);
@@ -446,12 +446,26 @@ int omap_mcbsp_request(unsigned int id)
 			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
 					"for McBSP%d\n", mcbsp->rx_irq,
 					mcbsp->id);
-			free_irq(mcbsp->tx_irq, (void *)mcbsp);
-			return err;
+			goto tx_irq;
 		}
 	}
 
 	return 0;
+tx_irq:
+	free_irq(mcbsp->tx_irq, (void *)mcbsp);
+error:
+	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+			mcbsp->pdata->ops->free(id);
+
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_free(mcbsp);
+
+	clk_disable(mcbsp->fclk);
+	clk_disable(mcbsp->iclk);
+
+	mcbsp->free = 1;
+
+	return err;
 }
 EXPORT_SYMBOL(omap_mcbsp_request);
 

