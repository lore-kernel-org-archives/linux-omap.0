From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sun, 20 Mar 2016 06:17:04 +0100
Message-ID: <20160320051704.GA12934@earth>
References: <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56ED12B5.9000103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 19, 2016 at 10:49:57AM +0200, Ivaylo Dimitrov wrote:
> On 18.03.2016 17:04, Sebastian Reichel wrote:
> >On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
> >>On 18.03.2016 15:36, Sebastian Reichel wrote:
> >>Regulator is V28_A, which is always-on, so it is enabled no matter what
> >>probe does. Anyway, I added a various delays after regulator_enable(), =
to no
> >>success.
>=20
> I guess we're getting closer - I put some printks in various functions in
> the twl-regulator.c, here is the result:
>=20
> on power-up:
>=20
> [    2.378601] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> [    2.384948] twl4030reg_enable VMMC2 grp 0x00000020
> [    2.408416] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> [    7.196685] twl4030reg_is_enabled VMMC2 state 0x0000002e
> [    7.202819] twl4030reg_is_enabled VMMC2 state 0x0000002e
> [    7.209777] twl4030reg_is_enabled VMMC2 state 0x0000002e
> [    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
> [    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e

Ok, so normal power up results in running VMMC2 (always-on works),
but voltage is not configured correctly. 2.6V is default according
to the TRM. I think this is a "bug" in the regulator framework. It
should setup the minimum allowed voltage before enabling the
always-on regulator.

In case of the tpa6130a2/tpa6140a2 driver it may also be nice to add
something like this to the driver (Vdd may be between 2.5V and 5.5V
according to both datasheets):

if (regulator_can_change_voltage(data->supply))
    regulator_set_voltage(data->supply, 2500000, 5500000);

> after restart from stock kernel:
>=20
> [    2.388610] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> [    2.394958] twl4030reg_enable VMMC2 grp 0x00000028

I had a quick glance at this. I think stock kernel put VMMC2
into sleep mode. Mainline kernel does not expect sleep mode
being set and does not disable it.

> [    2.418426] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> [    7.186645] twl4030reg_is_enabled VMMC2 state 0x00000020
> [    7.192718] twl4030reg_is_enabled VMMC2 state 0x00000020
> [    7.199615] twl4030reg_is_enabled VMMC2 state 0x00000020
> [    7.205535] twl4030reg_is_enabled VMMC2 state 0x00000020
> [    7.212951] twl4030reg_is_enabled VMMC2 state 0x00000020
>=20
> I don't see twl4030ldo_set_voltage_sel() for VMMC2(V28_A) regulator, thou=
gh
> there are calls for VMMC1 and VAUX3.

I guess that's because the voltage is only configured if at least
one regulator consumer requests anything specific.

> So, it seems to me that V28_A is not enabled or correctly set-up
> and all devices connected to it does not function. And it looks
> like even after power-on VMMC2 is not correctly set-up - it is
> supposed to have voltage of 2.85V (10) but kernel leaves it to
> 2.60V (8). However my twl-fu ends here so any help is appreciated.

So in case of reboot from stock kernel voltage is already configured
to 2.8V, but it does not work, because of the sleep mode.

-- Sebastian

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW7jJOAAoJENju1/PIO/qaV+sQAJfVD8xwyn4pGYypZzKMYZNH
HfE2S+UTD2Sz4/gUEWJqtc03ujsorE6A9WV6ozmDZQNO2/GMeHIu2newScvoZcEL
o/Q3RMNBZ6uTyONwvPfV8iDL2h6xsrBibUaFx7rDQfPHDfzxopskBqi9O/SY4J7F
bR8A5wWrB/RHG8UNcDiRQwv/Eg2sxTIwvyhpNOl2Q2sCLrQx53pJ3stSSC2n+rWQ
uVn7TGD4j+oh/gPD9QhveJ8P1zU4O+acfsj61VgSN9TmAcRmI9CAL3dR5jXyDRo8
ES5zt5/YeXp6Q0NADUF9V8EbKCUX6UEujqflYwF6bokhU6gtH5iGzdOTepbjGrLI
Pb+izktkQ/tSgtqxtRZomMiX71eAeJqWSDtKH8hI3seDNmelyNlc1Nh/5ejTGJIQ
MdD+sgx5vF1NPn3z6WnMv9uH3mkpFEOabmFajQ4UEkh7kJyj2R2jmGTUCQ5T0xF6
UeZQWPQnrjImZdPP6nprxizZkYQAhD+ImnuEouey81mgJEX4D8SZUJd5KYijI3Y6
oGHCD/ogbJZ+EuefYPOFW0V68XmaJEiN+MA+kGO84+4R1KFyfDpwFG07AWZRbpdh
Rluf8voH/k98LrxfOSperjfR95/+Piv4EKtTNLERp1agKsEL3kLHIncXNpwb2J0F
LP0hIs0+moTkg+wDLYlr
=01ZJ
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
