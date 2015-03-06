From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Fri, 6 Mar 2015 23:56:06 +0100
Message-ID: <201503062356.06110@pali>
References: <20150224043341.4243.23291.stgit@notabene.brown> <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com> <20150306224034.GA20559@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1632230.Lj8Be8I94Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150306224034.GA20559@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Grazvydas Ignotas <notasas@gmail.com>, ivo.g.dimitrov.75@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, khilman@kernel.org, NeilBrown <neilb@suse.de>, sre@debian.org, linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, sre@ring0.de, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--nextPart1632230.Lj8Be8I94Y
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 06 March 2015 23:40:34 Pavel Machek wrote:
> On Sat 2015-03-07 00:12:07, Grazvydas Ignotas wrote:
> > On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh=C3=A1r
> > <pali.rohar@gmail.com> wrote:
> > > On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
> > >> Hi!
> > >>=20
> > >> According to n900 dts, twl4030-bci (aka charger) should
> > >> be included.
> > >=20
> > > AFAIK it is not present on n900...
> >=20
> > Right, it uses twl5030 variant without the charger, charging
> > on n900 is provided by separate chip and for a good reason
> > as twl's charger is not that good. Forcing the driver to
> > load just ends up with it accessing non-existent registers
> > over i2c.
>=20
> Ok, but:
>=20
> 1) Why is the twl4030-bci enabled in n900's dts, then
>=20

maybe it is bug in n900 dts...

Grazvydas, is there some runtime check if twl4030/twl5030 chip=20
has charger or not? or do we need to explicitly disable device=20
twl4030-bci in DT?

> and
>=20
> 2) When it is enabled, why it does not load?
>=20
> (I guess there's no way to get to input voltage on n900...?)
>=20
> 									Pavel

you can read voltage only from rx51_battery.ko (TWL ADC) or=20
bq27x00_battery.ko

look for Nokia_N900_RX-51_Schematics.pdf file where you can find=20
information what is connected to ADC and bq27200 chip.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1632230.Lj8Be8I94Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlT6MIYACgkQi/DJPQPkQ1IhHwCfftLheK7rQDlP7eUn996Srk4Y
ipYAoMsN4mMCc4rPvMPlRnAZB8ZSFmim
=m3Tn
-----END PGP SIGNATURE-----

--nextPart1632230.Lj8Be8I94Y--
