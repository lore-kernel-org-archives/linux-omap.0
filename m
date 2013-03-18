From: Tom Rini <trini@ti.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 14:29:54 -0400
Message-ID: <20130318182954.GB25919@bill-the-cat>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
 <20130318163648.GA3722@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:59838 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab3CRSaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 14:30:00 -0400
Content-Disposition: inline
In-Reply-To: <20130318163648.GA3722@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Olof Johansson <olof@lixom.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2013 at 05:36:53PM +0100, Pavel Machek wrote:
> On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> > On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > > mkuboot.sh?
> >=20
> > I know this was discussed quite extensively yesterday, but here is my t=
ake on
> > it:
> >=20
> > Given the recent complications from multiplatform, we really saw a stro=
ng
> > reason to _not_ do the final boot wrapping in the kernel build system.
> > Produce the zImage and the DTB files, and have a surrounding script that
> > bundles the two in a format that your particular device needs.
> >=20
> > Most distros have scripts to handle the "make install" step of a kernel=
 build.
> > That's where this belongs, not in the actual build step.
>=20
> Not sure I agree here:

Lets try and stop this again here.  I think perhaps the KVM tool example
is instructive here.  For the various reasons that close association
with the kernel can be helpful for things (the exposure and ease of
being found), it would be nice if the tooling to expand single kernel
image into single "bootable" image was with the kernel.  But it's not a
requirement.  And it's not even necessarily the best for the tooling
either.  So, lets drop the idea of getting this into the kernel and if
people really do wish to extend FIT such that we can easily spit out a
FIT image that works on omap* and tegra* or what have you, and add a FIT
parser to GRUB, great, get to work.  No need to be tied to the kernel
for this.

--=20
Tom

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRR10iAAoJENk4IS6UOR1Woh4QAKWJTqt2K9NENLkN1rqPFIiJ
Y1efwngxhT3Ua2uXCyHM1+eZ8xxhFTK7fJvVDkG2J61yaJMhoOhCP/trQq5Jx0AU
E9vvvSkhhs2J5fCoQ8wqF/WedEIst5EDZJxymA7Ae+BElQzHbi39FLuu6vUJ+kl7
0YGgjiTEXefL0vdKtNS+rcp6inp4dx4kI/MAsF1qFBnU+q7xCVFIfmPDE9kksJtt
EVDJf8kfl0veZSurEsGHOW72wsEDZuiD62iuvO/TyiZ5Ud9KP8BrExo10mNlybIU
sxaq6l7t93fYbUhz243tZrxAjRL+eiNzjPNuNzWtpJBXP5T8v4Uw4sWnVYBwdLPc
M5mTSjbdlIsPrhDSnTHev7baxvaFB3ChNrpoKTv8DRc63Bgx9Fd+eQe7e/tqblRB
C1t8pqFdPTxtgXmuldke6TTi+uBaq22I4LS1AR95zDT4j2EoetFlK45wAaB0CKUa
uLhW5Rf47Rm2JAanmRds0XQQCK3+lAcDBNdohkHz6wHP1qVo3Qv4gp8w5opqkTlu
sH1F/NrtuK5vkGRNjzE416XEyvgmUwUkC8m/u/8pZCSFmMdN8YSBWaea80RW9RNm
hraWF6N2EoXuik85sJr898qdW5Ls8KTY8wGX8qHx9NhFNhTtu5cEf+lzqGLDH+l0
IJkJAbcIFur6+HIf+/uZ
=Jpl1
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
