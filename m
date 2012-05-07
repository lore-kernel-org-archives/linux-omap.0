From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Mon, 07 May 2012 18:03:37 +0300
Message-ID: <1336403017.3522.2.camel@lappyti>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1336028864-13895-1-git-send-email-archit@ti.com>
	 <1336028864-13895-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-dDeyyuVgsz9g+rcevH54"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:57357 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757145Ab2EGPDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 11:03:49 -0400
Received: by lban1 with SMTP id n1so3175058lba.24
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 08:03:45 -0700 (PDT)
In-Reply-To: <1336028864-13895-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-dDeyyuVgsz9g+rcevH54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-03 at 12:37 +0530, Archit Taneja wrote:
> In order to check the validity of overlay and manager info, there was a n=
eed to
> use the omap_dss_device struct to get the panel resolution. The manager's
> private data in APPLY now contains the manager timings. Hence, we don't n=
eed to
> rely on the display resolution any more.
>=20
> Create a function dss_mgr_get_timings() which returns the timings in mana=
ger's
> private data. Remove the need of passing omap_dss_device structs in the
> functions which check for overlay and managers.
>=20
> Have some initial values for manager timings in apply_init(), these would=
 ensure
> that manager checks don't fail if an interface driver or a panel driver h=
asn't
> set the manager timings yet.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>

> +struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manag=
er *mgr)
> +{
> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> +
> +	return &mp->timings;
> +}

This one returns a pointer into apply.c's internal data structures. The
safest way would be to return a copy, but as it's an omapdss internal
function, I think it's enough to return a pointer to a const struct.

 Tomi


--=-dDeyyuVgsz9g+rcevH54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPp+RJAAoJEPo9qoy8lh71aJUQAK6W+XprDjB4GDaufDebu9Le
/MgDv43FVit0LPA9Akhz2VYY52sp4GSMlAqEYZ8YsvSqk6cG44RI9B6qTzoZteAB
G60kGzTig7t7S8+2mbE2Kb9g8TAU8OkfY06fCSI7XnbnFx6oA3OkHk4qsFmc5dad
66aAClMdEsjx1p66wxm9QLy0CY/Q46IBpKB89/lqbV1JracI7QnyiDEr9Y/fODg5
hZk6wTptO9Nu2TNNERKKeDkhw6NApMR/8Qd1Shp3f+8rbbJX93R+bj2vS0vXYPFK
pKJ0WoHKK4K5WS8Eq88NEZ+FnPof+MMF1nQdRSbJbb+gKcukWwbjX+bxOBwKAlTw
RqNq8dVj9eN1QXd5QYQRJIXJDkNfsIWDeIKw810MjYF6VMZ6IuELeJd/M5UStCgj
mXIog/AcFNtRk8V1GuLpujPhXY3REPxelgBFK7yKUJulaBwxuBA0XuoeObAEr9oF
uFHcleYq4VBJm3d6MZboQUwU+piCkl3L6g2gz9/7WSt/Uq+I1oNSRwTv9FCH9aMn
CZoIAlRQfoIVjYROKALQeDT6R9VCkzSy8m85q+JMw9UmVcK4COyHL/bmwv3txkXD
6sP03H4LMPsrtHDvEa6fFGtVylcXlgkmWECzoBfp1gtn7PEBvoJpMOpVaahlHGo1
pp3ff+wVofksntHeRkbu
=8ScN
-----END PGP SIGNATURE-----

--=-dDeyyuVgsz9g+rcevH54--

