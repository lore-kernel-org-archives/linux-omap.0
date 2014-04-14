From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 04/10] dmaengine: edma: Add support for DMA_PAUSE/RESUME
 operation
Date: Mon, 14 Apr 2014 14:41:59 +0300
Message-ID: <1397475725-5036-5-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dan.j.williams@intel.com, vinod.koul@intel.com, nsekhar@ti.com, joelf@ti.com
Cc: dmaengine@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Pause/Resume can be used by the audio stack when the stream is paused/resumed
The edma platform code has support for this and the legacy audio stack used
this.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 2742867fd1e6..7891378a03f0 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -240,6 +240,26 @@ static int edma_slave_config(struct edma_chan *echan,
 	return 0;
 }
 
+static int edma_dma_pause(struct edma_chan *echan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	if (!echan->edesc->cyclic)
+		return -EINVAL;
+
+	edma_pause(echan->ch_num);
+	return 0;
+}
+
+static int edma_dma_resume(struct edma_chan *echan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	if (!echan->edesc->cyclic)
+		return -EINVAL;
+
+	edma_resume(echan->ch_num);
+	return 0;
+}
+
 static int edma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			unsigned long arg)
 {
@@ -255,6 +275,14 @@ static int edma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		config = (struct dma_slave_config *)arg;
 		ret = edma_slave_config(echan, config);
 		break;
+	case DMA_PAUSE:
+		ret = edma_dma_pause(echan);
+		break;
+
+	case DMA_RESUME:
+		ret = edma_dma_resume(echan);
+		break;
+
 	default:
 		ret = -ENOSYS;
 	}
-- 
1.9.2
