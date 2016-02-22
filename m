From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
Date: Mon, 22 Feb 2016 11:53:03 +0900
Message-ID: <20160222025303.GL18327@sirena.org.uk>
References: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
 <20160219170404.GH21202@atomide.com>
 <56C98315.1000707@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xsbw7+pkldUUnFG3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C98315.1000707@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, j-keerthy@ti.com, robh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Xsbw7+pkldUUnFG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 21, 2016 at 10:27:49AM +0100, Heiko Schocher wrote:
> Am 19.02.2016 um 18:04 schrieb Tony Lindgren:
> >* Peter Ujfalusi <peter.ujfalusi@ti.com> [160219 06:14]:

> >I'll apply this revert into omap-for-v4.5/fixes as it fixes a
> >regression.

> Sorry for breaking ... but I have no bbw hw for testing ...
> (This is maybe a reason for having something like an automated
>  testsystem, see an example/proposal here:

Or sending boards to kernelci.org for that matter.

> But I removed this file as Mark Brown suggested it, see:

> https://lkml.org/lkml/2015/10/21/581

> So please introduce a "tps65217-am335x.dtsi" file ... Mark?

This is an OMAP DTS file, it needs the OMAP people to work on it - DT
updates don't go through the driver trees usually.

--Xsbw7+pkldUUnFG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyngLAAoJECTWi3JdVIfQ3sMH/1vDUajWkb4vfetTUFl+DnJm
aMmkiWv0jdWqNQq7SepNk4Hub6TEx0e0Glotkn9qC/kxoIZfiV5tRURzUsO12do6
FJZFePtyMEzhankVdDozYdB7errfMQAAq+IqcLJT/BZW4a3XXWiBgja1cCQMqmWt
KN8PnnufTNJPpFbgNR+cWaIlOcu6+6A9hqJnxGR44fJmdv/0K4C+fFkezkEEmoa9
i9/pyN4olU/VgpUxuq4P/fCL7ChmgWtUoEkdjc5Et9IvutEB70WooGoVnZ05J0A3
4ySevggVi4QKcCkfvam2tb34QyR4OYHejokqKwvbvTAB5mhS120Y5fdVlKrNHa4=
=T4Jh
-----END PGP SIGNATURE-----

--Xsbw7+pkldUUnFG3--
