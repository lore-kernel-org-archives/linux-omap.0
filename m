From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 13:45:15 +0000
Message-ID: <20160321134515.GT2566@sirena.org.uk>
References: <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
 <20160321114521.GO2566@sirena.org.uk>
 <56EFF983.2050303@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NjAZgGx+5kyWce/c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EFF983.2050303@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--NjAZgGx+5kyWce/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 03:39:15PM +0200, Ivaylo Dimitrov wrote:
> On 21.03.2016 13:45, Mark Brown wrote:

> >No, if the voltage is variable we can't tell what the current
> >constraints are without something telling us so we just don't vary the
> >voltage until we're told to do this.  If we immediately lower the
> >voltage to the minimum supported voltage that's going to break things.

> There are constraints set by the board DTS. Isn't it reasonable the
> framework to set the voltage to minimum voltage from the dts if the current
> set one is bellow it?

Yes, if it's out of bounds for the constraints we should bring it
up/down to the minimum/maximum (when copying people into a thread it's a
good idea to explain what the problem you are trying to solve is,
especially if you're throwing around bodges).

--NjAZgGx+5kyWce/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW7/rpAAoJECTWi3JdVIfQz8AH/js+6a33ArLurRmXMgKgSWXa
NAL2djHBIgZswYhIyqPgwGpTxVRTujqjxwCM3iAe9g1WYy8jGrGN5mQdhifiHh5v
Ds8TMmOz5q+LMO+HaXr+qqZVGkMFaj5eK6MnlJxnrdEzSlPpZYEkMicdr8DT7Sxg
1Rn9T2Vjd9btdvMJrjSFMCcn2kWpVTF9jjiZbUdY5sE1uEHwFrgg9p+q5607deqk
4l5lm0UBQVIJ9ENyRqX7FxIRDbWmkKxqQKzfxriiPikT7In9pRJH1h+653HqXIpq
8A5J673qql5zNBfYT5RJXJlbMPPxjAN8z/GWBGrPJkrRi4DNRNpEXzLcBgJQwfo=
=KVGp
-----END PGP SIGNATURE-----

--NjAZgGx+5kyWce/c--
