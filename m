From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH 3/3 v2] ASoC: OMAP: Enhance OMAP1510
	DMA progress software counter
Date: Tue, 11 Aug 2009 11:30:20 +0200
Message-ID: <200908111130.21935.jkrzyszt@tis.icnet.pl>
References: <200908101050.08074.jkrzyszt@tis.icnet.pl>
	<200908110107.11485.jkrzyszt@tis.icnet.pl>
	<20090811094248.3b869f09.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090811094248.3b869f09.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi Jarkko,

Tuesday 11 August 2009 08:42:48 Jarkko Nikula wrote:
> On Tue, 11 Aug 2009 01:07:10 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > Enhance period index accuracy, particularly just before buffer rewind, by
> > making use of DMA interrupt status flags in addition to simply counting
> > up interrupts.
> >
> > Corrections since v1:
> > 1. Fix buggy DMA interrupt handling in case of multiple status flags set
> > in parallel.
> > 2. Enable OMAP_DMA_LAST_IRQ only for playback on OMAP1510.
> >
> > -	}
> > +	} else if (stat == OMAP_DMA_LAST_IRQ)
> > +		return;
>
> Is this test needed? This interrupt is set only for playback on
> omap1510 so this looks null-op.

You're right, I have put it here before limiting the flag request to playback 
on OMAP1510 only. So it can be omitted, but only if we assume we are always 
called exactly as requested. It is not needed unless the flag is ever 
requested (by mistake?) by other arch/arm/plat-omap/dma.c bits and passed on 
by omap1_dma_handle_ch() that passes all flags without checking if requested. 
But then, shouldn't we start from always checking for OMAP_DMA_FRAME_IRQ set?

> > -	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
> > +	if ((cpu_is_omap1510()) &&
> > +			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
> > +		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
> > +							OMAP_DMA_LAST_IRQ);
>
> Indent OMAP_DMA_LAST_IRQ with tab(s) and spaces to the same column
> than OMAP_DMA_FRAME_IRQ. Looks nicer then.

OK, will fix it.

> Should the 
> OMAP_DMA_BLOCK_IRQ to be set since it is handled in omap_pcm_dma_irq?

This one is already requested from inside omap_request_dma() and used inside 
omap1_dma_handle_ch() in addition to passing it to us.

Cheers,
Janusz
