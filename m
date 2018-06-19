From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2] dmaengine: ti: omap-dma: Fix OMAP1510 incorrect
 residue_granularity
Date: Tue, 19 Jun 2018 09:59:08 +0530
Message-ID: <20180619042908.GM25852@vkoul-mobl>
References: <20180605165957.29616-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605165957.29616-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05-06-18, 18:59, Janusz Krzysztofik wrote:
> Commit 0198d7bb8a0c ("ASoC: omap-mcbsp: Convert to use the sdma-pcm
> instead of omap-pcm") resulted in broken audio playback on OMAP1510
> (discovered on Amstrad Delta).
> 
> When running on OMAP1510, omap-pcm used to obtain DMA offset from
> snd_dmaengine_pcm_pointer_no_residue() based on DMA interrupt triggered
> software calculations instead of snd_dmaengine_pcm_pointer() which
> depended on residue value calculated from omap_dma_get_src_pos().
> Similar code path is still available in now used
> sound/soc/soc-generic-dmaengine-pcm.c but it is not triggered.
> 
> It was verified already before that omap_get_dma_src_pos() from
> arch/arm/plat-omap/dma.c didn't work correctly for OMAP1510 - see
> commit 1bdd7419910c ("ASoC: OMAP: fix OMAP1510 broken PCM pointer
> callback") for details.  Apparently the same applies to its successor,
> omap_dma_get_src_pos() from drivers/dma/ti/omap-dma.c.
> 
> On the other hand, snd_dmaengine_pcm_pointer_no_residue() is described
> as depreciated and discouraged for use in new drivers because of its
> unreliable accuracy.  However, it seems the only working option for
> OPAM1510 now, as long as a software calculated residue is not
> implemented as OMAP1510 fallback in omap-dma.
> 
> Using snd_dmaengine_pcm_pointer_no_residue() code path instead of
> snd_dmaengine_pcm_pointer() in sound/soc/soc-generic-dmaengine-pcm.c
> can be triggered in two ways:
> - by passing pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE from
>   sound/soc/omap/sdma-pcm.c,
> - by passing dma_caps.residue_granularity =
>   DMA_RESIDUE_GRANULARITY_DESCRIPTOR from DMA engine.
> 
> Let's do the latter.
> 
> Created and tested against next-20180531 tag from linux-next tree.

This is not useful for log.

I have stripped this and applied

-- 
~Vinod
