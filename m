From: Ladislav.Michl@seznam.cz
Subject: [PATCH] mmci-omap: free irq resource
Date: Wed, 21 Oct 2009 14:43:20 +0200
Message-ID: <20091021124320.GA8525@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:60986 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbZJUKnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 06:43:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Free IRQ on remove.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5d773b8..5f970e2 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1529,6 +1529,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
 		host->pdata->cleanup(&pdev->dev);
 
 	mmc_omap_fclk_enable(host, 0);
+	free_irq(host->irq, host);
 	clk_put(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->iclk);
