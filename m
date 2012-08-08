From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Wed, 08 Aug 2012 16:25:38 +0300
Message-ID: <1344432338.4932.96.camel@deskari>
References: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	 <1344429360.4932.58.camel@deskari>
	 <CAF0AtAv3uuS_GDuYEk4mpUKieZqqBnLUpRcLBx0M4zjbsSq2Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LGjvew1ct4NOrF9Gd2Az"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:54764 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758482Ab2HHNZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 09:25:56 -0400
Received: by lbao2 with SMTP id o2so416561lba.10
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 06:25:40 -0700 (PDT)
In-Reply-To: <CAF0AtAv3uuS_GDuYEk4mpUKieZqqBnLUpRcLBx0M4zjbsSq2Nw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-LGjvew1ct4NOrF9Gd2Az
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 18:31 +0530, Mahapatra, Chandrabhanu wrote:

> Yes, this sounds good, but I was just following general order of
> structure and function declarations, structures initializations
> followed by functions.

Yep, it's a good rule. But there are exceptions when we'll get bloated
code by following the rule =3D).

> > During runtime we only require one of these, others can be discarded.
> > This can be accomplished with the combination of "__initdata" for these=
,
> > and "__init" for dispc_init_features().
> >
>=20
> The same also applies for all structures in dss_features.c. Just a
> thought that __init and __initdata should have also been used there.

I agree. We should also see what things we can move from dss_features.c
into dss.c, dispc.c, etc. Some things in dss_features are quite global,
but some are really used only in one place in one file.

Although this also makes me wonder, is it better to have all the
hardware version information for all DSS modules in one place, as we
tried with dss_features, or is it better to have the HW information in
the respective DSS submodule, as you're doing with this patch.

Both have benefits. Even though with the latter method there's no one
place to look for DSS HW feature differences, I think it'll still give
us cleaner code. So let's continue on this track.

 Tomi


--=-LGjvew1ct4NOrF9Gd2Az
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQImjSAAoJEPo9qoy8lh71vxIP/3D6oPtB9EiGHux35Vt/hLGT
w8MHJdD3pzQ5N+rKCzICJVCfIJ/i0djsqbOlRo2xru4opRYdqmDWXoyg7S/zFztB
4R6zd2fE0HfKmJMTNpvYlxZu5B0QFeIxuCol2oGx8RR6kgD2TSXX/iGhlAdFsvzA
D96q8gp2JdynAp3xdnYU95ztzS3gEX7RRUllOCV/74Z5I/0PJSSH6Lboz7eLJZrd
NYMXK1q30HUVUw3OgS9WHD5U7vjQePNbh+m+M7UdMboY15a7w3JPg/yAVavUF/AI
9Nf5og9pZ4zqr57s3DXGL5l1Vm0WZ4MmKmVhC3jmtT3X8QMU6+B+IBqaLPtTYjE0
iftF7n6HIQU9slKQte5LG4u6uWbVNPt9iSdDpX24lQR+ADmUlD+nZYGkgvxa3Dr9
KY5F1X5xpVul0M+/SMZzT/gj6i44c2MH6DMYgvPgLBkx03wTT1aVtxXq4v38RfqC
zNuXuDL4+dKPBFbgGjYMwMc3x+S0mY+vdaVQOusq1buFp05rWfLIiUKre/EwUAU+
TLJF8Doj/03AtUXwjIsUe0cfBbDbXHjyy4FVIq9UVSiS9frd0vZ3/1zPP/HVuyIi
z030SkINEssjzpU8BCKkbKgCoSdIPkyUXfKWWPWTuMHOD8M7PWmziAB4dldipOfS
sXmE9B1nC08uGSUIght8
=tbsF
-----END PGP SIGNATURE-----

--=-LGjvew1ct4NOrF9Gd2Az--

