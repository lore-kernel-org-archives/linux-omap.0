From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix TDM slot rx/tx mask associations
Date: Tue, 10 Nov 2015 09:51:47 +0200
Message-ID: <5641A213.4030508@ti.com>
References: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/09/2015 08:19 PM, Andreas Dannenberg wrote:
> Fixes the associations between the tx_mask and rx_mask and the associ=
ated
> playback / capture streams during setting of the TDM slot. With this
> patch in place it is now possible for example to only populate tx_mas=
k
> (leaving rx_mask as 0) for output-only codecs to control the TDM slot=
(s)
> the McASP serial port uses for transmit. Before that, this scenario
> would incorrectly rely on the rx_mask for this.
>=20
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/davinci/davinci-mcasp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/da=
vinci-mcasp.c
> index 4495a40..caa0beb 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -681,8 +681,8 @@ static int davinci_mcasp_set_tdm_slot(struct snd_=
soc_dai *dai,
>  	}
> =20
>  	mcasp->tdm_slots =3D slots;
> -	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] =3D rx_mask;
> -	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] =3D tx_mask;
> +	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] =3D tx_mask;
> +	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] =3D rx_mask;
>  	mcasp->slot_width =3D slot_width;
> =20
>  	return davinci_mcasp_set_ch_constraints(mcasp);
>=20


--=20
P=E9ter
