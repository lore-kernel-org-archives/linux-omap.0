From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Tue, 09 Jun 2009 17:17:42 +0200
Message-ID: <4A2E7D16.1010504@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <20090605224532.GA12995@sirena.org.uk> <200906061942.14276.jkrzyszt@tis.icnet.pl> <200906091012.41800.peter.ujfalusi@nokia.com>
Reply-To: postmaster@icnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40940 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbZFIPRt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jun 2009 11:17:49 -0400
In-Reply-To: <200906091012.41800.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Peter Ujfalusi wrote:
> I'm kind of bad at visualizing things, is it possible to put somewhere the 
> screenshoot of the scope showing at least one sample?

Good idea. I'll take some screenshots for future reference and let you 
know when available.

> I have been looking for clues around the net, and it seams that the codec in 
> question has stereo 16 bit format.

 From the very minimal mcbsp setup I get best audio experience with 
(using original omap-alsa based driver - see below), it looks like the 
codec speeks DSP (single phase), 16-bit mono @8kHz on output, but 8-bit 
stereo @8kHz on input. Capturing one channel only (the first one) I 
can't hear myself speaking, so audio from the microphone must be sent 
over the second input channel.

+static struct omap_mcbsp_reg_cfg mcbsp_regs = {
+       .spcr2 = FREE | XINTM(3) | XRST,
+       .spcr1 = RINTM(3) | RRST,
+       .rcr1 = RFRLEN1(2 - 1) | RWDLEN1(OMAP_MCBSP_WORD_8),
+       .xcr1 = XFRLEN1(1 - 1) | XWDLEN1(OMAP_MCBSP_WORD_16),
+};


+static snd_pcm_hardware_t vc_snd_omap_alsa_playback = {
+       .info = (SNDRV_PCM_INFO_INTERLEAVED | 
SNDRV_PCM_INFO_BLOCK_TRANSFER |
+                SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+       .formats = (SNDRV_PCM_FMTBIT_S16_LE),
+       .rates = (SNDRV_PCM_RATE_8000 |
+                 SNDRV_PCM_RATE_KNOT),
+       .rate_min = 8000,
+       .rate_max = 8000,
+       .channels_min = 1,
+       .channels_max = 1,
+       .buffer_bytes_max = 128 * 1024,
+       .period_bytes_min = 32,
+       .period_bytes_max = 8 * 1024,
+       .periods_min = 16,
+       .periods_max = 255,
+       .fifo_size = 0,
+};
+
+static snd_pcm_hardware_t vc_snd_omap_alsa_capture = {
+       .info = (SNDRV_PCM_INFO_INTERLEAVED | 
SNDRV_PCM_INFO_BLOCK_TRANSFER |
+                SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+       .formats = (SNDRV_PCM_FMTBIT_U8),
+       .rates = (SNDRV_PCM_RATE_8000 |
+                 SNDRV_PCM_RATE_KNOT),
+       .rate_min = 8000,
+       .rate_max = 8000,
+       .channels_min = 2,
+       .channels_max = 2,
+       .buffer_bytes_max = 128 * 1024,
+       .period_bytes_min = 32,
+       .period_bytes_max = 8 * 1024,
+       .periods_min = 16,
+       .periods_max = 255,
+       .fifo_size = 0,
+};

For other combinations of single/dual phase, sample size, mono/stereo, 
sound I get is much more distorted. Playing with polarisation and delays 
for getting still better experience remains on my todo list.

BTW, I can't see any way of specifying a similiar mcbsp setup in new 
omap asoc framework.

--------------
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -193,11 +193,15 @@ static int omap_pcm_trigger(struct snd_pcm_substream 
> *substream, int cmd)
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>                 prtd->period_index = 0;
>                 omap_start_dma(prtd->dma_ch);
> +               printk("omap_pcm_trigger START: DMA pointer at 0x%08x\n",
> +                       (unsigned)omap_get_dma_src_pos(prtd->dma_ch));
>                 break;
> 
>         case SNDRV_PCM_TRIGGER_STOP:
>         case SNDRV_PCM_TRIGGER_SUSPEND:
>         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +               printk("omap_pcm_trigger STOP: DMA pointer at 0x%08x\n",
> +                       (unsigned)omap_get_dma_src_pos(prtd->dma_ch));
>                 prtd->period_index = -1;
>                 omap_stop_dma(prtd->dma_ch);
>                 break;
> 
> 
> Than start a playback, and stop it with CTRL+C, see if the two pointers are 
> different...

Both playback and capture start with their own but always the same value 
(something like 0x1101a0d0 for playback, 0xe101a0d0 for capture), and 
always stop with this value unchanged.

> 2) I would I think try to port the 2.6.28 pure ALSA version to the head of l-
> o, with minimal (only the needed) changes and see if it is still working.

Trying to use the new driver on the last l-o revision supporting both 
omap-alsa and omap asoc, I got a broken system that hanged up completely 
at sound device first access. The same for earlier and later l-o 
revisions I have ever tried, unlike mainline that at least does not 
hang. From all that I would conclude that porting the old driver could 
be just waste of time, as the problem is probably omap asoc related, not 
just omap, probably existed from the start of omap asoc life, and could 
be solved on any l-o or mainline revision, including those eariler l-o 
that supported both frameworks. But I can be wrong, of course.

Cheers,
Janusz
