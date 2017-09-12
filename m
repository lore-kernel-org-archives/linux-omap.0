From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] dmaengine: edma: Implement device_get_max_len callback
Date: Tue, 12 Sep 2017 13:44:23 +0300
Message-ID: <20170912104424.18495-5-peter.ujfalusi@ti.com>
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

=EF=BB=BFeDMA can support maximum of 65535 number of bursts in one transfer=
.
The limitation is because the CCNT counter is 16bit unsigned.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 6970355abdc9..14c52574262c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -900,6 +900,28 @@ static int edma_slave_config(struct dma_chan *chan,
 	return 0;
 }
=20
+static u32 edma_get_max_len(struct dma_chan *chan,
+			    enum dma_transfer_direction dir)
+{
+	struct edma_chan *echan =3D to_edma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	u32 burst;
+
+	if (!is_slave_direction(dir))
+		return 0;
+
+	if (dir =3D=3D DMA_DEV_TO_MEM) {
+		dev_width =3D echan->cfg.src_addr_width;
+		burst =3D echan->cfg.src_maxburst;
+	} else {
+		burst =3D echan->cfg.dst_maxburst;
+		dev_width =3D echan->cfg.dst_addr_width;
+	}
+
+	/* CCNT: 16bit unsigned. Number of bursts */
+	return dev_width * burst * (SZ_64K - 1);
+}
+
 static int edma_dma_pause(struct dma_chan *chan)
 {
 	struct edma_chan *echan =3D to_edma_chan(chan);
@@ -1850,6 +1872,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool l=
egacy_mode)
 	s_ddev->device_issue_pending =3D edma_issue_pending;
 	s_ddev->device_tx_status =3D edma_tx_status;
 	s_ddev->device_config =3D edma_slave_config;
+	s_ddev->device_get_max_len =3D edma_get_max_len;
 	s_ddev->device_pause =3D edma_dma_pause;
 	s_ddev->device_resume =3D edma_dma_resume;
 	s_ddev->device_terminate_all =3D edma_terminate_all;
--=20
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki
