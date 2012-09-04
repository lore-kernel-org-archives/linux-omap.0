From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC update 1/2] dmaengine: omap: Support for element mode in cyclic DMA
Date: Tue,  4 Sep 2012 15:08:01 +0300
Message-ID: <1346760482-12794-2-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:53108 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756818Ab2IDMH7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 08:07:59 -0400
Received: by obbuo13 with SMTP id uo13so10750141obb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 05:07:58 -0700 (PDT)
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

When src_maxburst/dst_maxburst is set to 0 by the users of cyclic DMA
(mostly audio) indicates that we should configure the omap DMA to element
sync mode instead of packet mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ae05618..b77a40d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -413,7 +413,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->dev_addr = dev_addr;
 	d->fi = burst;
 	d->es = es;
-	d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	if (burst)
+		d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	else
+		d->sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	d->sync_type = sync_type;
 	d->periph_port = OMAP_DMA_PORT_MPUI;
 	d->sg[0].addr = buf_addr;
-- 
1.7.12

