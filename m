From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v4 1/5] ARM: dts: LG Optimus Black codename sniper basic
 support
Date: Tue, 01 Mar 2016 09:05:06 +0100
Message-ID: <1456819506.1157.0.camel@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
	 <1456663185-14170-2-git-send-email-contact@paulk.fr>
	 <20160229215136.GO13417@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Jatx2w5AKiSHm054EvsA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160229215136.GO13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-Jatx2w5AKiSHm054EvsA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 29 f=C3=A9vrier 2016 =C3=A0 13:51 -0800, Tony Lindgren a =C3=A9cri=
t=C2=A0:
> Hi,
>=20
> * Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> > The LG Optimus Black codename sniper is a smartphone that was designed =
and
> > manufactured by LG Electronics (LGE) and released back in 2011.
> > It is using an OMAP3630 SoC, GP version.
> >=20
> > This adds devicetree support for the device, with only a few basic feat=
ures
> > supported, such as debug uart, i2c, internal emmc and external mmc.
> ...
> > +&i2c1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c1_pins>;
> > +
> > +	clock-frequency =3D <2600000>;
> > +
> > +	twl: twl@48 {
> > +		reg =3D <0x48>;
> > +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
> > +		interrupt-parent =3D <&intc>;
> > +
> > +		power {
> > +			compatible =3D "ti,twl4030-power";
> > +			ti,use_poweroff;
> > +		};
> > +	};
> > +};
>=20
> Chances are this devices supports cutting off the voltages and
> the high frequency oscillator during idle. So you may want to
> at some point set compatible =3D "ti,twl4030-power-idle-osc-off"
> here.

Thanks for the pointer, I'll consider adding this in the future!

> Anyways, applying the dts changes into omap-for-v4.6/dt thanks.

Nice, thanks!

Cheers,

--=20
Paul Kocialkowski, low-level free software developer on embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-Jatx2w5AKiSHm054EvsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1U0yAAoJEIT9weqP7pUMOR4P/j3B43xL6jJQ+lXImO3Tbjuj
MeqrE5GLPaSYjma1eZNq+aVUrh72fTG6m1PKTimLOCxQ7C294oJ6wCPgy/OfoV2L
HdZ7mVOHFJ503D+YgNfzyDYryuGe2AIKyr4jn+Bn0NIma9nrRNklVeSmMPcqW9jk
EB3kUAGkx2jKceyfTlmLMXiM9Aj7tQ3DqYYkywP/cQ8x8m2yQgCLD0uIoV8S2Z5H
vcmpwy6QvVIEyTyau5wv+2ZJQRXcaw6+uOKYiGpkMBhtm34ZRuCYQtQDD7X5ckHI
8eGtk8DN6j7OALgBsBLIt4ggNJctMLPL5wuqdgoHGbFIGNMMYTRty4RqbR56KVs8
Ai76ouR24xUvelZ1TttSDdlbR9GRYcT+Fc40sQ6jXwEIya5OK1wxR5mDm/puqf5B
5SH8sV2gwxWoElhc+QKdNcYMHfSGTfrX2KIR3Q9sd60QziG+BjTrvKRhms3DrHa1
oU/eW2bpBpOiueHpgCwvZX2CgK67ZHgopPTqwm06LzYDEfymZdj1H0kqExU4VVy9
7/7nK81YvgxGto1URavQ6AR3wg4qZhiHL5tG+l3qD9fndMH4mNZG7dsvl+R+KG13
aR999d94SJ7CZqZHouj8phIi7qAbXXhHnWFBbux8HWGuceZUGfrbqrdlwQ0EJ5hp
V1bTxPiy9YLPahg38CjZ
=IqQg
-----END PGP SIGNATURE-----

--=-Jatx2w5AKiSHm054EvsA--
