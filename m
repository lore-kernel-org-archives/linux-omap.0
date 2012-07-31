From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DISPC: Use msleep instead of blocking mdelay
Date: Tue, 31 Jul 2012 11:53:28 +0300
Message-ID: <1343724808.2633.25.camel@deskari>
References: <1343138635-2802-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ItR/pYeMus56yFdbE6du"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:58142 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755848Ab2GaIxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 04:53:38 -0400
Received: by lahj13 with SMTP id j13so3603247lah.11
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:53:29 -0700 (PDT)
In-Reply-To: <1343138635-2802-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: a0393947@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-ItR/pYeMus56yFdbE6du
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-24 at 19:33 +0530, Jassi Brar wrote:
> We have no reason to block in the error handler workqueue, so use msleep.
>=20
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/video/omap2/dss/dispc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.

As a side note, I hate that error handler =3D). It was a quick emergency
hack to somehow handle certain situations, but generally it sucks.
However, I don't really have a good idea what to do in case we get
errors from DSS HW.

 Tomi


--=-ItR/pYeMus56yFdbE6du
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF50IAAoJEPo9qoy8lh71XFQP+wVr3Ypl0y/7OkK7/t4Dcy0S
j1r/H0uGT5hNxGvOIsSMAyITI24whrdQ2Reig/gCvdW3nYujh2NUjFBcDxWuDXGK
NGAh7ND7Ln80LlZnAqRkXm1H83Nt2940JnrlrHzvI0TWFsgxN+bmzsmX3F6bdGSD
X3iutklMZyIdTfoZfmPrnWFuRcXw5meh8SlvQoUGlpPrhGj3A2AQ+UX0vnKap9GX
ccJ8sedkT8lqUFkdgzxxta/iFmnDSRYx5pOKfNXTiqBs7YWA5uHddAA3WgSdNp+W
yCHYzSc5Endq3IdPoVv5aRRKRLCqrFlA6UdoecIwqpb6D4co3etRTuy1dN65R+Bo
YzVbHXmN8Lk1YcPO2ipG7GkaXdd+kmF0JkQyHh2x2V+ELTPVwR4uU2590pmtDg0Y
3MoFdOLkOXEIbKEV5Pa/Pb6pmzsbRZuY5qvQO6Y2CwgZ3cNqygLB/nkpArxrRIrS
gBnBzAHZZJlEaoAOx1hoYEp5l3ZtP2bQbtj/rImmnwiW908tOjyH6UYhddlD7Kxl
atudfRQ4YGXc0Por1r18fqdspxeCzZM+gtHqLXrXBrUK31ZyzWNv3WZXhJoOe8tH
m3PFy83CnrptQn3RnXwwkiOln5ZUg4s3Je+R9BnUEQja8uRJQT6xMRrsRCthq2PH
vT7yoUMifgr7wTMHcx9C
=k+8t
-----END PGP SIGNATURE-----

--=-ItR/pYeMus56yFdbE6du--

