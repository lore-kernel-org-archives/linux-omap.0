From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] OMAP: DSS: add FEAT_DPI_USES_VDDS_DSI to
 omap3630_dss_feat_list
Date: Tue, 18 Dec 2012 07:27:25 +1100
Message-ID: <20121218072725.3f64d331@notabene.brown>
References: <20121216080803.618a3634@notabene.brown>
	<50CF0903.8010205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/V+gh=sXDyM=zMV5dpeDTiap"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46231 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678Ab2LQUlS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 15:41:18 -0500
In-Reply-To: <50CF0903.8010205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org

--Sig_/V+gh=sXDyM=zMV5dpeDTiap
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Dec 2012 13:58:59 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> On 2012-12-15 23:08, NeilBrown wrote:
> >=20
> > commit 195e672a76056478cc79f5c48343164c9237852e
> >    OMAPDSS: DPI: Remove cpu_is_xxxx checks
> >=20
> > made the mistake of assuming that cpu_is_omap34xx() is exclusive of
> > other cpu_is_* predicates whereas it includes cpu_is_omap3630().
> >=20
> > So on an omap3630, code that was previously enabled by
> >   if (cpu_is_omap34xx())
> > is now disabled as
> >   dss_has_feature(FEAT_DPI_USES_VDDS_DSI)
> > fails.
> >=20
> > So add FEAT_DPI_USES_VDDS_DSI to omap3630_dss_feat_list.
> >=20
> > Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> >=20
> > diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
> > index acbc1e1..aaf3c3f 100644
> > --- a/drivers/video/omap2/dss/dss_features.c
> > +++ b/drivers/video/omap2/dss/dss_features.c
> > @@ -546,6 +546,7 @@ static const enum dss_feat_id omap3630_dss_feat_lis=
t[] =3D {
> >  	FEAT_ALPHA_FIXED_ZORDER,
> >  	FEAT_FIFO_MERGE,
> >  	FEAT_OMAP3_DSI_FIFO_BUG,
> > +	FEAT_DPI_USES_VDDS_DSI,
> >  };
> > =20
> >  static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] =3D {
> >=20
>=20
> Thanks, looks correct. Did you encounter a bug related to this, or just
> happened to notice?
>=20

When I tried 3.7 on my gta04 phone the display had a slightly greenish (or
maybe yellowish) tinge, particularly when viewed at an angle.
I at first thought it might be related to the changes in the panel
configuration (I have an out-of-tree panel driver) but making changes there
had no effect.
So I bit the bullet and did a git-bisect, and that is how I found that
problem.

NeilBrown

--Sig_/V+gh=sXDyM=zMV5dpeDTiap
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUM+APDnsnt1WYoG5AQJhlw//fBDL/NnqF6UvNvVyHP/6WcuQQjjGJh58
ceRbWcew+lXbO/tcJj35qR8CpR+TLInh1FxzvW9aRdyXpBw0SqIveiQ7MXJkXaSl
PKIn5dl2zw6x2UVF7blJHgo4dGfulkN7f8Vt5whmIkKOU1pj9pdfSw7p0u6VxfHF
iS6XWY/zqGEnz3B21UbUOVL20BBlNZrFYhBev9ITJvXKgULGgcGylBnc58JH7TN1
uIBgO31Z1IgoynOyuKFPcHyTLtoLFTnLIRTOVsPGBbzuUHONKGSIEJNDAY6GZU9J
Ej/IW24ce/iDIMuRfE6EeBInPqY1EIfDint8nxpHbGOjWvJY9X3IJLve9p+7OJhK
VjknTk8Ej82aYH8RiUSnKses+qsVhwdIePoRvtCopY0pfRmQl/87pWCIzA2d1vtC
61PjN/p4u6W26RiflR98M96Dx+GjEVSQU7J9FUGt4L8KtHXOO2oqVlUBF8VAWYhc
T2IGzjUHhIpcUP5365SHcBwxII61vMO1mLG+e9ZuR9IjmShx5thIG8aRYxrkLn7B
4f+yXGHYbZFBW8MjnI/v++GCpsSUjWOnGrAsoQzconUigm2MjUSfs9cSgbk6rCW0
r9UfAPInWELrZOqkP608p9Bl3woJmq3SgDB9mR/WknnCK0Cl0MF2vSI884umfgmB
7ADYGgvA2a0=
=1Cyq
-----END PGP SIGNATURE-----

--Sig_/V+gh=sXDyM=zMV5dpeDTiap--
