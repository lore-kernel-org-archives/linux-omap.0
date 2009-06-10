From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Wed, 10 Jun 2009 13:53:42 +0300
Message-ID: <200906101353.43411.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906101112.32635.peter.ujfalusi@nokia.com> <200906101227.39856.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64282 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZFJKy6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 06:54:58 -0400
In-Reply-To: <200906101227.39856.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Wednesday 10 June 2009 13:27:38 ext Janusz Krzysztofik wrote:
> Not only this. AFAICS, there is no way of specifying single phase ste=
reo
> (with XPHASE/RPHASE unset), 2 words per frame (XFRLEN1/RFRLEN1(2 - 1)=
).
> Isn't this required for correct DSP_A/DSP_B support?

Sure it is possible:
	format =3D mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
	wpf =3D channels =3D params_channels(params);
	switch (channels) {
	case 2:
		if (format =3D=3D SND_SOC_DAIFMT_I2S) {
			/* Use dual-phase frames */
			regs->rcr2	|=3D RPHASE;
			regs->xcr2	|=3D XPHASE;
			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
			wpf--;
			regs->rcr2	|=3D RFRLEN2(wpf - 1);
			regs->xcr2	|=3D XFRLEN2(wpf - 1);
		}
	case 1:
	case 4:
		/* Set word per (McBSP) frame for phase1 */
		regs->rcr1	|=3D RFRLEN1(wpf - 1);
		regs->xcr1	|=3D XFRLEN1(wpf - 1);
		break;
	default:
		/* Unsupported number of channels */
		return -EINVAL;
	}

wpf =3D channels =3D=3D 2, format is not I2S --> RFRLEN1(wpf - 1), XFRL=
EN1(wpf - 1),=20
RFRLEN1(2 - 1), XFRLEN1(2 - 1)

>
> > But you should be able to use the playback with the current ASoC.
>
> Definitelly yes. I am aware that the above limitations have nothing t=
o do
> with the main problem, as with current mcbsp code I should always be =
able
> to get some kind of noise at least using one of supported formats, as=
 far
> as clocking is set up correctly.
>
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -266,6 +266,8 @@ void omap_set_dma_transfer_params(int lch, int
> > data_type, int elem_count,
> >                 ccr &=3D ~(1 << 5);
> >                 if (sync_mode =3D=3D OMAP_DMA_SYNC_FRAME)
> >                         ccr |=3D 1 << 5;
> > +               if (dma_trigger)
> > +                       ccr |=3D dma_trigger & 0x1f;
> >                 dma_write(ccr, CCR(lch));
> >
> >                 ccr =3D dma_read(CCR2(lch));
>
> Applied, sorry, did not help (with capture, unlike playback, set up f=
or
> internal clocking for as much device isolation as possible).

I would have guessed this, since even when the DMA was not HW synced, i=
t did=20
not sent a single bit to the McBSP DXR1 register...

Just out of curiosity, can you try this one as well:

--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -191,6 +191,7 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_su=
bstream=20
*substream, int cmd,
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
                if (!mcbsp_data->active++)
                        omap_mcbsp_start(mcbsp_data->bus_id);
+               omap_mcbsp_pollwrite(mcbsp_data->bus_id, 0xdb55);
                break;

basically write 0xdb55 to the DXR1 register (0xdb55 is 1101101101010101=
)
With this, if McBSP is operating correctly you should be seeing this pa=
ttern=20
going to the codec. If it does, than we have some problems with the McB=
SP/DMA=20
cooperation, if this pattern is not seen on the bus, than the McBSP is =
not=20
shifting data out for some reason.

>
> > I would expected that by just copying (I know that there are other =
things
> > involved) the old ALSA arm directory to the latest kernel and compi=
ling
> > it should be working... It seams I was wrong.
>
> Anyway, if you find porting one or another framework, back or forward=
,
> helpfull in any way, just let me know, I can try.

I'm not sure if it could prove anything at the end. There are - I think=
 -=20
other moving parts, which can break things.

>
> Thanks,
> Janusz

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
