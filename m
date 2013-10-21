From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/2] drm: omap: Fix omapdrm probe and module insertion/removal
 issues
Date: Mon, 21 Oct 2013 12:38:27 +0300
Message-ID: <5264F613.2060002@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <1381138693-23404-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5TWsQXAcGpTwpf671BJu5nwSqtqBgwOcn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab3JUJig (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Oct 2013 05:38:36 -0400
In-Reply-To: <1381138693-23404-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, robdclark@gmail.com, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

--5TWsQXAcGpTwpf671BJu5nwSqtqBgwOcn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/10/13 12:38, Archit Taneja wrote:
> With the new omapdss device model. The user(omapdrm/omapfb) of a omap_d=
ss_device
> has to call connect() to use the device. A connect() call can request t=
o defer
> probe if the device(or the previous entities in the chain) have missing=

> resources like a regulator or an I2C bus.
>=20
> We make omapdrm defer probe by trying to first connect all panels, and =
request
> for deferral if any panel requests for a defer. This makes sure that al=
l the
> panels are set up correctly when we finally proceed with omapdrm initia=
lization.
>=20
> In order for omapdrm module to be removed successfully, we need to disc=
onnect
> the panels which omapdrm connected. Another thing noticed was that omap=
drm
> insertion followed by some usage results in panels getting enabled.
>=20
> Trying to remove omapdrm with a panel enabled results in failure while
> disconnecting. This leaves omapdss panels in a bad state. I have added =
an
> explicit panel disable in the omap_encoder_destroy() op, I needed some
> suggestions on whether there is a better way to do this.
>=20
> changes in v2:
> - Add special case when no panels are available to connect.
> - Make sure panels are diabled (and then disconnected) when omapdrm is =
removed
>=20
> Archit Taneja (2):
>   drm: omap: fix: Defer probe if an omapdss device requests for it at
>     connect
>   drm: omap: disconnect devices when omapdrm module is removed
>=20
>  drivers/gpu/drm/omapdrm/omap_crtc.c    |  5 +++
>  drivers/gpu/drm/omapdrm/omap_drv.c     | 77 ++++++++++++++++++++++++--=
--------
>  drivers/gpu/drm/omapdrm/omap_drv.h     |  1 +
>  drivers/gpu/drm/omapdrm/omap_encoder.c |  3 ++
>  4 files changed, 64 insertions(+), 22 deletions(-)
>=20

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

If it's not too late, it'd be nice to get these two fixes for 3.12.

 Tomi



--5TWsQXAcGpTwpf671BJu5nwSqtqBgwOcn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSZPYWAAoJEPo9qoy8lh71mXAP/RzKUS17xbHlTh2TpADtA0VM
W498uyHBZ2PeHvIkf3Bn2Fp0j7ciI2Vo2ws0HhEHmo53CiyEJpmiK2PqDy0/R9Y5
g92rziad8RGVT2Crg/gUIRAKsVt8QqHm9MgbsIy6SNwGkpnZjtzs6Qa/b1FOd+Tg
NduusKjYlcn4HHA2fiFcxIhS0MSbPo4/uPGiLiiySEcMwaWcgJMmKnX/+Lli5bU3
l88Byc+OfMCc4yn1Bb8MwN8LjkrS3zgYv0PGSlRmYvwQaaGjSN9BoSdlRzZA8hKa
SJQsKXP/fuKI9/EOYpHjZJTI7jzCFqB2BADmok0qF4Q7emkvlK04aOMYxrNzhv2H
FyUFn1zFX+3IstJhXHjoq1XK9oVzWmWf+ivIoSqAgIFr6eCwMrTcug2G5cv4xDBl
xC0yUUM4oUuedu08+qJ1oBbOslUWQlXQQyKw4HkTf3F5mlz3pc0i4P2+xadwno+u
/2c/tA1b/A369dNMLUzV4dDZ4k5U7vQaQsPwOa/Dvp0jzeJU5twFOl6iZ1/Nk6mF
H39BSDTM0pcN0dmyN+MicNCpyw3aWs3z/63yrLSpbPbJ0Hg41nJVlMBIqIzSXdUp
cDOj63k0aw905XZO7GYXlHFhn5CKyBF/m4jY9o11xrR5zhwQ9UwP6kk9ZCroaXIR
xZRY2tWAECCCU9w3QC6L
=9aoz
-----END PGP SIGNATURE-----

--5TWsQXAcGpTwpf671BJu5nwSqtqBgwOcn--
