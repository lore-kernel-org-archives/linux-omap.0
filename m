From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] dmaengine: omap-dma: Implement protection for invalid max_burst
Date: Tue, 12 Sep 2017 13:44:21 +0300
Message-ID: <20170912104424.18495-3-peter.ujfalusi@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFSet the device's max_burst to 16777215 (EN is 24bit unsigned value=
) so
clients can take this into consideration when setting up the trasnfer.

During slave transfer preparation check if the requested maxburst is valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 8c1665c8fe33..f6dd849159d8 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1288,6 +1288,10 @@ static int omap_dma_slave_config(struct dma_chan *ch=
an, struct dma_slave_config
 	    cfg->dst_addr_width =3D=3D DMA_SLAVE_BUSWIDTH_8_BYTES)
 		return -EINVAL;
=20
+	if (cfg->src_maxburst > chan->device->max_burst ||
+	    cfg->dst_maxburst > chan->device->max_burst)
+		return -EINVAL;
+
 	memcpy(&c->cfg, cfg, sizeof(c->cfg));
=20
 	return 0;
@@ -1482,6 +1486,7 @@ static int omap_dma_probe(struct platform_device *pde=
v)
 	od->ddev.dst_addr_widths =3D OMAP_DMA_BUSWIDTHS;
 	od->ddev.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	od->ddev.residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
+	od->ddev.max_burst =3D SZ_16M - 1; /* CCEN: 24bit unsigned */
 	od->ddev.dev =3D &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	spin_lock_init(&od->lock);
--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
