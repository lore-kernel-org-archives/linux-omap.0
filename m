From: Felipe Balbi <balbi@ti.com>
Subject: Re: regression caused by commit
 8357b48549e17b3e4e402c7f977b65708922e60f
Date: Thu, 27 Jun 2013 10:04:24 +0300
Message-ID: <20130627070424.GM15455@arwen.pp.htv.fi>
References: <20130627061419.GE15455@arwen.pp.htv.fi>
 <20130627163655.239cea102ba0eb968a434593@canb.auug.org.au>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wAI/bQb0EMvlZCHl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130627163655.239cea102ba0eb968a434593@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: balbi@ti.com, "Yann E. MORIN" <yann.morin.1998@free.fr>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--wAI/bQb0EMvlZCHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 04:36:55PM +1000, Stephen Rothwell wrote:
> Hi,
>=20
> On Thu, 27 Jun 2013 09:14:19 +0300 Felipe Balbi <balbi@ti.com> wrote:
> >
> > after commit 8357b48549e17b3e4e402c7f977b65708922e60f,
> > omap2plus_defconfig doesn't 'hold' the answer to USB Gadget Drivers
> > anymore. Everytime I run oldconfig, it asks me again and again what USB
> > Gadget Drivers should be (M/y/?).
> >=20
> > That's certainly not expected considering it wasn't like that before.
>=20
> That commit has been reverted in today's kbuild tree and thus in today's
> linux-next.

thanks, I should fetch again :-)

--=20
balbi

--wAI/bQb0EMvlZCHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRy+P4AAoJEIaOsuA1yqREeOwP/0bSlFg87OjCrpnOfJvLr0Ua
VVDgNPZQMbr4oSi5WVkkZljGTVnqIEm+/4XcFvXU7fPZdDvKbErIzbHdg8sg+GMC
d3iPVaoY08lkY/iNXZgNJ9SqJZYu4qLigaUlo6jdH0tz0YTPz1MvsFDSJf9pXdUs
ULj2tCsOAO+zh4pwC6QexSpM7IKRqC8peNcogABAQV21ccz6QfBgF/y4bcwASctf
2QiNmieg/P5W8jH1uM1rMNXETlmYTlyYoMnTtiLpqvLkx9H01VUKtfkP2a0fWWfd
Lzgt5dxPKdZcrXZTfy2O/ApwxSSn3XQ7sjL2XXNkUWQLuWV8b2ZLr8d3i1eEug7L
e6KMkmpM/GAsw1vsWBoahJrw7idhFMgQdUVO8iP3riMXd2BnHgrL5WycfUsgDmkj
1ybGmYYsIO667I+1gGpKvZwtsYREMDy42gcgiaFSeCl/X+nP7UTvgBj8KW43MvX2
MeNDxIApI8/o9k6rjZCE/b1xWU1dDb8bjouMpsNK+OcOkjUxrIUBMqoQAy7xx6bc
0jw+eX+KZ/cjNujYay1B+oD7sOqQ4uqcx5tQzBzDC1d8HsXlv3qr44mTNWQbZEEJ
PRLv3quNBamYf2wfIIrhe/AgRM9tBwvGU2sLotVQBrOmlg32g7p640b1gWlCh7Hh
+AuM4b8Mgn3pCnccbdJj
=un8b
-----END PGP SIGNATURE-----

--wAI/bQb0EMvlZCHl--
