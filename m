From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Wed, 4 Feb 2015 12:02:12 +0200
Message-ID: <54D1EE24.3000309@ti.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com> <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com> <54D1D80F.1090304@ti.com> <CA+sos797a7CT2KqCwrW5CaL1vF0GVCHQGxp3gDAB7PTFi4jZjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+sos797a7CT2KqCwrW5CaL1vF0GVCHQGxp3gDAB7PTFi4jZjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit.thebaudeau.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wlear-uoOHlzqel7feqrA4Bvp/NA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02/04/2015 11:33 AM, Beno=C3=AEt Th=C3=A9baudeau wrote:
> What I meant was to do the following instead:
>=20
> /*
>  * ADC PGA mix input volumes. From -12 to 0 dB in 1.5 dB steps. Disco=
nnected
>  * below -12 dB
>  */
> static const DECLARE_TLV_DB_SCALE(mix_tlv, -1350, 150, 1);
>=20
> /* Left PGA Mixer for tlv320aic3104 */
> static const struct snd_kcontrol_new aic3104_left_pga_mixer_controls[=
] =3D {
>     SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
>                 LINE1L_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),

You mean SOC_DAPM_SINGLE_TLV() ? There is no _MUT_ variant AFAIK.
According to the datasheets of aic3106, aic3104:
0b0000 - 0b1000 is valid (0 - -12 dB)
0b1001 - 0b1110 is reserved, do not write these sequences to the regist=
er
0b1111 is disconnected.

And for fun the aic3007's reg20 for example:
0b0000 - 0dB
0b0001 - 0b0011 - reserved
0b0100 - -6dB
0b0101 - 0b0111 - reserved
0b1000 - -12dB
0b1001 - 0b1110 - reserved
0b1111 - disconnected

Note that the driver never had control for these gains and the aic3104 =
support
is following this behavior, but if we do it for aic3104 we should do it=
 for
all other support codecs as well as a followup patch or series. IMHO.

>     SOC_DAPM_SINGLE_MUT_TLV("Line1R Volume",
>                 LINE1R_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),
>     SOC_DAPM_SINGLE_MUT_TLV("Mic2L Volume",
>                 MIC3LR_2_LADC_CTRL, 4, 7, 15, 1, mix_tlv),
>     SOC_DAPM_SINGLE_MUT_TLV("Mic2R Volume",
>                 MIC3LR_2_LADC_CTRL, 0, 7, 15, 1, mix_tlv),
> };
>=20
> /* Right PGA Mixer for tlv320aic3104 */
> static const struct snd_kcontrol_new aic3104_right_pga_mixer_controls=
[] =3D {
>     SOC_DAPM_SINGLE_MUT_TLV("Line1R Volume",
>                 LINE1R_2_RADC_CTRL, 3, 7, 15, 1, mix_tlv),
>     SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
>                 LINE1L_2_RADC_CTRL, 3, 7, 15, 1, mix_tlv),
>     SOC_DAPM_SINGLE_MUT_TLV("Mic2L Volume",
>                 MIC3LR_2_RADC_CTRL, 4, 7, 15, 1, mix_tlv),
>     SOC_DAPM_SINGLE_MUT_TLV("Mic2R Volume",
>                 MIC3LR_2_RADC_CTRL, 0, 7, 15, 1, mix_tlv),
> };
>=20
> Then, use the following instead of the "Switch" for the tlv320aic3104=
 interconn:
>     {"Left PGA Mixer", "Line1L Volume", "Left Line1L Mux"},
>     {"Left PGA Mixer", "Line1R Volume", "Left Line1R Mux"},
>     {"Left PGA Mixer", "Mic2L Volume", "MIC2L"},
>     {"Left PGA Mixer", "Mic2R Volume", "MIC2R"},
>=20
>     {"Right PGA Mixer", "Line1L Volume", "Right Line1L Mux"},
>     {"Right PGA Mixer", "Line1R Volume", "Right Line1R Mux"},
>     {"Right PGA Mixer", "Mic2L Volume", "MIC2L"},
>     {"Right PGA Mixer", "Mic2R Volume", "MIC2R"},
>=20
> Best regards,
> Beno=C3=AEt
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
