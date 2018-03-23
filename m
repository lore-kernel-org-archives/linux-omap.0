From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression with arm in next with stack protector
Date: Sat, 24 Mar 2018 09:31:37 +1100
Message-ID: <20180324093137.1658f740@canb.auug.org.au>
References: <20180323181452.GJ5799@atomide.com>
        <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
        <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fdq6P8WKSg_Bb8C59muoHml"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>, Huacai Chen <chenhc@lemote.com>, Rich Felker <dalias@libc.org>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-omap@vger.kernel.org, James Hogan <james.hogan@mips.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/fdq6P8WKSg_Bb8C59muoHml
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 23 Mar 2018 12:15:30 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wro=
te:
>=20
> > On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote=
: =20
> > > Hi,
> > >
> > > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > > compressed boot phase") breaks booting on arm. =20
> >=20
> > Yes, almost all imx are broken in linux-next due to this commit:
> > https://kernelci.org/soc/imx/job/next/kernel/next-20180323/ =20
>=20
> Thanks, I dropped it and I expect Stephen will also do that.

OK, dropped.

--=20
Cheers,
Stephen Rothwell

--Sig_/fdq6P8WKSg_Bb8C59muoHml
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq1gEkACgkQAVBC80lX
0GztXwgAo+rsdKDZd907h4gTFvwoIkGgJSp8+g4M0PEZrGSKLBRxwYfFwSu7Ybsq
h1lSB4eeDbfV1cLYEbqoDFm7LO3y6HN3fKhamXO9cxfuau57/CVWwn6izglHPNdE
NNVRFPooyVeW2GmM0hkwLatS6mTrPkwHG0daRXUQWno2TgjEtSA/UOr7xFsNMVwc
oixHlBJddDNDcEo2Yqj001zj7g+4TCovcfh7OmzgJafkMWUIpYacnQvBvEU0t1eT
WyJFTqdJmd4OQOhf/NanIsGlult+6uChePYeA3NyBk9PJ6f1gCYgsXWRVhJcZ91Q
FCRHkbKLKDdQgepMTDUcXOPLi8NRIg==
=eCUk
-----END PGP SIGNATURE-----

--Sig_/fdq6P8WKSg_Bb8C59muoHml--
