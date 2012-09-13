From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/15] dmaengine: Add no_wakeup parameter to
	dmaengine_prep_dma_cyclic()
Date: Thu, 13 Sep 2012 16:37:53 +0300
Message-ID: <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
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

The dmaengine_prep_dma_cyclic() function primarily used by audio for cyclic
transfer required by ALSA.
With this new parameter it is going to be possible to enable the
SNDRV_PCM_INFO_NO_PERIOD_WAKEUP mode on platforms where it is possible.
This patch only changes the public API first. Followup patch will change
the device_prep_dma_cyclic() callback parameters to pass this information
towards the dma drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/dmaengine.h     | 3 ++-
 sound/soc/soc-dmaengine-pcm.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9c02a45..990444b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -653,7 +653,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
-		size_t period_len, enum dma_transfer_direction dir)
+		size_t period_len, enum dma_transfer_direction dir,
+		bool no_wakeup)
 {
 	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
 						period_len, dir, NULL);
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 5df529e..6b70adb 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -147,7 +147,8 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	desc = dmaengine_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
-		snd_pcm_lib_period_bytes(substream), direction);
+		snd_pcm_lib_period_bytes(substream), direction,
+		substream->runtime->no_period_wakeup);
 
 	if (!desc)
 		return -ENOMEM;
-- 
1.7.12
