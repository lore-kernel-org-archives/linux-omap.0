From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 1/3] ASoC: dmaengine: Don't use runtime
 private data for dmaengine data
Date: Mon, 03 Sep 2012 22:25:49 +0200
Message-ID: <5045124D.3050604@metafoo.de>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
 <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/03/2012 06:59 PM, Liam Girdwood wrote:
> Use a dedicated member to store dmaengine data so that drivers can
> use private data for their own purposes.
> 

The idea was that we'll eventually get to a point where we won't need private
data for the drivers using the generic dmaengine code. But for the transitional
period there is snd_dmaengine_pcm_{set,get}_data which allows to attach driver
private data to the dmaengine pcm. For an example see how the other users of
dmaengine pcm handle this.

> Signed-off-by: Liam Girdwood <lrg@ti.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/sound/pcm.h           |    2 ++
>  sound/soc/soc-dmaengine-pcm.c |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index cdca2ab..f9e4909 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -269,6 +269,7 @@ struct snd_pcm_hw_constraint_list {
>  };
>  
>  struct snd_pcm_hwptr_log;
> +struct dmaengine_pcm_runtime_data;
>  
>  struct snd_pcm_runtime {
>  	/* -- Status -- */
> @@ -345,6 +346,7 @@ struct snd_pcm_runtime {
>  	unsigned char *dma_area;	/* DMA area */
>  	dma_addr_t dma_addr;		/* physical bus address (not accessible from main CPU) */
>  	size_t dma_bytes;		/* size of DMA area */
> +	struct dmaengine_pcm_runtime_data *dmaengine_data;
>  
>  	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */
>  
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 5df529e..27fa5ad 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -40,7 +40,7 @@ struct dmaengine_pcm_runtime_data {
>  static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
>  	const struct snd_pcm_substream *substream)
>  {
> -	return substream->runtime->private_data;
> +	return substream->runtime->dmaengine_data;
>  }
>  
>  /**
