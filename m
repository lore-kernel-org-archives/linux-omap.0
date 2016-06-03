From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Fri, 3 Jun 2016 13:51:13 +0300
Message-ID: <57516121.1010201@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
 <575025DB.9020800@ti.com> <20160602152305.GE5995@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1127620223=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160602152305.GE5995@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, jsarha@ti.com, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, plagnioj@jcrosoft.com
List-Id: linux-omap@vger.kernel.org

--===============1127620223==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s2jFiFGqGm7AKUWT9wbxtmgFA6ndTs9jk"

--s2jFiFGqGm7AKUWT9wbxtmgFA6ndTs9jk
Content-Type: multipart/mixed; boundary="d0OcjsfXcGfsDMvO3HO29k1pRuO5hcMdH"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@TI.COM>
Cc: plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie,
 linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 jsarha@TI.COM, dri-devel@lists.freedesktop.org
Message-ID: <57516121.1010201@ti.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
 <575025DB.9020800@ti.com> <20160602152305.GE5995@atomide.com>
In-Reply-To: <20160602152305.GE5995@atomide.com>

--d0OcjsfXcGfsDMvO3HO29k1pRuO5hcMdH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/06/16 18:23, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [160602 05:28]:
>>
>> Tony, can you have a look at the arch/arm parts here and give your ack=

>> if they're fine? They should be quite small and display specific, so I=

>> don't see much chance for conflict there.
>=20
> Looks good to me, but these are going to conflict with the board-*.c
> removal patches. And those we want to have easily revertable in case
> of issues.
>=20
> Peter, can you do an immutable minimal branch of just the pdata
> changes affecting the board-*.c files? That way both Tomi and I
> can merge that in.

I wonder how minimal it can be, as I think most of the patches are
needed for pdata changes. Well, Peter can tell better.

What board changes do you expect for the next merge window? If it's just
"git rm boardfile.c", that should be an easy conflict to resolve, right?

 Tomi


--d0OcjsfXcGfsDMvO3HO29k1pRuO5hcMdH--

--s2jFiFGqGm7AKUWT9wbxtmgFA6ndTs9jk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXUWEhAAoJEPo9qoy8lh715f8P/3kMSuKE6v0cdYFqVSAQY17O
dc1bDBPiXlgkTAMqMhGysB0W/fWOCnrhV/aI4zF098ozuTByoDontVqIE7nU1wIj
kvBGDezZoCpR9id26WkgTeeG6agiSBqoShDsvYnpPEIA/2eDBwo+ObOceoP5Aat7
7cYiiS3wIL2iw7bzF855xowg+qFO3VwDUE6AHS4O8uOygCBnLT6Le17nPBswtq+k
CprbElS4tlhGGOK4SBaoA8Hm/ZDAa5Sc4gHDIR72L4wBdkXm11Dnpn/NxBSZXgCY
lyFfXyr9TAcL8Hyr0Tpnp2j0e5NMN8LWS+9U5obqAzRVHYUrm75xtxI2UYHmNxnM
l99NffjRWxc2rNr8sfwFFw742mlFq9pVxAYRreA6vGK648uuhPpVFJwAXllNJE3p
Th84rkSdkcPYWBHiuNsRAIs399mcoeFrxpoP+Uspalf6ztEfmzdIcXubSoEy39Vx
GiEc0L9+Ii379ER1+Fu0mHjLNuMDw8j4ETuDqBCLnsQtaiTcTFVFET+9vOb947Qw
cKM/lgwes2gGZ3XDCoR95iWmjIl2eBbjzNY6NpWN+VP7GtmIkdB0sepE8AXDpRGT
ikIXSk4GcuAH1HbnDQTnWunBXkOP1oOSgP5HC4mmMtsJbzKhj4j3YjKZjAFYaziA
Hb8pBILggREUGp/E7+uh
=s0P9
-----END PGP SIGNATURE-----

--s2jFiFGqGm7AKUWT9wbxtmgFA6ndTs9jk--

--===============1127620223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1127620223==--
