From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 01:04:18 +0100
Message-ID: <20160321000417.GA21902@earth>
References: <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
 <56EEFD4F.4030705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EEFD4F.4030705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 20, 2016 at 09:43:11PM +0200, Ivaylo Dimitrov wrote:
> On 20.03.2016 07:17, Sebastian Reichel wrote:
> >On Sat, Mar 19, 2016 at 10:49:57AM +0200, Ivaylo Dimitrov wrote:
> >>On 18.03.2016 17:04, Sebastian Reichel wrote:
> >>>On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
> >>>>On 18.03.2016 15:36, Sebastian Reichel wrote:
> >>>>Regulator is V28_A, which is always-on, so it is enabled no matter wh=
at
> >>>>probe does. Anyway, I added a various delays after regulator_enable()=
, to no
> >>>>success.
> >>
> >>I guess we're getting closer - I put some printks in various functions =
in
> >>the twl-regulator.c, here is the result:
> >>
> >>on power-up:
> >>
> >>[    2.378601] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> >>[    2.384948] twl4030reg_enable VMMC2 grp 0x00000020
> >>[    2.408416] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> >>[    7.196685] twl4030reg_is_enabled VMMC2 state 0x0000002e
> >>[    7.202819] twl4030reg_is_enabled VMMC2 state 0x0000002e
> >>[    7.209777] twl4030reg_is_enabled VMMC2 state 0x0000002e
> >>[    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
> >>[    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e
> >
> >Ok, so normal power up results in running VMMC2 (always-on works),
> >but voltage is not configured correctly. 2.6V is default according
> >to the TRM. I think this is a "bug" in the regulator framework. It
> >should setup the minimum allowed voltage before enabling the
> >always-on regulator.
> >
>=20
> /sys/kernel/debug/regulator/regulator_summary shows 2850mV for V28_A, so I
> would remove the quotes. Also, always-on is because if V28_A regulator is
> turned off, there is a leakage through tlv320aic34 VIO. BTW one of the
> things I did while trying to find the problem, was to remove that always-=
on
> property from the DTS - it didn't help.

Right thinking about it, the voltage must also be configured for the
non always-on cases. So it's not a problem with the regulator
framework, but with twl-regulator's probe function, that should take
care of this.

> >In case of the tpa6130a2/tpa6140a2 driver it may also be nice to add
> >something like this to the driver (Vdd may be between 2.5V and 5.5V
> >according to both datasheets):
> >
> >if (regulator_can_change_voltage(data->supply))
> >     regulator_set_voltage(data->supply, 2500000, 5500000);
> >
>=20
> and add DT property for that voltage range, as max output power and
> harmonics depend on the supply voltage.

I guess that's 2nd step.

> >>after restart from stock kernel:
> >>
> >>[    2.388610] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> >>[    2.394958] twl4030reg_enable VMMC2 grp 0x00000028
> >
> >I had a quick glance at this. I think stock kernel put VMMC2
> >into sleep mode. Mainline kernel does not expect sleep mode
> >being set and does not disable it.
> >
>=20
> Well, one would think that kernel should not have expectations on what wo=
uld
> be the state of the hardware by the time it takes control over it, but se=
tup
> everything needed instead.

I thought it's obvious, that this is not the desired behaviour :)

> >>[    2.418426] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> >>[    7.186645] twl4030reg_is_enabled VMMC2 state 0x00000020
> >>[    7.192718] twl4030reg_is_enabled VMMC2 state 0x00000020
> >>[    7.199615] twl4030reg_is_enabled VMMC2 state 0x00000020
> >>[    7.205535] twl4030reg_is_enabled VMMC2 state 0x00000020
> >>[    7.212951] twl4030reg_is_enabled VMMC2 state 0x00000020
> >>
> >>I don't see twl4030ldo_set_voltage_sel() for VMMC2(V28_A) regulator, th=
ough
> >>there are calls for VMMC1 and VAUX3.
> >
> >I guess that's because the voltage is only configured if at least
> >one regulator consumer requests anything specific.
> >
>=20
> But then the board DTS is simply ignored. Doesn't look good :)
>
> >>So, it seems to me that V28_A is not enabled or correctly set-up
> >>and all devices connected to it does not function. And it looks
> >>like even after power-on VMMC2 is not correctly set-up - it is
> >>supposed to have voltage of 2.85V (10) but kernel leaves it to
> >>2.60V (8). However my twl-fu ends here so any help is appreciated.
> >
> >So in case of reboot from stock kernel voltage is already configured
> >to 2.8V, but it does not work, because of the sleep mode.
> >
>=20
> Yeah, that sleep is pretty clear, I was rather asking - "any idea how to =
fix
> that?". Or it is someone else expected to fix it?

You may have noticed, that I included Mark and Liam. I hope they
can give some feedback. I think there are two bugs:

1. twl_probe() should setup a default voltage based on DT
   information.
2. if regulator is in sleep mode, regulator enable should
   disable sleep mode.

-- Sebastian

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW7zp/AAoJENju1/PIO/qaGaoP/1NcfIjgxncCPqEb36lg2cdo
IkX0Rh7u32Qq8Zh/z8TgsOFFRBsBnj7zDgbNG+drAzqVUxD88p+mxYIxBbT/J6Cq
hKsRHOqTMMs48IkDrlqkupFC4b/e4RiJbk/Z+6EvY/6qzgqgzHYF0LsS4bEg9/yg
uzP1BO0XeNLmNg+BCll0dSWPPRiachL5vRtzdnIyJIMOEpNP2io673UefEUYl8+3
JFC0iwG4XfmUBofd3GD1ZVDLeJgqay5Bo3/DkMfUARY4AkL9IalvDUsOMBuoPAbb
lymwBMIOX0tkntIpbAB8h1Kb5NSFCSXyC0IO1JCOXDhkgrMxqnm3cf2oEqQbAhdc
BKbJKf7HmWW3nM7jLCuhJpWwL/9qE+BFeqYR7Shqwm2v+D95MFqvaaHF2a089aY2
OZ0d6Jex0cIfeyaf4mIEEhBc1PM+bEhWKiBsfg6JX65I6kBXdxrX+kOc0eYqWbiV
Xxcf/yOIW+8we3eObRh+86QWercYrkRkZ46U+nQOWFZTf2WSICLEK1CGjzc2aD3c
IjEL8+hkcZywCfh3ffD2oXvbgpJEYditrnYnNOVE0QHIU33eLQfeop5j3/c2sbdS
6U9onJ5mkzzD2eQyS9rtTo2uoY7zyu8YwBVlRoCaL3IY796tTL9RnM5DMmEW7N3I
jLMaiXTfbPGd42bY2p5s
=2A7R
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
