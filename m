From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Wed, 10 Jun 2009 12:27:38 +0200
Message-ID: <200906101227.39856.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A2E7D16.1010504@tis.icnet.pl> <200906101112.32635.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50966 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbZFJK2U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 06:28:20 -0400
In-Reply-To: <200906101112.32635.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Hi Peter,

Wednesday 10 June 2009 10:12:32 Peter Ujfalusi napisa=C5=82(a):
> On Tuesday 09 June 2009 18:17:42 ext Janusz Krzysztofik wrote:
> > +static struct omap_mcbsp_reg_cfg mcbsp_regs =3D {
> > +       .spcr2 =3D FREE | XINTM(3) | XRST,
> > +       .spcr1 =3D RINTM(3) | RRST,
> > +       .rcr1 =3D RFRLEN1(2 - 1) | RWDLEN1(OMAP_MCBSP_WORD_8),
> > +       .xcr1 =3D XFRLEN1(1 - 1) | XWDLEN1(OMAP_MCBSP_WORD_16),
> > +};
> >
> > BTW, I can't see any way of specifying a similiar mcbsp setup in ne=
w
> > omap asoc framework.
>
> Yeah, 8 bit is not supported - in fact only 16 bit is supported - wit=
h ASoC
> on OMAP.

Not only this. AFAICS, there is no way of specifying single phase stere=
o (with=20
XPHASE/RPHASE unset), 2 words per frame (XFRLEN1/RFRLEN1(2 - 1)). Isn't=
 this=20
required for correct DSP_A/DSP_B support?

> But you should be able to use the playback with the current ASoC.

Definitelly yes. I am aware that the above limitations have nothing to =
do with=20
the main problem, as with current mcbsp code I should always be able to=
 get=20
some kind of noise at least using one of supported formats, as far as=20
clocking is set up correctly.

> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -266,6 +266,8 @@ void omap_set_dma_transfer_params(int lch, int
> data_type, int elem_count,
>                 ccr &=3D ~(1 << 5);
>                 if (sync_mode =3D=3D OMAP_DMA_SYNC_FRAME)
>                         ccr |=3D 1 << 5;
> +               if (dma_trigger)
> +                       ccr |=3D dma_trigger & 0x1f;
>                 dma_write(ccr, CCR(lch));
>
>                 ccr =3D dma_read(CCR2(lch));

Applied, sorry, did not help (with capture, unlike playback, set up for=
=20
internal clocking for as much device isolation as possible).

# aplay -D hw:0,0 -f S16_LE /dev/urandom
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 800=
0 Hz,=20
Mono
omap_pcm_trigger START: DMA pointer at 0x11d4a0d0
omap_pcm_trigger STOP: DMA pointer at 0x11d4a0d0 error
# arecord -D hw:0,0 -f S16_LE -t raw /dev/null
Recording raw data '/dev/null' : Signed 16 bit Little Endian, Rate 8000=
 Hz,=20
Mono
omap_pcm_trigger START: DMA pointer at 0xe101a0d0
arecord: pcm_read:1529: read error: Input/output error
omap_pcm_trigger STOP: DMA pointer at 0xe101a0d0
# cat /dev/urandom >/dev/dsp
omap_pcm_trigger START: DMA pointer at 0x11d4a0d0
cat: write error: Input/output error
omap_pcm_trigger STOP: DMA pointer at 0x11d4a0d0
# cat /dev/dsp >/dev/null
omap_pcm_trigger START: DMA pointer at 0xe101a0d0
cat: read error: Input/output eromap_pcm_trigger STOP: DMA pointer at=20
0xe101a0d0
ror
#

BTW, I have found that, when invoked with those "-D hw:0,0 -f SE16_LE"=20
options, aplay/arecord behave correctly, exactly as Mark has pointed ou=
t once=20
at the beginning of this huge thread, stopping themselves after 10 seco=
nds=20
with an error message, without need for ^C.

> I would expected that by just copying (I know that there are other th=
ings
> involved) the old ALSA arm directory to the latest kernel and compili=
ng it
> should be working... It seams I was wrong.

Anyway, if you find porting one or another framework, back or forward,=20
helpfull in any way, just let me know, I can try.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
