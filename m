From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 2/3] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug
 function
Date: Fri, 28 Sep 2012 14:37:47 +0300
Message-ID: <1348832267.2437.25.camel@deskari>
References: <cover.1348636132.git.cmahapatra@ti.com>
	 <cover.1348826106.git.cmahapatra@ti.com>
	 <2fc91980de4af940ac59b26fd49da6498865db8b.1348826106.git.cmahapatra@ti.com>
	 <1348831358.2437.14.camel@deskari>
	 <CAF0AtAvfnnBzTgPtNBJhxXTp9dZfPQOnotNmCQ+Fz=tkHY65gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cgE1bBaT5XpZB7HwyT9h"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:48836 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753844Ab2I1Lhw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:37:52 -0400
Received: by lagh6 with SMTP id h6so993699lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 04:37:49 -0700 (PDT)
In-Reply-To: <CAF0AtAvfnnBzTgPtNBJhxXTp9dZfPQOnotNmCQ+Fz=tkHY65gA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-cgE1bBaT5XpZB7HwyT9h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-28 at 17:00 +0530, Mahapatra, Chandrabhanu wrote:

> > I think you could just do:
> >
> > #ifdef DSS_SUBSYS_NAME
> > #ifdef pr_fmt
> > #undef pr_fmt
> > #endif
> > #define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
> > #endif
> >
> > For the case where there's no DSS_SUBSYS_NAME, there's no need to undef
> > pr_fmt, only to redefine it again back to the original.
> >
> >  Tomi
> >
>=20
> Ok. But I thought it could be more clearer if the definition of pr_fmt
> is more clearer in both the cases, when DSS_SUBSYS_NAME is defined and
> when not.

Ok, then it's fine for me.

 Tomi


--=-cgE1bBaT5XpZB7HwyT9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZYwLAAoJEPo9qoy8lh71mJsQAKkGW2VwwTxbL0E409ZhXulF
VJ+BZGyKltxufzCMAZd4/NqKPIsdxYY8oTRxQFqZXXYkzJRhMLFneKH8oyMzTE38
rDC2KkH1JN9B74i3p3HXG5IPeon0o21nQTIogLAc+dd2LdrRaaaNpxIPl9C9zWiK
8qaMK1drh5nJUwGba8e5HIM3j7i1xwIVjQjZsRZe8/mv9YQud9O5e4LEsNFV0Tcp
qlxaUYiSzIUuyVyyrde6ULMSEzjqxa312SNx8sODU5F7ATu2eNgeNoINSlFnh7km
5j2efkpcNT9H0d3b9mkvG/kiXiNsKWrBoeXZ9Zo32TCO84yySGXo3rfi+9UxE7NG
7HrAxzp4DTx7zx4wzZ4QHl4Iz9+NQR9VdCxhgr90qyHYXiFnnjSaOQrvhTH9ElLd
S9CcAVxwqD1GGYoeMOHSXJ1ZeJPqHAOVqPOQNpJzI10OSAF2PQ0i3lE9KcWVXmJm
k646JcTEhPpQ0thtAb497mfRzRZOfTkTxbtrE4/UYKahP/qtl3ORwCnmFWSGKDIJ
mhMYU1DBRw72FOZQN7qSzjYViKM/N24hN9D4zWHNtykHudG4ovkVR0gzkvEDj2Jy
iEhciIKjPd3VIcEHeMv9NNsbk/nkfX7IYeVGEpC0oFWeeYARS5gY1NAQDSiTfnEQ
xd8dNJDFryjjFNVhKMLg
=9cnm
-----END PGP SIGNATURE-----

--=-cgE1bBaT5XpZB7HwyT9h--

