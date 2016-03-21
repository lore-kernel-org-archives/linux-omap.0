From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 11:45:21 +0000
Message-ID: <20160321114521.GO2566@sirena.org.uk>
References: <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZNC4bMBTQymodJa2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160320051704.GA12934@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--ZNC4bMBTQymodJa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 20, 2016 at 06:17:04AM +0100, Sebastian Reichel wrote:
> On Sat, Mar 19, 2016 at 10:49:57AM +0200, Ivaylo Dimitrov wrote:

> > [    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > [    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e

> Ok, so normal power up results in running VMMC2 (always-on works),
> but voltage is not configured correctly. 2.6V is default according
> to the TRM. I think this is a "bug" in the regulator framework. It
> should setup the minimum allowed voltage before enabling the
> always-on regulator.

No, if the voltage is variable we can't tell what the current
constraints are without something telling us so we just don't vary the
voltage until we're told to do this.  If we immediately lower the
voltage to the minimum supported voltage that's going to break things.

> In case of the tpa6130a2/tpa6140a2 driver it may also be nice to add
> something like this to the driver (Vdd may be between 2.5V and 5.5V
> according to both datasheets):

> if (regulator_can_change_voltage(data->supply))
>     regulator_set_voltage(data->supply, 2500000, 5500000);

This is completely broken.  A consumer should never need to check to see
if the voltage can be varied and if the device doesn't actually need to
change the voltage as a part of the functionality it delivers then it
should just leave it up to the board constraints to set something, the
actual constaints will be much tighter than the device constraints and
there's a reasonable chance that there may be software compatible
variants of the device with different supply requirements.

--ZNC4bMBTQymodJa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW797QAAoJECTWi3JdVIfQ29kH/1QENo0rEKNocEtlMDMiwtvG
lydZDKS7SwKrQPgeLw2DCx4jE3xvkETpv1g+NP+sj0Uf2cKJB3yUh9aousee9dRt
E8JVWWn16OZtqA7vYlQjpgvZCYfInXmpx1Zw76V1cgwNX0CyzpCmb7LB7SZiLuKf
mReOE+w4zUet+laPUGD3at2/Ok5EUy3aabDJ8lAn31wpc7ryowEvCDdGDD1g8+H5
xjBqI3bYgbybd1Q/X2uBjaBgeqKjP+lLcKRiIM9/IsOH5YlL90fnCHg75JLLxvhf
zIS0+tWkGxsRj5uixG7c31moEJpBlvJ6/gYXaJ7Q1wku7wez6f1+FVpsHkv6YP0=
=8UoW
-----END PGP SIGNATURE-----

--ZNC4bMBTQymodJa2--
