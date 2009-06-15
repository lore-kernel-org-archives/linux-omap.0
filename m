From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 15 Jun 2009 15:22:34 +0200
Message-ID: <4A364B1A.5040905@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl> <20090608094028.415e6ec3.jhnikula@gmail.com> <4A2E7921.7090200@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57612 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758675AbZFONWf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 09:22:35 -0400
In-Reply-To: <4A2E7921.7090200@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Janusz Krzysztofik napisa=B3(a):
> Important or not, I have to fine down my provious reports on what wor=
ks=20
> and what does not:
>=20
> - original patch applied with other ams-delta related patches
>   on linux-omap-2.6.16, as it was designed for:
>   - playback: works, with both aplay and >/dev/dsp,
>   - capture: works with </dev/dsp, gives null output with arecord
>=20
> - original patch ported to the last l-o commit supporting omap-alsa:
>   - playback: works as before,
>   - capture: both </dev/dsp and arecord give null output,
>     but DMA interrupts still work.

Not that I would see it as a real progress, but to clarify things: I=20
have managed to solve this particular problem with capture by patching=20
sound/arm/omap/omap-alsa.c (call omap_get_dma_dst_pos() instead of=20
omap_get_dma_src_pos() from audio_get_dma_pos() in case of (stream_id =3D=
=3D=20
SNDRV_PCM_STREAM_CAPTURE)). The original code stopped working after=20
changes introduced to omap_get_dma_src_pos() with this patch:=20
http://marc.info/?l=3Dlinux-omap&m=3D121280267705523.

Unfortunatelly ;), sound/soc/omap/omap-pcm.c does it correctly without=20
patching.

Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
