From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 08 May 2012 10:16:17 +0300
Message-ID: <1336461377.1896.23.camel@lappyti>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	  <1336028864-13895-1-git-send-email-archit@ti.com>
	  <1336028864-13895-5-git-send-email-archit@ti.com>
	 <1336403017.3522.2.camel@lappyti> <4FA8A927.9080705@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YHv8zlYbH/wJtnhGtsw/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36756 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753964Ab2EHHQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 03:16:23 -0400
Received: by lagu2 with SMTP id u2so5493684lag.35
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 00:16:20 -0700 (PDT)
In-Reply-To: <4FA8A927.9080705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-YHv8zlYbH/wJtnhGtsw/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 10:33 +0530, Archit Taneja wrote:
> On Monday 07 May 2012 08:33 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
> >> In order to check the validity of overlay and manager info, there was =
a need to
> >> use the omap_dss_device struct to get the panel resolution. The manage=
r's
> >> private data in APPLY now contains the manager timings. Hence, we don'=
t need to
> >> rely on the display resolution any more.
> >>
> >> Create a function dss_mgr_get_timings() which returns the timings in m=
anager's
> >> private data. Remove the need of passing omap_dss_device structs in th=
e
> >> functions which check for overlay and managers.
> >>
> >> Have some initial values for manager timings in apply_init(), these wo=
uld ensure
> >> that manager checks don't fail if an interface driver or a panel drive=
r hasn't
> >> set the manager timings yet.
> >>
> >> Signed-off-by: Archit Taneja<archit@ti.com>
> >
> >> +struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_ma=
nager *mgr)
> >> +{
> >> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> >> +
> >> +	return&mp->timings;
> >> +}
> >
> > This one returns a pointer into apply.c's internal data structures. The
> > safest way would be to return a copy, but as it's an omapdss internal
> > function, I think it's enough to return a pointer to a const struct.
>=20
> Okay I'll fix that, I was a bit concerned about the locking here, I use=
=20
> this function in the later series to remove some dssdev references in=20
> dispc.c. I traced the paths and saw that in all cases this function=20
> would be protected by the data_lock spinlock, but not the apply_lock=20
> mutex in all cases. Any thoughts on this?

Hmm, you're right, locking here gets a bit confusing. set_timings has
locks, so logically get_timings should also. But I guess all the uses of
get_timings happens via apply.c, and apply.c already holds the
data_lock, as you said?

Making the get_timings function public (inside omapdss) is a bit nasty,
as it's quite easy to call it without having the appropriate locks. And
actually there's no way to acquire the locks outside apply.c

I'm not sure if it applies here, but as a general strategy, I suggest
doing things in apply.c that require data from apply.c's internal data.
When that's not possible, apply.c should call the functions outside
apply.c, and pass the internal data as parameters (like calls to dispc).

In your case, I for example see dss_mgr_check() calling
dss_mgr_get_timings(). It would be quite easy to pass the timings to
dss_mgr_check() from apply.c, thus removing the need to call the
function. And, as you see, dss_mgr_check() already has a bunch of
parameters, and the idea is the same with those: give the params, so
that dss_mgr_check() doesn't need to ask for them.

 Tomi


--=-YHv8zlYbH/wJtnhGtsw/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqMhBAAoJEPo9qoy8lh71XRYP/ip6Zes5z90VRhVl/d2gkV1m
1xavocBZH2XpRiHocpQL/hm8fPutP0RXqKvY1TniCba9i4Ksz3AfEDvDD68L6JvB
SABN9IuPjMKWT9TfOkxs91J794RgrIP5r6DCt4xnrOounhjjjQFl3U6KgZ7hZR3Q
qPS/dMQK7/oRi78/FNCwB54hoJY0+azVtM2ljYgFPX54ZutcIlWqSO1lJq5XRwaH
5MP6+gWVlR9zobSNPlrgW2fEzYwg9S02gGby/Utbs9v/wFUorTbgXubSp1M0fAHF
VvLX/EzC2QFJH8CtSHPCCULudXjEs5IATO7sjfLDaMAL/DusB1RNDbDP2ZArDAFr
Bo4QdU7YPc7N3ZP9Sa6QRf6wmrB+pEJDBRATe0oJA+4V5Oz/2fqII6ZOcFfoOK7X
ueUnvuyb8P6kGUVVSU5ZJ+b3d2O5faYPFql8IXYZpnzyqrIcz+tNKI4Zg2FeDTu4
U8aDs10zyfz4rQvBgZCc/YDJYzwcLAuZezZ7xIN/YMdlCTVk5U+WBPMYVgOAMwnz
at6hkKK7eMT07QsOT0XML0VDboe4GjjSwesc/vofXsnvdSJ+jqYoxbXopPo+BfrY
U5PzXjXln3BkPiP6QzoMUnWi1FLCf+wzMGwuZbneuz5Q/7C3dRESSW1I6vmrsHAL
NL7Bm7tMN3tmUe8+a2/5
=6QxM
-----END PGP SIGNATURE-----

--=-YHv8zlYbH/wJtnhGtsw/--

