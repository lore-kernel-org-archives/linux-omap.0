From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] [RFC] ASoC: OMAP: fix OMAP1510 broken PCM pointer callback
Date: Mon, 29 Jun 2009 15:51:07 +0200
Message-ID: <200906291551.08437.jkrzyszt@tis.icnet.pl>
References: <200906280021.05931.jkrzyszt@tis.icnet.pl> <200906290008.59640.jkrzyszt@tis.icnet.pl> <200906290937.58786.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49559 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbZF2Nvs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 09:51:48 -0400
In-Reply-To: <200906290937.58786.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday 29 June 2009 08:37:58 Peter Ujfalusi wrote:
> On Monday 29 June 2009 01:08:59 ext Janusz Krzysztofik wrote:
> > For capture, reading CPC, that follows destination port address pro=
gress,
> > just works fine (for both old and new driver). For playback, simila=
r
> > hardware functionality seems to be missing, so it has to be emulate=
d in
> > software if required.
>
> Hmmm, I had taken a look at the 2.4.21 kernel sources, which I have l=
aying
> around in my disk from an old project which used OMAP1510. The OSS au=
dio
> code does use the CPC register for determining the DMA progress both =
for
> playback and recording. I know that the audio was working OK on that =
board,
> since we had doom running there.

I am not able to find any information on how DMA can be configured for =
CPC to=20
reflect either source or destination port address progress. Official=20
documentation, even if not very clear for me, seems to suggest that it =
always=20
follows destination port address, even if constatnt (ie=20
DMA_CCR:DST_AMODE(15:14) =3D=3D 0).

> The difference that I can see is that the OSS code also configured th=
e
> CCR:SYNC(4:0) bits as well.
> Looking at the DMA_CPC register description in the OMAP1510 TRM: it l=
ist
> two cases on how it behaves and both require the DMA_CCR:SYNC !=3D 0.=
=2E.

Not exactly. According to my copy of=20
http://focus.ti.com/lit/ug/spru674/spru674.pdf, the secnod case is:

	If the channel transfer is synchronized on frames
	(DMA_CCR SYNC =E2=89=A0 0 and DMA_CCR FS =3D 1) or not
	synchronized (DMA_CCR SYNC =3D 0), the register is
	updated with 16 LSB of the address each time the
	destination port issues the last request for a frame.

Anyway, that seems to be irrelevant in our case.

> The current DMA code for OMAP1510 just plain ignores the DMA_CCR:SYNC=
 for
> some reason.

Not exactly. Even if not touched inside any of omap_set_dma_transfer_pa=
rams(),=20
omap_set_dma_src_params() nor omap_set_dma_dest_params(), these bits ar=
e=20
already set by arch/arm/plat-omap/dma.c:omap_request_dma(int dev_id, ..=
=2E):

 765         } else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
 766                 dma_write(dev_id, CCR(free_ch));
=20
> Can you try the following patch:

Sure. I remember we already talk about this before. That time, I had on=
ly=20
verified that the change you proposed did not help in solving a differe=
nt=20
problem I used to have before. Then I found the above explanation, but =
never=20
got an idea to let you know.

> iff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7fc8c04..38874e4 100644
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

BTW, here the code tries to read (and than write) an address (CCR2) tha=
t is=20
not supported on OMAP1510. I have not noticed any side effects, neither=
=20
negative nor positive, but can provide a patch if OMAP guys ever find=20
patching this as desired.

> Than can you print out in case of playback both the destination and s=
ource
> addresses supplied to the DMA, than in the pointer callback also prin=
t out
> the value returned by the omap_get_dma_src_pos function to see if thi=
s
> actually helps?

Here you are. Same figures wheather with or without your patch. I also =
printed=20
a value that CCR is written with, so you can verify those SYNC(4:0) bit=
s are=20
set correctly.

