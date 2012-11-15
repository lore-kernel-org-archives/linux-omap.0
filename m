From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] mtd: omap: nand: Remove 0xFF's that prefixed 16bit
 NAND addresses
Date: Thu, 15 Nov 2012 17:18:44 +0200
Message-ID: <1352992724.2221.61.camel@sauron.fi.intel.com>
References: <20121029195127.GA32749@harvey-pc.matrox.com>
	 <1352977329.2221.29.camel@sauron.fi.intel.com>
	 <20121115144800.GI2508@harvey-pc.matrox.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vEpVp4f+3bstw3HP/Cmm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41051 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768107Ab2KOPSG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:18:06 -0500
In-Reply-To: <20121115144800.GI2508@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Harvey <charvey@matrox.com>
Cc: linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org


--=-vEpVp4f+3bstw3HP/Cmm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-11-15 at 09:48 -0500, Christopher Harvey wrote:
> On Thu, Nov 15, 2012 at 01:02:09PM +0200, Artem Bityutskiy wrote:
> > On Mon, 2012-10-29 at 15:51 -0400, Christopher Harvey wrote:
> > > In 16bit NAND mode the GPMC would send the address 0xNN as 0xFFNN
> > > instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
> > > bits that were left unset in the GPMC command output register. The
> > > reason they weren't initialized in 16bit mode is that if the same cod=
e
> > > that writes to this register was used in 8bit mode then 2 commands
> > > would be output in 8bit mode. One for the low byte, and an extra 0x0
> > > command for the high byte. This commit uses writew if we're using
> > > 16bit NAND. This commit also changes the high byte in the command
> > > output register, but they are ignored by NAND chips anyway.
> > >=20
> > > Most chips seem fine with the extra 0xFFs, but the ONFI spec says
> > > otherwise.
> > >=20
> > > Signed-off-by: Christopher Harvey <charvey@matrox.com>
> >=20
> > Pushed to l2-mtd.git, thanks!
>=20
> !!! Did anybody get around to testing this? I thought this patch had
>     been abandoned. Will testing get done on an omap chip now that it
>     is in a tree?
>=20
> I should have prefixed it with RFC.

I assume _you_ tested it, and Ivan was happy. But if it is untested, I
am dropping it.

--=20
Best Regards,
Artem Bityutskiy

--=-vEpVp4f+3bstw3HP/Cmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQpQfUAAoJECmIfjd9wqK0ua4P/jC9Dta4BcyR+ovVT68iqOEC
8DvT/Iv5lGMFYm6ychswiY0t6xkw+2X1NKIL3fKblWY9m5H0Y5jQHC0jwi+DFsyM
jCXwi2tzkgkXdiK8Mnz0RrGQ3MSwcmsIzrA/Xml422cuo5p1lYzFmZVeSO1fd1A5
6RXZGp0L0it+0CSJ5FdcgUUVUNn31M4GwOw99r5x7m+7x6Ar44kzbPX0qslr5j/u
l11hcWeqz1Y0ZSH4GTviVzjBGu4843CUXVOkPAb5RmYJ0DJ6sXAMxgQxdggrPP1f
J4gTzsHsiSatyIR4sAEAZr/ADn7APClfk1NtNOC8WGnkIeOsXOhT9nuHnkN0PLEM
ZE8KHrIn/lQuhbHz+5t+/HuvRie/WKZ51U5HcDDCaoS6OlYYVzF1G7Cn6DnMsLYP
04dHYy2nypcOnQpV9W/AjlrWQasWgy89qznjEZVzHbqZrIfza+BJI6YU8KQwsrtU
u4D1kK1K/ss4gN/O1DbjEblBkzq8ExKl6AS4t67HZlOsirtjdkoDJnHXOW2vIn0J
s3o7rcRvAb9YxXTbq7DYkcrdcVhf6iDjergLQnqCJwuIzJDpT70Z9v9LyxV8lsgz
zXcsM/frHSaILYkPhVKDGIKypI10CMwkNVAPR+At9+snkwm6kXjbU4oRICBGZQI4
1V0VLKv1e8ZjLiM7piZV
=vzZu
-----END PGP SIGNATURE-----

--=-vEpVp4f+3bstw3HP/Cmm--

