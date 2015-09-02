From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Wed, 2 Sep 2015 12:15:38 +0100
Message-ID: <20150902111538.GB5313@sirena.org.uk>
References: <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
 <20150825135044.GJ27431@sirena.org.uk>
 <55E42FF7.9010706@ti.com>
 <20150831145249.GO12027@sirena.org.uk>
 <55E5727E.1040103@ti.com>
 <20150901141720.GD4215@atomide.com>
 <20150901183657.GX5313@sirena.org.uk>
 <20150901185605.GP4215@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZaJdQhC3kSAeqBrs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150901185605.GP4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Lee Jones <lee.jones@linar>, Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--ZaJdQhC3kSAeqBrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 11:56:06AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [150901 11:40]:

> > That'd work.  The other thing I was thinking we could do is to get
> > syscon to treat any excessively large address that gets passed in that
> > looks like an absolute address appropriately.

> Hmm wouldn't that get messy for 64-bit :) How about something
> like:

Meh, it'd probably be fine - I was thinking falling back to trying to
substract the base address if the passed address was out of bounds.
It's not super elegant though, something that directly does the right
thing would be better.

> unsigned long syscon_regmap_get_offset(struct regmap *syscon,
> 					void __iomem *base)

> Not sure if that's something that some drivers would start to
> misuse with read/writel though.. Presumably not if the driver
> already is using syscon.

It should be really easy to spot abuse I'd hope.

--ZaJdQhC3kSAeqBrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5tpZAAoJECTWi3JdVIfQ+LkIAITUJxYDkfyUcqgqKdf3AHAy
o0ah74MFSCnnIpm338iV+8UMHMztGUQ3co+DwnveCyKyc0A8+sQnJo+dDcvVsxtE
2AFpAwLwhrY2mId4vT6/8XUiknuchA8UvdrTvCd0QBdnhwN5eUiKI1Jmf40/pzv5
bWWKi89vYmCzEicVEPPJjuV7+CH4ICyD63LJh7OO8Wk1pWm8gvZpjTbdvbz/NPzs
+57VcpF/wcY/9D6E4iNT+1xWY7EunZpjpekz5Zc7GTUd5P1vHQ3fUpFqlqbdHA/+
GcEpUNE7gXosBpQaZgdylJhjomgQouomMj6EsfC0KnjEWJAXResPimAUX3UHoP4=
=1Zko
-----END PGP SIGNATURE-----

--ZaJdQhC3kSAeqBrs--
