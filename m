From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH REBASE 0/6] i2c: omap: misc changes
Date: Mon, 14 Jan 2013 21:16:28 +0200
Message-ID: <20130114191628.GB9402@arwen.pp.htv.fi>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1355502849-9289-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2012 at 06:34:03PM +0200, Felipe Balbi wrote:
> this is just a rebase of the previous series adding support
> for amount of bytes transferred upon NACK.
>=20
> Well, actually the patches implementing transferred bytes
> reporting aren't here because we need to discuss how to move
> forward.
>=20
> This series is just a preparation for that, but it also
> contains a at least one bugfix.
>=20
> Each and every patch has been tested with pandaboard, it
> would be nice to get Tested-bys from other folks on other
> platforms before pushing this for v3.9 (there's more than
> enough time for that).
>=20
> Note that we're also dropping b_hw flag since that becomes
> useless since we'll never set STT and STP together anymore.
>=20
> Give it a good round of test, please.

Wolfram, I have these patches rebased on top of v3.8-rc3 if you wish.
Let me know if I should resend them (again).

cheers

--=20
balbi

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9FmMAAoJEIaOsuA1yqREhJYQAJkyYLOUaDYySulIZqlKGf/L
en5xlfVrtkRt7iOiIgukxEfL2kS6ZdesDaIXla7qBQ7SmP+asPxdg1YCWxnwGmUt
qZKjyyXj7l/0g/OBJ6IxLyXye91W8UKa3GijJKQ4izlOZoq+WOX5odP7ght1CW96
mNkTb0LLp5tQGuE7CIfuafTpJl1Z4UMcLKyUAGjrQ8zjG3QKLO1yvjURJIt8HKb+
H0MVTzQMFzDCn3B0d5ZAI/tSML+gNb1JkEUHR7TxY4NQkb7WIeQjMM9N9JfHZsAi
2MXtRXnc7XXNn2LpIu1i2uHgd+GL6Fzx11bwTn0WBgVA0xKOMG34h2zEcC3I+Nbs
XdZ4FIS3ilGz1Tfa1TtsxM86D2uKzmd/yD9KeEaMm5oFEzau/dQAQBSeCdkDkhri
NJ6AtDNvyd8emV0OOC8z/e7cw33z/p+ZuqmRlZ5atT11LTKwUUlujxQIpjKJfIcu
+67vAhNjhH2eRAvBVbgQAAvhZW146J11YMsJLX1JY1OFJ5FyD+zmHJgJUgQF///w
7yDq1rJisv6j4OUtbcfwhDuBDRbiT8S8LrqalAFLxFknzBgO9vZP/jljE8IEaJdl
lYYQEOfA4OYCMJxr4OwhYgf4J/CbhR043kU5bGRlPU6+OhXYzbLPDtxQJHI46+Df
+R1I5jAGOr1CLA/iEWYK
=CDSS
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
