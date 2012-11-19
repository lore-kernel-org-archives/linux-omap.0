From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Mon, 19 Nov 2012 09:37:27 -0700
Message-ID: <20121119163727.GB9758@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56632 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab2KSQh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 11:37:28 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>

=46rom: "Mark A. Greer" <mgreer@animalcreek.com>

Enable DMA prefetching for non-cyclic DMAs by setting the
'OMAP_DMA_DST_SYNC_PREFETCH' flag when there is a destination
synchronized DMA transfer.  Prefetching is not allowed on
source synchronized DMA transfers.  It is not allowed on
cyclic DMAs either since that can cause issues with some
users (e.g., suspending/resuming audio).

CC: Russell King <rmk+kernel@arm.linux.org.uk>
CC: P=E9ter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..3932eab 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_pre=
p_slave_sg(
 		dev_addr =3D c->cfg.dst_addr;
 		dev_width =3D c->cfg.dst_addr_width;
 		burst =3D c->cfg.dst_maxburst;
-		sync_type =3D OMAP_DMA_DST_SYNC;
+		sync_type =3D OMAP_DMA_DST_SYNC_PREFETCH;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
--=20
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
