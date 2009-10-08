From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 16:38:24 +0300
Message-ID: <200910081638.24229.peter.ujfalusi@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com> <20091008125213.GA29176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53589 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbZJHNkF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:40:05 -0400
In-Reply-To: <20091008125213.GA29176@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thursday 08 October 2009 15:52:13 ext Mark Brown wrote:
> On Thu, Oct 08, 2009 at 02:58:50PM +0300, Eduardo Valentin wrote:
> > +struct tpa6130a2_platform_data {
> > +	int (*set_power)(int state);
> > +};
>=20
> Why is this a callback and not just a GPIO number?  That'd seem simpl=
er
> for users.

Well, same amount of code, but in different place if the power is enabl=
ed=20
through a GPIO. But if the power is controlled via different means (not=
hing=20
comes to mind, but there are exotic systems out there), in this way it =
is simple=20
to handle

>=20
> > +int tpa6130a2_add_controls(struct snd_soc_codec *codec)
> > +{
> > +	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
> > +				ARRAY_SIZE(tpa6130a2_dapm_widgets));
> > +
> > +	return snd_soc_add_controls(codec, tpa6130a2_controls,
> > +				ARRAY_SIZE(tpa6130a2_controls));
> > +
> > +}
> > +EXPORT_SYMBOL(tpa6130a2_add_controls);
>=20
> All the ASoC APIs are EXPORT_SYMBOL_GPL().

Right.

>=20
> > +	pdata =3D (struct tpa6130a2_platform_data *)client->dev.platform_=
data;
> > +	/* Set default register values */
> > +	data->regs[TPA6130A2_REG_CONTROL] =3D TPA6130A2_SWS |
> > +					    TPA6130A2_HP_EN_R |
> > +					    TPA6130A2_HP_EN_L;
>=20
> This looks like you could implement stereo paths with individual powe=
r
> control?

Can we put something in between DAPM_OUTPUT and DAPM_HP to handle the s=
tereo=20
path correctly?
We could have two paths from codec to the "TPA6130A2 Headphone", which =
is needed=20
to actually control the power of the amplifier.
At the end we are not really gaining much, but one more level of switch=
 on the=20
path.
We could have simple mute alsa controls in tpa6130a2_controls for the a=
mplifier=20
itself...

>=20
> > +	data->regs[TPA6130A2_REG_VOL_MUTE] =3D TPA6130A2_VOLUME(20);
>=20
> The standard thing is to use hardware defaults and leave decisions li=
ke
> this up to user space.

OK, The reset value is 0 (-59.5 dB)

>=20
> > +	data->set_power =3D pdata->set_power;
> > +	if (!pdata->set_power) {
> > +		data->power_state =3D 1;
> > +		tpa6130a2_initialize();
> > +	}
> > +	tpa6130a2_power(1);
> > +
> > +	/* Read version */
> > +	err =3D tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> > +				 TPA6130A2_VERSION_MASK;
> > +	if ((err !=3D 1) && (err !=3D 2)) {
> > +		dev_err(dev, "Unexpected headphone amplifier chip version "
> > +		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
> > +		err =3D -ENODEV;
>=20
> This seems a bit excessive - is it really likely that the register ma=
p
> would be changed incompatibly in a future version?

Hmm, we have only seen these versions of the chip, and we know that the=
 driver=20
works with these. Also we don't have any information on different versi=
ons, but=20
I would think that the register map is not changing (the reset values f=
or some=20
registers are different)

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
