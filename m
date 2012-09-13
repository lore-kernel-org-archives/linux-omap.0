From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 03/15] dmaengine: Add no_wakeup
	parameter to dmaengine_prep_dma_cyclic()
Date: Thu, 13 Sep 2012 17:27:09 +0200
Message-ID: <5051FB4D.3000009@metafoo.de>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 09/13/2012 03:37 PM, Peter Ujfalusi wrote:
> The dmaengine_prep_dma_cyclic() function primarily used by audio for cyclic
> transfer required by ALSA.
> With this new parameter it is going to be possible to enable the
> SNDRV_PCM_INFO_NO_PERIOD_WAKEUP mode on platforms where it is possible.
> This patch only changes the public API first. Followup patch will change
> the device_prep_dma_cyclic() callback parameters to pass this information
> towards the dma drivers.
> 

Hi,

Hm... Do you think it would work as well if we implement this by setting the
callback for the descriptor to NULL? If the callback is NULL there is
nothing to at the end of a transfer/period and the dma engine driver may
choose to disable interrupts. This would also benefit non cyclic transfers
where the callback is NULL and we do not need add the new parameter to
dmaengine_prep_dma_cyclic.

- Lars

> ---
>  include/linux/dmaengine.h     | 3 ++-
>  sound/soc/soc-dmaengine-pcm.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9c02a45..990444b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -653,7 +653,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
>  
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
>  		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> -		size_t period_len, enum dma_transfer_direction dir)
> +		size_t period_len, enum dma_transfer_direction dir,
> +		bool no_wakeup)
>  {
>  	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
>  						period_len, dir, NULL);
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 5df529e..6b70adb 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -147,7 +147,8 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
>  	desc = dmaengine_prep_dma_cyclic(chan,
>  		substream->runtime->dma_addr,
>  		snd_pcm_lib_buffer_bytes(substream),
> -		snd_pcm_lib_period_bytes(substream), direction);
> +		snd_pcm_lib_period_bytes(substream), direction,
> +		substream->runtime->no_period_wakeup);
>  
>  	if (!desc)
>  		return -ENOMEM;
