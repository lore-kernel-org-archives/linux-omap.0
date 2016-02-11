From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
Date: Thu, 11 Feb 2016 11:08:42 +0200
Message-ID: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com
Cc: dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We need the callback to support the dmaengine_terminate_sync().

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 2dac314a2d7a..290e1a721c5b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -869,6 +869,13 @@ static int edma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void edma_synchronize(struct dma_chan *chan)
+{
+	struct edma_chan *echan = to_edma_chan(chan);
+
+	vchan_synchronize(&echan->vchan);
+}
+
 static int edma_slave_config(struct dma_chan *chan,
 	struct dma_slave_config *cfg)
 {
@@ -1808,6 +1815,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 	s_ddev->device_pause = edma_dma_pause;
 	s_ddev->device_resume = edma_dma_resume;
 	s_ddev->device_terminate_all = edma_terminate_all;
+	s_ddev->device_synchronize = edma_synchronize;
 
 	s_ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
 	s_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
@@ -1833,6 +1841,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 		m_ddev->device_pause = edma_dma_pause;
 		m_ddev->device_resume = edma_dma_resume;
 		m_ddev->device_terminate_all = edma_terminate_all;
+		m_ddev->device_synchronize = edma_synchronize;
 
 		m_ddev->src_addr_widths = EDMA_DMA_BUSWIDTHS;
 		m_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
-- 
2.7.1
