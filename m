From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in next-20170901
Date: Fri, 15 Sep 2017 15:18:18 +0200
Message-ID: <20170915131817.GA19486@amd>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170907161650.GP5024@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > After commit 9caf25f996e8, user for CMA memory should use to check
> > PageHighmem in order to get proper virtual address of the page. If
> > someone doesn't use it, it is possible to use wrong virtual address
> > and it then causes the use of wrong physical address.
> > CONFIG_DEBUG_VIRTUAL would catch this case.
>=20
> OK, no extra output of current next with CONFIG_DEBUG_VIRTUAL=3Dy.
> Booting of n900 hangs with just the same error:
>=20
> save_secure_sram() returns 0000ff02
>=20
> > If it doesn't help, is there a way to test n900 configuration in QEMU?
>=20
> I doubt that QEMU n900 boots in secure mode but instead shows
> the SoC as general purpose SoC. If so, you'd have to patch the
> omap3_save_secure_ram_context() to attempt to save secure RAM
> context in all cases. If that works then debugging with any
> omap3 board like beagleboard in QEMU should work.

Okay, linux-next from today still does not boot on n900. Is it
something new, or was this still not fixed in -next?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm70xkACgkQMOfwapXb+vL0aQCgjeazCyA5h4yepRckRLzWcgNL
1gUAoIivxlb5O+Na4698mGbql2gokUAn
=1a+O
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
