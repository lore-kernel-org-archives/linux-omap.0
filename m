From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a
 manager_info parameter
Date: Thu, 19 Apr 2012 14:37:32 +0300
Message-ID: <1334835452.1911.38.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1334561027-28569-5-git-send-email-archit@ti.com>
	 <1334761105.2027.67.camel@deskari>  <4F8FAD01.3090406@ti.com>
	 <1334817446.1521.57.camel@lappy>  <4F8FE42D.6030105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tbaADqEttnXDedWKu1SA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59664 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118Ab2DSLhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 07:37:40 -0400
Received: by lagw12 with SMTP id w12so6530734lag.20
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 04:37:37 -0700 (PDT)
In-Reply-To: <4F8FE42D.6030105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-tbaADqEttnXDedWKu1SA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-19 at 15:38 +0530, Archit Taneja wrote:
> On Thursday 19 April 2012 12:07 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-04-19 at 11:43 +0530, Archit Taneja wrote:
> >> On Wednesday 18 April 2012 08:28 PM, Tomi Valkeinen wrote:
> >>> On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
> >>>> DISPC manager size and DISPC manager blanking parameters(for LCD man=
agers)
> >>>> follow the shadow register programming model. Currently, they are pr=
ogrammed
> >>>> directly by the interface drivers.
> >>>>
> >>>> Make timings(omap_video_timing struct) an overlay_manager_info membe=
r, they are
> >>>> now programmed via the apply mechanism used for programming shadow r=
egisters.
> >>>>
> >>>> The interface driver now call the function dss_mgr_set_timings() whi=
ch applies
> >>>> the new timing parameters, rather than directly writing to DISPC reg=
isters.
> >>>
> >>> I don't think that works correctly. The omap_overlay_manager_info is
> >>> supposed to be set with set_manager_info() by the user of omapdss, to
> >>> configure the manager's features. The timings are not supposed to be =
set
> >>> via that mechanism, but with dssdev->set_timings().
> >>>
> >>> This is similar to the info and extra_info for overlay. info has stuf=
f
> >>> that omapdss doesn't change, it just uses what the user gives.
> >>> extra_info, on the other hand, has omapdss private stuff that the use=
r
> >>> does not see. Timings are clearly private stuff in this sense, becaus=
e
> >>> they are set via dssdev->set_timings().
> >>>
> >>> One reason for this is the programming model we use. If the user of
> >>> omapdss does get_info() for two overlays, changes the infos, and then
> >>> calls set_info() for both overlays and finally apply() for the manage=
r,
> >>> we don't do any locking there because omapdss presumes the info is
> >>> handled by one user. If, say, the dpi.c would change the info and cal=
l
> >>> apply at the same time, the configuration could go badly wrong.
> >>
> >> I think I get your point. So even though get_info() and set_info() fn'=
s
> >> are spinlock protected, if there are 2 users setting the info, it
> >> doesn't mean that the info they finally written is correct. Is this
> >> example the same thing as what you mean ? :
> >>
> >> In order of time:
> >>
> >> -user 1 gets an overlay's info
> >>
> >> -user 2 gets an overlay's info
> >>
> >> -user 1 modifies and sets overlay info
> >>
> >> -user 2 sets overlay info without the knowledge of what user 1 did.
> >>
> >> So even though we ensure these events happen sequentially, we don't
> >> protect the info across multiple users.
> >
> > Yes. The spinlocks ensure that the info is "whole", so we don't get a
> > few fields from user1 and a few fields from user2. But they don't
> > protect us from the case you described above.
> >
> > For that we would need a "dss lock" that the user would acquire before
> > using get_info and set_info. But I don't want to go to that direction,
> > because we really only support one user anyway.
> >
> > The problem in this particular case is that omapdss itself becomes
> > another user if it uses get_info&  set_info. And that can be easily
> > avoided by splitting the configuration into public (the "info") and
> > internal ("extra_info"). The users of omapdss never touch the
> > extra_info, and omapdss never touches the info.
>=20
> omapdss touches info via sysfs, so if we use sysfs(in a fast way, using=
=20
> a it in scripts, for example) while fb uses DSS2, then we might hit this=
=20
> issue.

The sysfs calls come from the user, so in that sense it's not omapdss
that is doing the change.

But it's true that with sysfs we may have two users for omapdss, for
example the scripts using sysfs and omapfb. Hopefully we can deprecate
the sysfs files at some point...

 Tomi


--=-tbaADqEttnXDedWKu1SA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj/j8AAoJEPo9qoy8lh71+FEP/1siePf6viHqfYrx3AxThgyH
vV6X+/n7nJY7GLclPvucwyGg5fbVvhSbNZZaZIMEKbZTu+qpVRjV+MDAypa/wp1T
6xYgXr0n+pE/zaJJt53AHqzfhXFOuPjlxM/dPuJqntY7jhKNGwecLhZ+BvD5Thjo
SWbKVXvZBIIWMOGTfUaSikw6nFVcsiSUfcxoeXa+LP1ctaIuUCz8SPpbLwhqFKbW
qq+fMREFqDAvRmD3dPrZdRfA4EaTJOZhOnzlWpvpx3m5GvxwliTrMW9qZhRK/62F
VNUjBbo1qIlBVEXObsixbdD3r+qDLqolzOGq7/GN5rN96b8W7Lzp08g1LACALh66
QMHp56Vi567hgAKiIY85CwLKG5JxB3knV2VOQuWqqem68K29Zw2767889bwSikUs
QZVJ7kVzaNxTP0twxonMXcsirw77rth+K6pzmdASj3CpyB9d9WH/kwDdxcKiCaQC
vnv44+5haotUBTI30fqImvCoKXhk6dcmX5mBASlwycPbO/DlZwU31nePFl2SwPAo
2SCxrQt6On+P2/KE9N+kf6X72aGAcd/lEG6mr5H2rVJ1Xg6xEmNaGokwLu4Wg+lO
6okHulSt05Dc+jOyEW9BmGDhwq45Cz6DkNLc2zKOTLEz0jUh9spsstNqwFdsOflf
pRN1C45Nxzn6cHr4G+Pm
=+YSM
-----END PGP SIGNATURE-----

--=-tbaADqEttnXDedWKu1SA--

