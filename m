From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] arm, fbdev, omap2, LLVMLinux: Remove nested function
 from omap2 dss
Date: Sat, 27 Sep 2014 11:46:21 -0500
Message-ID: <20140927164554.GA7076@saruman>
References: <1411780253-4492-1-git-send-email-behanw@converseincode.com>
 <1411780253-4492-2-git-send-email-behanw@converseincode.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411780253-4492-2-git-send-email-behanw@converseincode.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Behan Webster <behanw@converseincode.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@ffwll.ch, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 06:10:52PM -0700, Behan Webster wrote:
> Replace the use of nested functions where a normal function will suffice.
>=20
> Nested functions are not liked by upstream kernel developers in general. =
Their
> use breaks the use of clang as a compiler, and doesn't make the code any
> better.
>=20
> This code now works for both gcc and clang.
>=20
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Arnd Bergmann <arnd@arndb.de>

another one that make sense :-) And probably also deserves
checkpatch/coccinelle/sparse.

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJundAAoJEIaOsuA1yqREUkkP/i7tBWnOQu7nUvgsJOIBPe8Y
Nh/Zh0I3ivxVtMVFEXDo6GIYSlENb0duDYHXHBkbSr2X67g8rEab1ROrEFepmghc
JIdbWDxrBa+QfB9rG+xM2Uq2sVKc1o+0QZi92va9fsdmolMUWXwshbefhYzp0+yT
03WAWVfn2JykPzO9cvH9Ux41LSpFDNOq0q2U9S8Td3O6dLLN5plDcgB4zHwy/Oal
doHPdKx6VaPG5h/9R88KjiDsrivUEAg2PEy4nN+wKIOfk4Shb8cI+jiKLZAkFP/2
8wBTnFySnl1D6iHiNUY5TflmxOF76eiZVoXOuG9qf2ALAjdeC2KV4mAOY/mIprdc
+JKXCMvr9mlDDG5/8Ap9e0pdheW8j4nEvQv0hDIeP4TCBvvHIFWEJRViLxQyBQav
+AgCBI3+h1XPkFhAjNygV9NWgOxzWyzEpFnp/8vxO0V0+6UMUpa3IA1yGJicPGiM
XBDo54ED5+958dvgs+sbjl4NbqCxRoE/BGsN1JuzIrxne9/9AWhWOORyxc7M81+s
XUGX5rgkYQFDfuzlXI6PdDU+ZpEshFqqTEjcgo1x3VVLQl0bWwo9ka70f++4uUHn
EB+8V9Kj9tcMKnPPSEtfzdEosS42PrIbnbPz11oWgAMrWhNFmv6SckHj1aoxAd6W
CCzYb7XhvOHi7Kig/r5v
=vNsF
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
