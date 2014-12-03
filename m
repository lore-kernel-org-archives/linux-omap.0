From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-omap / PM: Drop CONFIG_PM_RUNTIME from i2c-omap.c
Date: Wed, 3 Dec 2014 12:17:32 +0100
Message-ID: <20141203111732.GC1039@katana>
References: <1764802.h0lkXSoFee@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1764802.h0lkXSoFee@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 02:58:15AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so some #ifdef blocks
> depending on CONFIG_PM_RUNTIME may be dropped now.
>=20
> Do that in drivers/i2c/busses/i2c-omap.c.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
>=20
> Please let me know if it is OK to take this one into linux-pm.

=46rom my side, yes:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Might be worth waiting a day for an ack from someone at TI. They usually
keep a good eye on their drivers.


--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfvFMAAoJEBQN5MwUoCm2qbUQAKrX54LEYWLrqmU+/rMj37u9
ApAk6STSKWHuglymQ+gjXBlGBSwu9d7xjt9ROWXIppd/hRDqLHUY/FB3/3YDaAMl
O/m0kI1BiwYcha8jbd+bFcakOMBJeNZEiVTpKCj+qMDtlGQffzZkupP+0XlGYwvu
ZRuQzc9elGnu0fxoDw3/4Isic00MKZm43vgfJBBrJxaeCCmImez8UubXmHv6z8UQ
D+lnMqvlBDMJYGHbwClUcw8nbtfbX4xkxoYxcw4x4D0X4y9njQjEsj9tpJxOHsdc
jZDs0o6NrdgewZhh8N4MtW7lDb3q6olpcD5jUuHrn7JgGK/88FxcMn9h5cLX5QSG
MFDsBKj9zAWHbsXjgDlGwZQx0FNZilJ3Z8V5NO+Jy1iTKpJckE47aBiKuqTwk6ss
W02L0cf+V6Ub/RRRkSVLRy0/CPwFXhGVxCVTHT19AIXRLU7KEQRJs1jE2NpUk+mk
E302ihKPACI3VrDNQ5LD3mRWrDvk1JHFzq8A5L9todD/T9sImOeEF4wNxf1vlVsC
vYQiWDmr44Ig+INYtjLl1Q37LdDohphw2aAtIlF8gAC+d2XlQUcYQoDR6Y2v33U2
nuXzbF6Y3UW1+Xs4ezUmBBrjz7Jv7TiGXr82GXiQpQwzv54tvK+9pzi/bgJK7brf
9kindPUPir34s8hey5Qj
=dMhd
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
