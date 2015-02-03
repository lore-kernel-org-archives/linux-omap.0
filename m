From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
	<benoit.thebaudeau.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Tue, 3 Feb 2015 23:25:14 +0100
Message-ID: <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422888485-13626-1-git-send-email-jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wlear-uoOHlzqel7feqrA4Bvp/NA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Dear Jyri Sarha,

Sorry to come late.

On Mon, Feb 2, 2015 at 3:48 PM, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:
[...]
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320=
aic3x.c
> index b7ebce0..cb92cdb 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
[...]
> @@ -550,6 +575,22 @@ static const struct snd_kcontrol_new aic3x_right=
_pga_mixer_controls[] =3D {
>         SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0, =
1, 1),
>  };
>
> +/* Left PGA Mixer for tlv320aic3104 */
> +static const struct snd_kcontrol_new aic3104_left_pga_mixer_controls=
[] =3D {
> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_LADC_CTRL, 3,=
 1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_LADC_CTRL, 3,=
 1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_LADC_CTRL, 4, =
1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_LADC_CTRL, 0, =
1, 1),
> +};
> +
> +/* Right PGA Mixer for tlv320aic3104 */
> +static const struct snd_kcontrol_new aic3104_right_pga_mixer_control=
s[] =3D {
> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_RADC_CTRL, 3,=
 1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_RADC_CTRL, 3,=
 1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_RADC_CTRL, 4, =
1, 1),
> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_RADC_CTRL, 0, =
1, 1),
> +};
> +

This part is wrong. All these controls should be turned into TLVs.
Otherwise, because of the reset values of these registers, the
reserved value 0b1110 is used for the corresponding bit-fields if
their lsb is cleared using the controls above.

Generally speaking, you have tracked reserved registers, but you
should also track reserved values.

>  /* Left Line1 Mux */
>  static const struct snd_kcontrol_new aic3x_left_line1l_mux_controls =
=3D
>  SOC_DAPM_ENUM("Route", aic3x_line1l_2_l_enum);
[...]
> @@ -839,6 +890,72 @@ static const struct snd_soc_dapm_route intercon[=
] =3D {
[...]
> +/* For other than tlv320aic3104 */

Typo above: not "other than" here.

> +static const struct snd_soc_dapm_route intercon_extra_3104[] =3D {
> +       /* Left Input */
> +       {"Left PGA Mixer", "Mic2L Switch", "MIC2L"},
> +       {"Left PGA Mixer", "Mic2R Switch", "MIC2R"},
> +
> +       /* Right Input */
> +       {"Right PGA Mixer", "Mic2L Switch", "MIC2L"},
> +       {"Right PGA Mixer", "Mic2R Switch", "MIC2R"},
> +};
> +
>  static const struct snd_soc_dapm_route intercon_mono[] =3D {
>         /* Mono Output */
>         {"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
[...]

The rest is good.

Best regards,
Beno=C3=AEt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
