From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v6] phy: omap-usb2: move omap_usb.h from linux/usb/ to
 linux/phy/
Date: Fri, 7 Mar 2014 11:40:59 -0600
Message-ID: <20140307174059.GD23885@saruman.home>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
 <1394210888-1587-1-git-send-email-kishon@ti.com>
 <20140307165043.GC23885@saruman.home>
 <531A0436.3080201@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531A0436.3080201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2014 at 11:09:02PM +0530, Kishon Vijay Abraham I wrote:
> On Friday 07 March 2014 10:20 PM, Felipe Balbi wrote:
> >On Fri, Mar 07, 2014 at 10:18:08PM +0530, Kishon Vijay Abraham I wrote:
> >>No functional change. Moved omap_usb.h from linux/usb/ to linux/phy/.
> >>Also removed the unused members of struct omap_usb (after phy-omap-pipe3
> >>started using it's own header file)
> >
> >does this depend in any other patch ? I get the following when applying
> >*only* this patch on top of v3.14-rc5:
>=20
> yeah.. this is for linux-phy tree. I'll take this patch.

looks like you're doing two things at once (renaming the header and
removing some unnecessary fields). At least mention the second thing.

cheers

--=20
balbi

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTGgSrAAoJEIaOsuA1yqREVPMP/3o5PkLSY5Rwcm2erQiAiS6O
hctotsXxuMOFo6R8H6lPiDPStqDFvBMDP8fwL7p985LYxQabgYsA0bihL8n/gyc8
1pCgSGua6txQRVrg8BA9BTi3vOUWf8L6QiFs3zihkHEeHEWceBsmW+6+InmHp1nO
9TsSEsM4+PcCg71qkuQvnA8mkXBOC9kJDDEQeYyDauGDiMyb1aTk89Vms8tKRdGF
nf2WAkSEHsK13HpEM+bBFX1yOOk6guCC3NxakKn06O6ZXIaCs+G2K+YdmJP+RHNf
xNmMDA9kRyupvfdZ5FPV8h7KAigdLRx6xjUBJFK4IKwCK3Gq6l8YqluH2Y2vSOMw
lPr9Mi/6eB6vtpYGpgAxa4sOAhLtfH3f3aDl6MmXXKUyY7XHkmmmxm38fYoy+LT8
WX1CtV4oGFKoOnaILnch1hlmGsMcfJTHtAW2QZzud25B8oGV9Q0p/oNViMV4jv5M
YTZ4ZDlM6y6VK6D1FY+RAWLOUjsy3nVseylfO/2zs5jimwOnFal5t7EvNmLQfJGr
eey7Lljg5YWH7HS7ORGbGIjjYke49NbfW9In/lNXgGAMsZP8ml3MKfcQsnKnaR5R
gIrv6BChJSck7mAGjAi3nWzH3q9Ox+0YPuzQ6xJqU6CXQuP8u5SWJo0Cf1inVeln
pAgeSaem7OXhRCXaCx9r
=gwrD
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
