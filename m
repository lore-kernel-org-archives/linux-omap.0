From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: add more new timings fields
Date: Mon, 10 Sep 2012 08:50:38 +0300
Message-ID: <1347256238.8127.4.camel@deskari>
References: <1347040786-29156-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-etSsunpeGzSxLFt5uieW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:55211 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864Ab2IJFur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 01:50:47 -0400
Received: by lbbgj3 with SMTP id gj3so940998lbb.19
        for <linux-omap@vger.kernel.org>; Sun, 09 Sep 2012 22:50:44 -0700 (PDT)
In-Reply-To: <1347040786-29156-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>


--=-etSsunpeGzSxLFt5uieW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-07 at 12:59 -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
>=20
> Without these, DVI is broken.
>=20
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
> Greg, it looks like the omapdss changes which added these fields, as
> well as the interlaced field, where merged in Linux 3.5-rc5.  So I
> think both this and the 'update for interlaced' patch are needed for
> both 3.6 and 3.5.

The omapdss timing and interlace changes were merged in 3.6 merge
window, they were not merged in 3.5 merge window (and even less in
3.5-rc5)...

 Tomi


--=-etSsunpeGzSxLFt5uieW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQTX+uAAoJEPo9qoy8lh71fZAP/0HvNX/MPw5xivegHdR/sTkU
MxdtamhqmzMxUlk+cdEm4JMCoLDDYDUuXcD/8DH7Xa3eXFqp0h7J7UlbRA7nUiia
+2ma6c986FMko1RPh36JXfOQVNI64CC2Q02PhqeiLtA5y+SLDFAnx19L5o3lFh7w
XGbpGvZVbnBVhQHbWzlylwUl7qplSjznOgimPUgP4O/aqyFIDrHt6lFeyU7BidQN
Zt2GFqpzVia/o2QUgYhEG20W/3ReR4fZg8iBMyhrnJzj/9y+jSU0U6QCd6xphCAt
04TcGYxsusSq0qZSIF3JvJeAjHoeOMPsXqrF3OQrWyHyTaFshiX9lQ8+5Xqsbr+R
BZPpfl2seWuCe8g8jKrNM3jK/57o9Ms2bE7cau6ReuX47laiWM50v3HlR5cJF8db
zDm2b0+vkFmVvhFrD/RuTnSLEX5F+T/UlvucQvVmeV2pf+MNoq77vVeX3EIwasod
9ft8ECUPj1g5hIMgJo6BKyGbI40kTI8F8VEhUFUBGlc/Ym6isNdt7c5j6r34jY4T
NEhgl9h4bQ4CAjT5bjHSyAttEdByDdnFx2n5TD6X1QBH7arwAwI4EUYdKb1Fs6uM
//J3sEjx2u1S2QtA5OV7GgMRpEF9rvheHRYwf2BwlCc9QZkR6tdLS5a8wH2cLWdx
fB9L6jyR2oshzyXo23kl
=TBq2
-----END PGP SIGNATURE-----

--=-etSsunpeGzSxLFt5uieW--

