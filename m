From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Wed, 20 Jan 2016 16:42:58 +0000
Message-ID: <20160120164258.GF6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VOikT1vHjjoKyvem"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453292992-1788-2-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--VOikT1vHjjoKyvem
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=DFmann wrote:

> This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> electronics TX48 module. Make the IRQ optional in the driver and use a
> polling routine instead if no IRQ is specified in DT.
> Otherwise the driver will continuously generate interrupts and make
> the system unusable.

How will the driver generate interrupts if there is no interrupt
physically present in the system?

--VOikT1vHjjoKyvem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWn7kSAAoJECTWi3JdVIfQ2GUH/jJjoPYBYMdaMnSOAAm+llB1
KKXWr7LaaNd6oizz/5y8Wcuht9bdPbLdx5xBPswzNA8QZoV4gpOtEPeAvdMjX12k
2AofyEo+4W4MYB8jL0hvLF9CUSPbXCT3PN8iJNBF9rXgcYitBkY0FLWzE5JlqIYY
Vnm7udv+loOS8ujr+TWiYQtp5+H8mfO6fdHINw0XvVsgJEgRlUWM9hHBqbndA5td
o8r4CmGuXTCUzN0ONaIMCz+mIZ6qHxqA72kwgvZMxJGpnbDbIUBiiswaSxrY9IWJ
oF0kcp/wI9hkqng6c7nhxoko1xEBn4bRwsMV971UfzZB0HEDBKcSOLP81/dx45M=
=+65I
-----END PGP SIGNATURE-----

--VOikT1vHjjoKyvem--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
