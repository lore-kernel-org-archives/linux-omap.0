From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 12:03:49 +0000
Message-ID: <20160321120349.GP2566@sirena.org.uk>
References: <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
 <56EEFD4F.4030705@gmail.com>
 <20160321000417.GA21902@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fc4772q/IDjJVU21"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160321000417.GA21902@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--Fc4772q/IDjJVU21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 01:04:18AM +0100, Sebastian Reichel wrote:

> Right thinking about it, the voltage must also be configured for the
> non always-on cases. So it's not a problem with the regulator
> framework, but with twl-regulator's probe function, that should take
> care of this.

Absolutely not!  Like all other regulator drivers the twl driver should
be taking no decisions about what voltage to set except in response to a
set_voltage() call.  All the logic about setting voltages is factored
out into the core.

Please try to understand the abstractions we're using in the framework.

--Fc4772q/IDjJVU21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW7+MkAAoJECTWi3JdVIfQpB8H/ictFhXP1bmdgeRCOQq9igXm
Z7LQCZ3Aq8NJs5pAhVWKoW1nyftmEOj6PoDNVqxMhemXanJn9BxcTgNajrREkC09
7yeTmYVlRCYhbKLLEWfAX+98+H/Dm4LaDCYIQzZtQDV7k4QR66++KRPPwdfalW0E
OugsaYW5QYN7CgNL+spzV6fCum4twbhGyYE7AnbvD4XWj6rqZDzUuBlxzX2QO5TI
qVfHQzRblvD7UxuJwPjVi+B4sXFfMnkQxzEJeZVmpGy7IklqQ1WZ2dxHv4m/1JMP
q99rLPMXaiOtngdGmseJ8/rk0fiRwv5uhYd1/ag6xlWOULl7MPFHvyXrCf6/pGc=
=WfX1
-----END PGP SIGNATURE-----

--Fc4772q/IDjJVU21--
