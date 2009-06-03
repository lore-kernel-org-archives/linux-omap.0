From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: *SPAM* Re: Please help in adding ams-delta support to ASoC
Date: Wed, 3 Jun 2009 10:28:45 +0200
Message-ID: <200906031028.46717.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A25040A.4050506@tis.icnet.pl> <200906030828.06933.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57745 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbZFCI3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 04:29:15 -0400
In-Reply-To: <200906030828.06933.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Wednesday 03 June 2009 07:28:06 Peter Ujfalusi napisa=B3(a):
> Looking at the code at commit: d8376cc482b241701f7606c81ad578b90853e1=
75 on
> l-o the comment about the need for the call the omap_stop_dma puzzled=
 me.

Peter,

It was omap_stop_alsa_sound_dma(), not just omap_stop_dma(), the was ne=
eded.
In my opinion, the reason for that was not because it was calling=20
omap_stop_dma(), but because it was clearing the audio_stream.started f=
lag.=20
That way, subsequent audio_start_dma_chain() would not jump over=20
omap_start_dma(). From my experience with the original driver, it worke=
d much=20
better when calling omap_start_dma() unconditionally from=20
audio_start_dma_chain() instead of doing this with that=20
omap_stop_alsa_sound_dma() trick.

> Can you try something like this:
>
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 6454e15..2df1792 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -67,6 +67,7 @@ static void omap_pcm_dma_irq(int ch, u16 stat, void
> *data) spin_lock_irqsave(&prtd->lock, flags);
>                 if (prtd->period_index >=3D 0) {
>                         if (++prtd->period_index =3D=3D runtime->peri=
ods) {
> +                               omap_stop_dma(prtd->dma_ch);
>                                 prtd->period_index =3D 0;
>                                 omap_start_dma(prtd->dma_ch);
>                         }
> @@ -191,6 +192,7 @@ static int omap_pcm_trigger(struct snd_pcm_substr=
eam
> *substream, int cmd)
>         case SNDRV_PCM_TRIGGER_START:
>         case SNDRV_PCM_TRIGGER_RESUME:
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               omap_stop_dma(prtd->dma_ch);
>                 prtd->period_index =3D 0;
>                 omap_start_dma(prtd->dma_ch);
>                 break;

Never hurts. Unfortunatelly, it did not help, no single DMA interrupt a=
gain.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
