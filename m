From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
Date: Thu, 6 Aug 2015 19:01:56 +0100
Message-ID: <20150806180156.GC20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h8+hH1OQkST14sOt"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1ZNIul-0007IF-Ev@optimist>
Sender: linux-next-owner@vger.kernel.org
To: Salva =?iso-8859-1?Q?Peir=F3?= <speirofr@gmail.com>, Joerg Roedel <jroedel@suse.de>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--h8+hH1OQkST14sOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig with:

> ../drivers/iommu/omap-iommu-debug.c:138:2: error: void value not ignored as it ought to be

caused by a combination of 1ba2f20ac (fs/seq_file: convert int
seq_vprint/seq_printf/etc... returns to void) which made seq_printf()
return void and e203db293863fa15 (iommu/omap: Fix debug_read_tlb() to
use seq_printf()) which has been in -next for a little while now.

--h8+hH1OQkST14sOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw6ETAAoJECTWi3JdVIfQVbAH/iQskElfQvE0GpmXkvFrquxu
JwIO3BLyf6aqDrHkqndjHzuUCvfEJJSa3Kvn0HIwWl+ze5b59LL57Jx/WCK2tC6G
T49xpKqU6YP91tIuasYgBdyFOE+tsgvTfIER5EaWZbBVly+xqb2WB1OzVzzb9iEV
V3lShrL/2F+y40nCgoK+06KQwXk8M05EkBCp2ADqdZ76ywDJm6jkH8vdXDgPXSb6
yCyJp5EaF+AuRi/DSVNXaAJDc0awth89paYRWCmdGvnZBDOBQUkwfz3A167GL9H9
o4cTKWDRi0jOcbQF/lJFXpcmq95j/J/velLyZ/on6jlGIHwCMaJkViVGBncgJV0=
=mSUr
-----END PGP SIGNATURE-----

--h8+hH1OQkST14sOt--
