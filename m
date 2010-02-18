From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 2/2] ASoC: OMAP-McBSP: ASoC interface for
	McBSP sidetone
Date: Thu, 18 Feb 2010 16:11:38 +0200
Message-ID: <201002181611.38241.peter.ujfalusi@nokia.com>
References: <1266496635-31347-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com>
	<1266496635-31347-3-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1266496635-31347-3-git-send-email-ilkka.koskinen@nokia.com>
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

On Thursday 18 February 2010 14:37:15 Koskinen Ilkka (Nokia-D/Tampere) wrot=
e:

...

> +static int omap_mcbsp_set_st_channel_vol(struct snd_kcontrol *kcontrol,
> +					struct snd_ctl_elem_value *ucontrol,
> +					int id, int channel)
> +{
> +	struct soc_mixer_control *mc =3D
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int max =3D mc->max;
> +	int min =3D mc->min;
> +	int val =3D ucontrol->value.integer.value[0];
> +
> +	if (val < min || val > max)
> +		return -EINVAL;
> +
> +	return omap_st_set_chgain((id)-1, val, 0, channel);

So how do you actually set the ch1 gain to other than 0?

int omap_st_set_chgain(unsigned int id, s16 ch0gain, s16 ch1gain, int chann=
els);

So in any cases you are calling with ch1gain =3D 0, and depending on the se=
lected =

channel you put that to ch0gain.
All in all, with this code you are only able to update ch0, and never the c=
h1.

Should than the omap_st_set_chgain have only one parameter for the gain, an=
d the =

channel parameter tells the code to which channel to put the gain?

> +}
> +
> +static int omap_mcbsp_get_st_channel_vol(struct snd_kcontrol *kcontrol,
> +					struct snd_ctl_elem_value *ucontrol,
> +					int id, int channel)
> +{
> +	s16 ch0gain, ch1gain;
> +
> +	if (omap_st_get_chgain((id)-1, &ch0gain, &ch1gain))
> +		return -EAGAIN;

Than probably the omap_st_get_chgain should only retrieve the gain for one =

channel also?

> +
> +	if (channel =3D=3D OMAP_MCBSP_ST_CHANNEL_0)
> +		ucontrol->value.integer.value[0] =3D ch0gain;
> +	else if (channel =3D=3D OMAP_MCBSP_ST_CHANNEL_1)
> +		ucontrol->value.integer.value[0] =3D ch1gain;
> +
> +	return 0;
> +}
> +

-- =

P=E9ter
