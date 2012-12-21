From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 7/9] crypto: omap-sham - Convert to dma_request_slave_channel_compat()
Date: Fri, 21 Dec 2012 10:04:07 -0700
Message-ID: <1356109449-11624-8-git-send-email-mgreer@animalcreek.com>
References: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-crypto-owner@vger.kernel.org
To: davem@davemloft.net, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Mark A. Greer" <mgreer@animalcreek.com>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>
List-Id: linux-omap@vger.kernel.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Use the dma_request_slave_channel_compat() call instead of
the dma_request_channel() call to request a DMA channel.
This allows the omap-sham driver use different DMA engines.

CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 860cad8..8074bd9 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1292,7 +1292,8 @@ static int __devinit omap_sham_probe(struct platform_device *pdev)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	dd->dma_lch = dma_request_channel(mask, omap_dma_filter_fn, &dd->dma);
+	dd->dma_lch = dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						       &dd->dma, dev, "rx");
 	if (!dd->dma_lch) {
 		dev_err(dev, "unable to obtain RX DMA engine channel %u\n",
 			dd->dma);
-- 
1.7.12
