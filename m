From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Tue, 29 Dec 2015 12:13:33 +0100
Message-ID: <1451387613.18148.9.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
	 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2aky9ghUYWvIG7lIr6Mc"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5681D7A8.2030101@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-2aky9ghUYWvIG7lIr6Mc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Milo,

Le mardi 29 d=C3=A9cembre 2015 =C3=A0 09:45 +0900, Milo Kim a =C3=A9crit :
> Hi Paul,
>=20
> On 29/12/15 07:49, Paul Kocialkowski wrote:
> > Hi Milo, thanks for the review,
> >
> > Le lundi 28 d=C3=A9cembre 2015 =C3=A0 09:56 +0900, Milo Kim a =C3=A9cri=
t :
> >> Hi Paul,
> >>
> >> On 23/12/15 20:56, Mark Brown wrote:
> >>> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >>>
> >>>> +	gpio =3D lp->pdata->enable_gpio;
> >>>> +	if (!gpio_is_valid(gpio))
> >>>> +		return 0;
> >>>> +
> >>>> +	/* Always set enable GPIO high. */
> >>>> +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, =
"LP872X EN");
> >>>> +	if (ret) {
> >>>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> >>>> +		return ret;
> >>>> +	}
> >>>
> >>> This isn't really adding support for the enable GPIO as the changelog
> >>> suggests, it's requesting but not managing the GPIO.  Since there is
> >>> core support for manging enable GPIOs this seems especially silly,
> >>> please tell the core about the GPIO and then it will work at runtime
> >>> too.
> >>>
> >>
> >> With reference to my previous mail, external GPIOs for LDO3 and BUCK2 =
in
> >> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only
> >> can be controlled by external pin when CONFIG pin is grounded.
> >>
> >> Please see the description at page 5 of the datasheet.
> >>
> >> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf
> >
> > After reading the datasheets thoroughly, it seems to me that for the
> > lp8720, the EN pin is used to enable the regulators output, which is a
> > good fit for the core regulator GPIO framework, as there is no reason t=
o
> > keep it on when no regulator is in use. The serial interface is already
> > available when EN=3D0 and regulators can be configured in that state. T=
he
> > lp8725 seems seems to behave the same when CONFIG=3D0 (the datasheet
> > clearly states: "CONFIG=3D0: EN=3D1 turns on outputs or standby mode if
> > EN=3D0"). On the other hand, it is indeed used as a power-on pin when
> > CONFIG=3D1.
>=20
> I think it's different use case. LP8720/5 are designed for system PMU,=
=20
> so some regulators are enabled by default after the device is on. EN pin=
=20
> is used for turning on/off the chip. This pin does not control regulator=
=20
> outputs directly. It's separate functional block in the silicon.

Well, I really don't understand why the EN pin would turn on/off the
chip. All it does it enable the regulators outputs (by entering IDLE
mode), the serial block is already available in STANDBY state.

If we want some regulators enabled at boot, the best thing to do seems
to be to request the GPIO with the GPIOF_INIT_HIGH flag, as done in e.g.
the max8952 regulator driver:

	if (pdata->reg_data->constraints.boot_on)
		config.ena_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;

> On the other hand, 'ena_gpio' is used for each regulator control itself.
> For example, WM8994 has two LDOs which are controlled by external pins.=
=20
> LDOs are enabled/disabled through LDO1ENA and LDO2ENA pins. In this=20
> case, 'ena_gpio' is used.

Of course, but the ena_gpio feature is also a good fit for a global
enable pin, as the GPIO can be shared by multiple regulators of the same
chip, which is what we have here.

In my opinion, using the ena_gpio feature is a good fit, as we don't
need to keep the EN pin high when no regulator is used.

> 	http://www.cirrus.com/en/pubs/proDatasheet/WM8994_v4.4.pdf
> 	(please refer to page 224 and 225)

Cheers,

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-2aky9ghUYWvIG7lIr6Mc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWgmrdAAoJEIT9weqP7pUMUREP/0KgxQUKwYB7rWXofHsrFu3B
XPU/Ouc/7bFz2YPmvcWP8S4ZYt5zfOEDVfTdy8eH0ylh712iZlPNq6kkKgKHNuvg
cNqk8ehCvtl7imHzaIzqsw7zbEDOm6mdDWssPTwBJhb6X5E4lfo9v+wG4tMtPj2c
tO9qTUxxX2r5IWfOSrjXS2dZGe8apDgFI3gu3+uVUjNaLX5Uj7KO7ffjwHx2KpfC
73yjP8p7C1YNU5VNqcH/dsZ25bgWnp+68mtrFPnFBxoT9Tpiz+08Dl3AYWWqnYBR
50wEnoAVHQ0fRL0H/XMqHjL8MM4XA6U8Qtbk71+3nuik73n8RtWpipsC76w9J/qq
Fv15Yxyx2P1wiiSwjJG85KRC+tauyWAlvga895qMmcDF9qXA71T5qQdLRa2tj14z
oOh83NfUfHDdu2Kx+WKM3XP2Nq3EgUQmsOBX6UWeFnmoxalt/FEeM8aTxCLejPcz
mFWzXTG8Up/xmChLaze5tQ4gyNP67rEZCw/JCFCyM3N8vO/Jb5KfcMpk/z6uOEAl
s+3xpzH1QRvLKRPf7MLgDWrTincRTKbk+2Ye0ie6RDT63wqXWpPnPMGyrPGsZ1hJ
4lw/d/AXidHw2T6PtVkQ8mKOTuaNrT5HTiKlATrkgoYZFh/pr9RjSvIZqUR9+T3g
nBJ7SOJuidBhYOUw7RHZ
=cT7m
-----END PGP SIGNATURE-----

--=-2aky9ghUYWvIG7lIr6Mc--
