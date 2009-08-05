From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 16/20] ASoC: OMAP: Use McBSP threshold again
Date: Wed, 5 Aug 2009 10:48:56 +0300
Message-ID: <20090805104856.ff3e0f31.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35178 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067AbZHEHrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 03:47:45 -0400
In-Reply-To: <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Thu, 30 Jul 2009 15:49:39 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> Now this patch implements again the McBSP threshold
> usage for OMAP ASoC.
> 
> We figured out that there is no need to have so much
> SW control in order to have DMA in idle state during
> audio streaming. Configuring McBSP threshold value
> and DMA to FRAME_SYNC are sufficient.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  sound/soc/omap/omap-pcm.c |   37 +++++++++++++++++++++++++++++++++++--
>  1 files changed, 35 insertions(+), 2 deletions(-)
> 
> @@ -192,6 +203,12 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		prtd->period_index = 0;
> +		/* Configure McBSP internal buffer usage */
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			omap_mcbsp_set_tx_threshold(bus_id, samples - 1);
> +		else
> +			omap_mcbsp_set_rx_threshold(bus_id, samples - 1);
> +
>  		omap_start_dma(prtd->dma_ch);
>  		break;
>  
Oops, didn't notice this before. This will hard glue the DMA and McBSP
together. Even currently there is only McBSP based DAI link driver,
there can be others as well. EAC DAI for OMAP2420 would be necessary
for instance if one wants to develop ASoC support for Nokia N800. Nokia
N810 could use that too.


-- 
Jarkko
