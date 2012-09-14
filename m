From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 03/15] dmaengine: Add flags parameter to
	dmaengine_prep_dma_cyclic()
Date: Fri, 14 Sep 2012 15:05:46 +0300
Message-ID: <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
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

With this parameter added to dmaengine_prep_dma_cyclic() the API will be in
sync with other dmaengine_prep_*() functions.
The dmaengine_prep_dma_cyclic() function primarily used by audio for cyclic
transfer required by ALSA, we use the from audio to ask dma drivers to
suppress interrupts (if DMA_PREP_INTERRUPT is cleared) when it is supported
on the platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/dmaengine.h     | 3 ++-
 sound/soc/soc-dmaengine-pcm.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9c02a45..2abcac5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -653,7 +653,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
-		size_t period_len, enum dma_transfer_direction dir)
+		size_t period_len, enum dma_transfer_direction dir,
+		unsigned long flags)
 {
 	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
 						period_len, dir, NULL);
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 5df529e..bbc1257 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -140,14 +140,18 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	struct dma_chan *chan = prtd->dma_chan;
 	struct dma_async_tx_descriptor *desc;
 	enum dma_transfer_direction direction;
+	unsigned long flags = DMA_CTRL_ACK;
 
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
+	if (!substream->runtime->no_period_wakeup)
+		flags |= DMA_PREP_INTERRUPT;
+
 	prtd->pos = 0;
 	desc = dmaengine_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
-		snd_pcm_lib_period_bytes(substream), direction);
+		snd_pcm_lib_period_bytes(substream), direction, flags);
 
 	if (!desc)
 		return -ENOMEM;
-- 
1.7.12
