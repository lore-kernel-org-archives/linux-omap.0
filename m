From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR
 with dev_warn()
Date: Sat, 9 Feb 2013 22:58:31 +0200
Message-ID: <20130209205831.GB14543@arwen.pp.htv.fi>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165532.GB13338@arwen.pp.htv.fi>
 <20130209180530.GC32349@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572Ab3BIU6h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Feb 2013 15:58:37 -0500
Content-Disposition: inline
In-Reply-To: <20130209180530.GC32349@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2013 at 03:05:31PM -0300, Ezequiel Garcia wrote:
> On Sat, Feb 09, 2013 at 06:55:32PM +0200, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Sat, Feb 09, 2013 at 01:38:16PM -0300, Ezequiel Garcia wrote:
> > > Since the condition is not an error but a warning, replace
> > > printk KERN_ERR with dev_warn.
> > >=20
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2=
/gpmc-onenand.c
> > > index 4771945..fd6e35b 100644
> > > --- a/arch/arm/mach-omap2/gpmc-onenand.c
> > > +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > > @@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_platfo=
rm_data *_onenand_data)
> > > =20
> > >  	if (cpu_is_omap24xx() &&
> > >  			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
> > > -		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
> > > +		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");
> >=20
> > it would seem more natural to use dev_err() instead.
> >=20
>=20
> Are you sure? The error seems more a warning to me,
> although I guess it's arguable.
>=20
> Let me know and I'll fix it in v2.

my bad, should've read the code more carefuly. Indeed it looks more like
a warning as we continue to try to use the IP. My bad.

--=20
balbi

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFrh3AAoJEIaOsuA1yqREjiYP/Rkj6MQBVPT7LtaeusIlDv6X
wZuFpy8LyK/Iyx6W9YyUu1AT+9omaS007PfF07CkAF33xaYWr30CP/E9OCBLnr9U
QvGNGFAwPwLcy9f+wZsABFah/pH6FVETG/+3MtXqrOXLIv9z8RbYIrRfz5EvYZB1
dCQXOPEbSwKyzrer7yfc+j1en6cUAkpc7YQFAnYBNF52wEetP1624mdU5X/hGwQu
nZYCh4LrDltzgTbEf8Jp3p/1h5tYRKCTqN6lyZU9oRt46g/BxT9n9DqQa4Ftcd5F
VjWXk9an9d9SnGZIZ1642lLmwIFz7SUY7EAjJWlv1I2xvNZHetNvcuNlzQAXiZ3n
CQjFkbONhcQCzkhVSBB5LZGXFvWPWEdu78iHt2VGQBh1wrO8Ritwl++pNwRl4dbE
uwggBBzdltMkqgWMspQWq2vCsauI1Xr6sSHSkizFx93zFjFAAVL5kMjtGpTtl5Fg
W46U9EWsukuw3zbCsYAa33jr/N4w/ZrMe9jqY6zppqAyZ6epS/nwlCHEZSkSTLUZ
Z9AKSNCTOavFL95dGKBDaPm0CIrQwtfP9am1TkoiJCxe7K9wFkCBu+PNAhMkXA3/
TXttdxMpJx1K7DbCXFVHevs0mmnB0tJiJuGGtq3Ct60FdT8S++n07WkkSANh4sak
nsZpcTl34+g6cjQ7XpVy
=mvnj
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
