From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v4 0/3] mtd: nand: OMAP: ELM error correction support
 for BCH ecc
Date: Thu, 17 Jan 2013 14:06:15 +0200
Message-ID: <1358424375.2731.234.camel@sauron.fi.intel.com>
References: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
	 <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-97PiZq+ZXz3zLdWxUiVi"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "tony@atomide.com" <tony@atomide.com>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "zonque@gmail.com" <zonque@gmail.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "ivan.djelic@parrot.com" <ivan.dj>
List-Id: linux-omap@vger.kernel.org


--=-97PiZq+ZXz3zLdWxUiVi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-01-16 at 12:22 +0000, Philip, Avinash wrote:
> > This series is based on linux 3.8-rc2 and tested with [1].
> > Also this patch series depend on [1] for NAND flash device
> > tree data and gpmc nand device tree binding documentation updates.
> >=20
> > 1. [PATCH v7 0/5] OMAP GPMC DT bindings
> > http://www.spinics.net/lists/linux-omap/msg83505.html
> >=20
> > Tested on am335x-evm for BCH 4 and 8 bit error correction.
>=20
> Can you apply this patch series on l2-mtd tree as it will help RBL compat=
ibility
> ecc layout for NAND flash in am335x-platforms and hardware based BCH erro=
r
> correction.

OK, I've applied them. I dropped the part that updates the
documentation. Please, handle it separately when Daniel's patches are
in.

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-97PiZq+ZXz3zLdWxUiVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQ9+k3AAoJECmIfjd9wqK0h78P/ihNKGVzJ6EZoycfAIadjAbb
yYsq/A3Zo4Ex4X7GqJFADPW5IpEHQakQ//plP6Ug5r58ZTViQGmhT4ZT1VE3mmZ2
8A+aLkTGGqu9QSzzhYlyQYROFgdJPOc+oTzfGqE9H9c6l2uN0YWlVA6622dd8j8q
4PF0Z7CWmWmzremwWoHtJTS/+WVmrhGx3qDODEglMY8MoBu53ljFBO1HYQwT630g
SHmHTJ5oxAfUGvWkb+9J6nJl6KEiaojCKdb0KqMCLjnNVL3YpqbM8URmE5G3WXqt
ywzoovgMiXXGa+8HG4xJV1IoshEnJFEsBplYRRBqlQjTPMbAgmP1qqVjFGaWtKSg
M/PpbsEhHdOzTfLdeqxDHSCyPyHKu4RG6qbF+NrZeSgM4PsUNKMQvwMvyZV6sLk0
8LELXZTcnaJ7xB/diVXH38TuHXWOCL4SiAfNd6NRSxSSbPsQRWsw8WLRi3ad5Hn7
chKo/Dk/K27iPZPIm8Ym1WlRHyzLspjvkh2Mzn7lhRmAMSxKdweNH+vKus5BHOGv
oPXajCRUROrtfO5xaHcQlMa/R7ooUT9J/QawljBrE8zsJK0W/rRxDJWLIKsaSW+R
KQWpjw9YavHSWLk57Z3F4MVgK8rXRGyBV/Lxy2GzGOpBPfOnCAQoRA3UVICkPikM
wycjvDqWHtLjIJVWwwHc
=JGA8
-----END PGP SIGNATURE-----

--=-97PiZq+ZXz3zLdWxUiVi--

