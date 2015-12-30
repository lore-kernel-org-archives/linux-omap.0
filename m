From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 30 Dec 2015 09:35:21 +0100
Message-ID: <1451464521.2531.4.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
	 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
	 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-VtvTQhBkvaUcX+S88rSA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568323B7.7080101@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-VtvTQhBkvaUcX+S88rSA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Milo,

Le mercredi 30 d=C3=A9cembre 2015 =C3=A0 09:22 +0900, Milo Kim a =C3=A9crit=
 :
> Hi Paul,
>=20
> On 29/12/15 20:13, Paul Kocialkowski wrote:
> > Hi Milo,
> >
> > Le mardi 29 d=C3=A9cembre 2015 =C3=A0 09:45 +0900, Milo Kim a =C3=A9cri=
t :
> >> Hi Paul,
> >>
> >> On 29/12/15 07:49, Paul Kocialkowski wrote:
> >>> Hi Milo, thanks for the review,
> >>>
> >>> Le lundi 28 d=C3=A9cembre 2015 =C3=A0 09:56 +0900, Milo Kim a =C3=A9c=
rit :
> >>>> Hi Paul,
> >>>>
> >>>> On 23/12/15 20:56, Mark Brown wrote:
> >>>>> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >>>>>
> >>>>>> +	gpio =3D lp->pdata->enable_gpio;
> >>>>>> +	if (!gpio_is_valid(gpio))
> >>>>>> +		return 0;
> >>>>>> +
> >>>>>> +	/* Always set enable GPIO high. */
> >>>>>> +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH=
, "LP872X EN");
> >>>>>> +	if (ret) {
> >>>>>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> >>>>>> +		return ret;
> >>>>>> +	}
> >>>>>
> >>>>> This isn't really adding support for the enable GPIO as the changel=
og
> >>>>> suggests, it's requesting but not managing the GPIO.  Since there i=
s
> >>>>> core support for manging enable GPIOs this seems especially silly,
> >>>>> please tell the core about the GPIO and then it will work at runtim=
e
> >>>>> too.
> >>>>>
> >>>>
> >>>> With reference to my previous mail, external GPIOs for LDO3 and BUCK=
2 in
> >>>> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 onl=
y
> >>>> can be controlled by external pin when CONFIG pin is grounded.
> >>>>
> >>>> Please see the description at page 5 of the datasheet.
> >>>>
> >>>> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf
> >>>
> >>> After reading the datasheets thoroughly, it seems to me that for the
> >>> lp8720, the EN pin is used to enable the regulators output, which is =
a
> >>> good fit for the core regulator GPIO framework, as there is no reason=
 to
> >>> keep it on when no regulator is in use. The serial interface is alrea=
dy
> >>> available when EN=3D0 and regulators can be configured in that state.=
 The
> >>> lp8725 seems seems to behave the same when CONFIG=3D0 (the datasheet
> >>> clearly states: "CONFIG=3D0: EN=3D1 turns on outputs or standby mode =
if
> >>> EN=3D0"). On the other hand, it is indeed used as a power-on pin when
> >>> CONFIG=3D1.
> >>
> >> I think it's different use case. LP8720/5 are designed for system PMU,
> >> so some regulators are enabled by default after the device is on. EN p=
in
> >> is used for turning on/off the chip. This pin does not control regulat=
or
> >> outputs directly. It's separate functional block in the silicon.
> >
> > Well, I really don't understand why the EN pin would turn on/off the
> > chip. All it does it enable the regulators outputs (by entering IDLE
> > mode), the serial block is already available in STANDBY state.
> >
> > If we want some regulators enabled at boot, the best thing to do seems
> > to be to request the GPIO with the GPIOF_INIT_HIGH flag, as done in e.g=
.
> > the max8952 regulator driver:
> >
> > 	if (pdata->reg_data->constraints.boot_on)
> > 		config.ena_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;
>=20
> According to MAX8952 datasheet, output regulator is enabled/disabled=20
> using EN pin, so ena_gpio is used correctly.
> However, LP8720/5 regulators are enabled/disabled through I2C command.=
=20
> Only few regulators of LP8725 can be on/off by separate external pins.=
=20
> (B2_EN and LDO3_EN)
> Please note that EN pin in LP8720/5 is not the control pin for=20
> enabling/disabling regulators.

Oh, I should have mentionned that I also suggest making it possible to
use *both* an enable GPIO and registers to enable a regulator. You are
of course right in saying that the GPIO alone is not enough, and the
core regulator framework will currently only do GPIO or registers to
enable not both.

In my opinion, it would be more elegant to adapt the core regulator
framework to first enable the GPIO and then call the regulator enable
ops callback instead of handling the GPIO in the driver.

However, if that change is not welcome to the core regulator framework,
we'll have to deal with the GPIO in the driver (and probably keep it
enabled at all times there).

Cheers,

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-VtvTQhBkvaUcX+S88rSA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWg5dJAAoJEIT9weqP7pUMSRkP/1XfptG63xz0ZlSDX90F8ARg
Xc2qr2q2krYha46otKMgvpJcl4INgwbTEasDMOKTMi65l5yzSkpoEuz25Us6Ik11
FGi0HpV/BGY8cgxdwEJTy8kB/vF3G0YRCyMv2du3CZM2WUebl1zM4lVl8nxQ95j7
lLIQvKvx0nSlIMgpE/CWAkjpWR7ff2bbB3VcM2HOVnVwcHMuBcS6YQFD4psDpVxS
mFpwiy5NQv0F9t9sNrtxRR/SYJuBYlY0uy3UnEEjZ5xTKq/Pxm7baiHxxrSESnMh
/5BGllNjk5aFeNsF6S2L7cS154uilzur7o9nRURZ2hPs3oZkJpUzulZTEEtrEybR
SlRaOVOWPaTwvx5+pV9MHhjT/CHxnX7OCzYy9o7ANu1ikly/ETvo7GXg31ILakCv
Edkjjgn6JNJaJ9sxAHqM+aNSdpd0Y+J3ZGnatDeuXB9b3o8DNoF4j0tZXSNUUXrs
Gb6yWL4eppngwvM2miknBZqAbNDz+DfJQi0eEDwp3t029xDDVpcnWAVNiMsw+qQ+
jL+znRHS/KzAdMFddob60pUwHP6BaYtsHqloMlqBy08yFPw1Jpqnv3ZlXJjZ/FId
69/HHHGs+CeH4+I9sWcawbTvlg7+zdM6wa7RVhI3rsHbhl9x2PdjPClM3Rp+LXav
nz2S41255iFHYIq3ZfA0
=z/1O
-----END PGP SIGNATURE-----

--=-VtvTQhBkvaUcX+S88rSA--
