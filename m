From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 0/4] Few cpcap charger fixes for v4.12-rc cycle
Date: Thu, 4 May 2017 17:55:09 +0200
Message-ID: <20170504155509.iyzqh62enevipw3a@earth>
References: <20170504001532.10585-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm7aykd6vqty75l3"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170504001532.10585-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sm7aykd6vqty75l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 03, 2017 at 05:15:28PM -0700, Tony Lindgren wrote:
> While wondering how come the ADC values don't match the charger
> values and Android kernel values, I noticed few issues that
> would be good to fix for v4.12-rc cycle.
>=20
> Especially we should stick with the Android kernel name "usb"
> for the charger as there's no need to break the compability
> there.
>=20
> The other issues are fixes for misconfigured charger hardware.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> Tony Lindgren (4):
>   power: supply: cpcap-charger: Fix charger name
>   power: supply: cpcap-charger: Fix charge voltage configuration
>   power: supply: cpcap-charger: Fix enable for 3.8V charge setting
>   power: supply: cpcap-charger: Keep trickle charger bits disabled
>=20
>  drivers/power/supply/cpcap-charger.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks, queued.

-- Sebastian

--sm7aykd6vqty75l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLTt0ACgkQ2O7X88g7
+ppiFA//VEa+AAiP6l4ZbDB9oNvwnQySqVUvh6eK3GFr7jQ/IygUMV6nLUUI6wh2
mxMXtV9da3xH2C7LnjFVlMeFXNzkoqWvgiNW810He64jAHyM2/vZbuBHdLpX0Bx3
w1SL+ts94ZrwiTZIZSh1oFaOaptb3pzIBzRUTsIgsyUnuUXPGnJpTsT1yR4Wkjlf
I+vxqvCYOIe53nym6FT8/yXZ0LnY/wCOF35Pc8c1qVNhtfQ3Yhxtryfk5a9aPpms
JBb4corjp6dBFZJNFi+6EpWgpOL5YPNRdjYIqfExNQ/SzwmDxRvWCFla+aBcl7t7
7a0pZc5m8fuBNc9/0USZecLiikC2c1E6YJUSV9TASzdjfXYoW49EB5aLHo/SHJKA
7refiqR0H1LwR+UujHz02ckh4XEc7KLAZiVCyQgY69fOZZ4Vdu47c4ro5+569C9v
AxAbu4OeHrAuHubxHhFHrHCS1wBRvsms2Jt9HELtQh7Xx4z/uUX1fhO4103WmqHk
Bc5oYfmAoWWeC4wH1eDDgwhrnH65kSLGz2QTOjOWZww1sViGNCwO803Q2b3gywx6
9vkytZuRbj2Vqf6C5W9EevzaTpBJ2y44JOBDuLxwX8M2bm/8AGCoC56N881Gl1E0
PrTDMyriffCOmxRc4A//lmh0PI0CZYbPSK7CDf2rq9b+eLdMtJk=
=SCAe
-----END PGP SIGNATURE-----

--sm7aykd6vqty75l3--