root@amsdelta:~# aplay -f S16_LE -t raw -d 1 </dev/urandom
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, M=
ono
[  116.780000] omap_pcm_prepare(): dma_params.src_start =3D 0x11d80000
[  116.780000] omap_pcm_prepare(): dma_params.dst_start =3D 0xe1011806
[  116.790000] omap_set_dma_src_params(): dma_write(0x11d8, CSSA_U(0x0)
[  116.800000] omap_set_dma_src_params(): dma_write(0x0000, CSSA_L(0x0)
[  116.810000] omap_set_dma_dest_params(): dma_write(0x1008, CCR(0x0))
[  116.820000] omap_set_dma_dest_params(): dma_write(0xe101, CDSA_U(0x0=
)
[  116.830000] omap_set_dma_dest_params(): dma_write(0x1806, CDSA_L(0x0=
)
[  116.900000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  116.900000] omap_pcm_pointer(): offset =3D 0x0c03
[  116.920000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  116.920000] omap_pcm_pointer(): offset =3D 0x0c03
[  116.950000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  116.950000] omap_pcm_pointer(): offset =3D 0x0c03
[  116.980000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  116.980000] omap_pcm_pointer(): offset =3D 0x0c03
[  116.990000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  116.990000] omap_pcm_pointer(): offset =3D 0x0c03
[  117.010000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  117.010000] omap_pcm_pointer(): offset =3D 0x0c03
[  117.140000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  117.140000] omap_pcm_pointer(): offset =3D 0x0c03
underrun!!! (at least 1799126512.681 ms long)
[  117.150000] omap_pcm_prepare(): dma_params.src_start =3D 0x11d80000
[  117.170000] omap_pcm_prepare(): dma_params.dst_start =3D 0xe1011806
[  117.170000] omap_set_dma_src_params(): dma_write(0x11d8, CSSA_U(0x0)
[  117.180000] omap_set_dma_src_params(): dma_write(0x0000, CSSA_L(0x0)
[  117.190000] omap_set_dma_dest_params(): dma_write(0x1008, CCR(0x0))
[  117.200000] omap_set_dma_dest_params(): dma_write(0xe101, CDSA_U(0x0=
)
[  117.210000] omap_set_dma_dest_params(): dma_write(0x1806, CDSA_L(0x0=
)
[  117.340000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  117.340000] omap_pcm_pointer(): offset =3D 0x0c03
root@amsdelta:~#

And here, the same with capture, just for reference:

root@amsdelta:~# arecord -f S16_LE -t raw -d 1 >/dev/null
Recording raw data 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz,=
 Mono
[  316.530000] omap_pcm_prepare(): dma_params.src_start =3D 0xe1011802
[  316.540000] omap_pcm_prepare(): dma_params.dst_start =3D 0x11da0000
[  316.550000] omap_set_dma_src_params(): dma_write(0xe101, CSSA_U(0x0)
[  316.550000] omap_set_dma_src_params(): dma_write(0x1802, CSSA_L(0x0)
[  316.560000] omap_set_dma_dest_params(): dma_write(0x4009, CCR(0x0))
[  316.570000] omap_set_dma_dest_params(): dma_write(0x11da, CDSA_U(0x0=
)
[  316.580000] omap_set_dma_dest_params(): dma_write(0x0000, CDSA_L(0x0=
)
[  316.590000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x01c2
[  316.590000] omap_pcm_pointer(): offset =3D 0x00e1
[  316.610000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x00dc
[  316.610000] omap_pcm_pointer(): offset =3D 0x006e
[  316.620000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x01b8
[  316.620000] omap_pcm_pointer(): offset =3D 0x00dc
[  316.630000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x0294
[  316.630000] omap_pcm_pointer(): offset =3D 0x014a
[  316.650000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x037e
[  316.650000] omap_pcm_pointer(): offset =3D 0x01bf
=2E..

Now, playback with my workaround applied, slightly modified for always=20
reporting dma_read(CPC(0x0)) result, even if not used for offset calcul=
ation:

root@amsdelta:~# aplay -f S16_LE -t raw -d 1 </dev/urandom
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, M=
ono
[  182.990000] omap_pcm_prepare(): dma_params.src_start =3D 0x11d80000
[  183.000000] omap_pcm_prepare(): dma_params.dst_start =3D 0xe1011806
[  183.010000] omap_set_dma_src_params(): dma_write(0x11d8, CSSA_U(0x0)
[  183.020000] omap_set_dma_src_params(): dma_write(0x0000, CSSA_L(0x0)
[  183.030000] omap_set_dma_dest_params(): dma_write(0x1008, CCR(0x0))
[  183.040000] omap_set_dma_dest_params(): dma_write(0xe101, CDSA_U(0x0=
)
[  183.050000] omap_set_dma_dest_params(): dma_write(0x1806, CDSA_L(0x0=
)
[  183.120000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.120000] omap_pcm_pointer(): offset =3D 0x0000
[  183.230000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.230000] omap_pcm_pointer(): offset =3D 0x03e8
[  183.260000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.260000] omap_pcm_pointer(): offset =3D 0x03e8
[  183.360000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.360000] omap_pcm_pointer(): offset =3D 0x07d0
[  183.380000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.380000] omap_pcm_pointer(): offset =3D 0x07d0
[  183.480000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.480000] omap_pcm_pointer(): offset =3D 0x0bb8
[  183.510000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.510000] omap_pcm_pointer(): offset =3D 0x0bb8
[  183.610000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.610000] omap_pcm_pointer(): offset =3D 0x0000
[  183.730000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.730000] omap_pcm_pointer(): offset =3D 0x03e8
[  183.860000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.860000] omap_pcm_pointer(): offset =3D 0x07d0
[  183.980000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  183.980000] omap_pcm_pointer(): offset =3D 0x0bb8
[  184.110000] omap_get_dma_src_pos(): dma_read(CPC(0x0)) =3D=3D 0x1806
[  184.110000] omap_pcm_pointer(): offset =3D 0x0000
root@amsdelta:~#

Peter,
I have really no idea how the old 2.4 code could do the job with just r=
eading=20
CPC for both capture and playback, but if you think that with my ams-de=
lta=20
machine on hand I can still help you in finding that out, please let me=
 know.

Cheers,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
