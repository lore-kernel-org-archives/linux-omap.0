From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/15] dmaengine: omap-dma: Add support for
	no_wakeup in cyclic mode
Date: Thu, 13 Sep 2012 16:37:55 +0300
Message-ID: <1347543485-339-6-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When requested disable all DMA interrupts for the channel. In this mode
user space does not expect periodic reports from kernel about the progress
of the audio stream - PulseAudio for example support this type of mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index c6a711d..cbe087e 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -374,6 +374,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	struct omap_desc *d;
 	dma_addr_t dev_addr;
 	unsigned es, sync_type;
+	unsigned long tx_flags = 0;
 	u32 burst;
 
 	if (dir == DMA_DEV_TO_MEM) {
@@ -429,7 +430,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	if (!c->cyclic) {
 		c->cyclic = true;
 		omap_dma_link_lch(c->dma_ch, c->dma_ch);
-		omap_enable_dma_irq(c->dma_ch, OMAP_DMA_FRAME_IRQ);
+
+		if (!no_wakeup) {
+			omap_enable_dma_irq(c->dma_ch, OMAP_DMA_FRAME_IRQ);
+			tx_flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+		}
 		omap_disable_dma_irq(c->dma_ch, OMAP_DMA_BLOCK_IRQ);
 	}
 
@@ -438,7 +443,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 		omap_set_dma_dest_burst_mode(c->dma_ch, OMAP_DMA_DATA_BURST_16);
 	}
 
-	return vchan_tx_prep(&c->vc, &d->vd, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
 }
 
 static int omap_dma_slave_config(struct omap_chan *c, struct dma_slave_config *cfg)
-- 
1.7.12
