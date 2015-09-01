From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Tue, 1 Sep 2015 19:36:57 +0100
Message-ID: <20150901183657.GX5313@sirena.org.uk>
References: <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
 <20150825135044.GJ27431@sirena.org.uk>
 <55E42FF7.9010706@ti.com>
 <20150831145249.GO12027@sirena.org.uk>
 <55E5727E.1040103@ti.com>
 <20150901141720.GD4215@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hblleJHDxiLJUoyx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150901141720.GD4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Lee Jones <lee.jones@linar>, Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--hblleJHDxiLJUoyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 07:17:21AM -0700, Tony Lindgren wrote:

> Why don't you just make reg unused for pbias_regulator since
> we already use regmap for this driver?

> Then in the pbias driver just define the register offset from
> the syscon base? You may need to set it based on the compatible
> value, but it's not like it's going to change for SoC.

> If we eventually add some API to calculate reg base offset
> from the syscon base it's easy to update the driver to use
> that.

That'd work.  The other thing I was thinking we could do is to get
syscon to treat any excessively large address that gets passed in that
looks like an absolute address appropriately.

--hblleJHDxiLJUoyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5fBIAAoJECTWi3JdVIfQW4UH/RhCzd4OT8Xig1VqgmP2je9o
4lFCXMxUXsKJ3uyCktdsYKxVdObpBXtlOE5tcjQKi7YcCymt5lhOTQML6cfbS7F7
TadyxanQodTMxPHOjdSoMIm5KI86N5GIRwUTV0WrwAjHUnk2PKAKEF+iJjz+9YnQ
7jlLdC01jmrNpP606Y8Pzj4MZ7L+SedGOgLXf3Sz3FymmI7Vgzl9JYOAP1ryRwg8
eSV1KttvbhcImLORjzatMsTq8ksgY0Vy8MRP16pMTM174QFPD+MggY0gEezqwIEe
eBM1Hq5oiakAQvV4aAYQVcTMGvHx+pYh7VFh1QiiWBfk4sXD50D+p2qotvIhR9U=
=W8rh
-----END PGP SIGNATURE-----

--hblleJHDxiLJUoyx--
