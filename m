From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2 2/2] ASoC: OMAP-McBSP: ASoC interface for
	McBSP sidetone
Date: Thu, 18 Feb 2010 10:14:36 +0200
Message-ID: <201002181014.36592.peter.ujfalusi@nokia.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266417960-22787-2-git-send-email-ilkka.koskinen@nokia.com>
	<1266417960-22787-3-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1266417960-22787-3-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

Looks good, but I have one comment, you can consider if you like it...

...

> +static int omap_mcbsp2_st_set_mode(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	u8 value =3D ucontrol->value.integer.value[0];
> +
> +	if (value =3D=3D omap_st_is_enabled(1))
> +		return 0;
> +
> +	if (value)
> +		omap_st_enable(1);
> +	else
> +		omap_st_disable(1);
> +
> +	return 1;
> +}
> +
> +static int omap_mcbsp2_st_get_mode(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	ucontrol->value.integer.value[0] =3D omap_st_is_enabled(1);
> +	return 0;
> +}
> +
> +static int omap_mcbsp3_st_set_mode(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	u8 value =3D ucontrol->value.integer.value[0];
> +
> +	if (value =3D=3D omap_st_is_enabled(2))
> +		return 0;
> +
> +	if (value)
> +		omap_st_enable(2);
> +	else
> +		omap_st_disable(2);
> +
> +	return 1;
> +}
> +
> +static int omap_mcbsp3_st_get_mode(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +
> +	ucontrol->value.integer.value[0] =3D omap_st_is_enabled(2);
> +	return 0;
> +}

Instead of having these two set of function, I would have only one:

static int omap_mcbsp_st_put_mode(struct snd_kcontrol *kcontrol,
					struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =3D
			(struct soc_mixer_control *)kcontrol->private_value;
	u8 value =3D ucontrol->value.integer.value[0];

	if (value =3D=3D omap_st_is_enabled(mc->reg))
		return 0;

	if (value)
		omap_st_enable(mc->reg);
	else
		omap_st_disable(mc->reg);

	return 1;
}

static int omap_mcbsp_st_get_mode(struct snd_kcontrol *kcontrol,
					struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =3D
			(struct soc_mixer_control *)kcontrol->private_value;

	ucontrol->value.integer.value[0] =3D omap_st_is_enabled(mc->reg);

	return 0;
}

Than

> +static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] =3D {
> +	SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 0, 0, 1, 0,
> +			omap_mcbsp2_st_get_mode, omap_mcbsp2_st_set_mode),

	SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
		omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),

> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp2_get_st_ch0_volume,
> +				      omap_mcbsp2_set_st_ch0_volume),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp2_get_st_ch1_volume,
> +				      omap_mcbsp2_set_st_ch1_volume),
> +};
> +
> +static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] =3D {
> +	SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 0, 0, 1, 0,
> +			omap_mcbsp3_st_get_mode, omap_mcbsp3_st_set_mode),

	SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
		omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),

> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp3_get_st_ch0_volume,
> +				      omap_mcbsp3_set_st_ch0_volume),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp3_get_st_ch1_volume,
> +				      omap_mcbsp3_set_st_ch1_volume),
> +};
> +
> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
> +{
> +	if (!cpu_is_omap34xx())
> +		return -ENODEV;
> +
> +	switch (mcbsp_id) {
> +	case 2: /* McBSP 2 */
> +		return snd_soc_add_controls(codec, omap_mcbsp2_st_controls,
> +					ARRAY_SIZE(omap_mcbsp2_st_controls));
> +	case 3: /* McBSP 3 */
> +		return snd_soc_add_controls(codec, omap_mcbsp3_st_controls,
> +					ARRAY_SIZE(omap_mcbsp3_st_controls));
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
> +
>  static int __init snd_omap_mcbsp_init(void)
>  {
>  	return snd_soc_register_dais(omap_mcbsp_dai,
> diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
> index 1968d03..6c363e5 100644
> --- a/sound/soc/omap/omap-mcbsp.h
> +++ b/sound/soc/omap/omap-mcbsp.h
> @@ -57,4 +57,6 @@ enum omap_mcbsp_div {
> =

>  extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
> =

> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id=
);
> +
>  #endif

-- =

P=E9ter
