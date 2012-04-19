From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a
 manager_info parameter
Date: Thu, 19 Apr 2012 09:37:26 +0300
Message-ID: <1334817446.1521.57.camel@lappy>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1334561027-28569-5-git-send-email-archit@ti.com>
	 <1334761105.2027.67.camel@deskari>  <4F8FAD01.3090406@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-k9JuWpFiTh2xusQ46gZe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:47582 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab2DSGhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 02:37:33 -0400
Received: by lbbgm6 with SMTP id gm6so2128636lbb.41
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 23:37:30 -0700 (PDT)
In-Reply-To: <4F8FAD01.3090406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-k9JuWpFiTh2xusQ46gZe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-19 at 11:43 +0530, Archit Taneja wrote:
> On Wednesday 18 April 2012 08:28 PM, Tomi Valkeinen wrote:
> > On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
> >> DISPC manager size and DISPC manager blanking parameters(for LCD manag=
ers)
> >> follow the shadow register programming model. Currently, they are prog=
rammed
> >> directly by the interface drivers.
> >>
> >> Make timings(omap_video_timing struct) an overlay_manager_info member,=
 they are
> >> now programmed via the apply mechanism used for programming shadow reg=
isters.
> >>
> >> The interface driver now call the function dss_mgr_set_timings() which=
 applies
> >> the new timing parameters, rather than directly writing to DISPC regis=
ters.
> >
> > I don't think that works correctly. The omap_overlay_manager_info is
> > supposed to be set with set_manager_info() by the user of omapdss, to
> > configure the manager's features. The timings are not supposed to be se=
t
> > via that mechanism, but with dssdev->set_timings().
> >
> > This is similar to the info and extra_info for overlay. info has stuff
> > that omapdss doesn't change, it just uses what the user gives.
> > extra_info, on the other hand, has omapdss private stuff that the user
> > does not see. Timings are clearly private stuff in this sense, because
> > they are set via dssdev->set_timings().
> >
> > One reason for this is the programming model we use. If the user of
> > omapdss does get_info() for two overlays, changes the infos, and then
> > calls set_info() for both overlays and finally apply() for the manager,
> > we don't do any locking there because omapdss presumes the info is
> > handled by one user. If, say, the dpi.c would change the info and call
> > apply at the same time, the configuration could go badly wrong.
>=20
> I think I get your point. So even though get_info() and set_info() fn's=
=20
> are spinlock protected, if there are 2 users setting the info, it=20
> doesn't mean that the info they finally written is correct. Is this=20
> example the same thing as what you mean ? :
>=20
> In order of time:
>=20
> -user 1 gets an overlay's info
>=20
> -user 2 gets an overlay's info
>=20
> -user 1 modifies and sets overlay info
>=20
> -user 2 sets overlay info without the knowledge of what user 1 did.
>=20
> So even though we ensure these events happen sequentially, we don't=20
> protect the info across multiple users.

Yes. The spinlocks ensure that the info is "whole", so we don't get a
few fields from user1 and a few fields from user2. But they don't
protect us from the case you described above.

For that we would need a "dss lock" that the user would acquire before
using get_info and set_info. But I don't want to go to that direction,
because we really only support one user anyway.

The problem in this particular case is that omapdss itself becomes
another user if it uses get_info & set_info. And that can be easily
avoided by splitting the configuration into public (the "info") and
internal ("extra_info"). The users of omapdss never touch the
extra_info, and omapdss never touches the info.

 Tomi


--=-k9JuWpFiTh2xusQ46gZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj7KmAAoJEPo9qoy8lh71yA4P/RswDF3uyYJuJPiW7KEddwEx
0n2Yyl9MWzrqbAZawpsmZhfhmShXvm2OU9Y38sBuXHh2UQeE49ae2obyD8+7ZGlC
U+WYfpq8EyfMYT/KZOri+9Cb6wXJrI2FYv5Zy8kd0QB7qJix6gHX9aMkB/njRQZ2
fUOSD8erXbqj1rXXjvqHkFjKCqZGBHLWnG0dS+JofvKTh9kMDL5CfKGQijYWTnpU
hAap6cqfqd+Ju/+iK0xIjrSUFAvDcMCp4tdEOQKaPfemw0/sLRvoBaQGlgjuWmjN
sc1INoCQ1cbRskSmql4p+3nJ51pfj1Gr/K6V1Afl+71CB3WOGa3bsrDgY+enb6+Q
pFJ4L4BjZTIpZIq4hZoT6Zl8SySmJTr7ycVId/sIMk16cmRGtE2F40N2v/Zo0U/8
/JVq6+8ZJV5QfiKBDg8b1QTfCc+CRT7og8vVSnGE7MiEQaflko6rdGSrBdpnS54a
KcAX/Dwc6UoM2rXOesevM28ZupTRHybUsUWU5VTVQB65mdgL6SGCjTDLwa1uUEHp
QYdUh1SLIq1lRoJ57gFIr7l9Yhjdj552VGeSIN0uQwX80rwCqTxbnU+89tnPXDsi
F+khr9JuhNK7cXnO37N+E+ZpzmV3mD4ZAd50o9GeS3YqNw1yWdLwlS9f8CV3i1Wy
mFx3ZL5k3q+AjFWrw27g
=YiIo
-----END PGP SIGNATURE-----

--=-k9JuWpFiTh2xusQ46gZe--

