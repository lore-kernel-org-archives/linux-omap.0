From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] Pass data lines and pixel format info from panel
 driver to interface
Date: Wed, 15 Aug 2012 11:41:11 +0300
Message-ID: <1345020071.3494.17.camel@deskari>
References: <1344595026-10607-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7wSZ73uZyOcU+BIQ4VKF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44920 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753788Ab2HOIlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 04:41:17 -0400
Received: by lagy9 with SMTP id y9so700986lag.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 01:41:14 -0700 (PDT)
In-Reply-To: <1344595026-10607-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-7wSZ73uZyOcU+BIQ4VKF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-10 at 16:07 +0530, Archit Taneja wrote:
> This is a continuation of the work started in the series:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D134381744304672&w=3D2
>=20
> This makes the panel driver call interface specific functions to configur=
e the
> data lines and pixel format requested by the panel.
>=20
> Configuration of data lines doesn't happen for DSI or HDMI. For DSI, this
> information is more complex and is taken care by omapdss_dsi_configure_pi=
ns(),
> for HDMI, the number of TMDS lines is always fixed.
>=20
> Configuration of pixel format is done only for DSI in command mode and RF=
BI.
> Currently, these new functions take different arguments,
> omapdss_dsi_set_pixel_format() takes pixel format of type
> omap_dss_dsi_pixel_format enum, and RFBI omapdss_rfbi_set_pixel_size() ta=
kes
> the pixel size directly. It would be good if these could be merged by usi=
ng
> some sort of MIPI standard for pixel formats. Having the same argument wo=
uld
> help in having a common interface op in the future.

This series looks good.

 Tomi


--=-7wSZ73uZyOcU+BIQ4VKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQK2CnAAoJEPo9qoy8lh71/BEP/AxXJIjjMIqxJyIpyvX4jd3y
G3mMv5DSVTj/UxLYxdsUKToyMbyEl+LXNVyFQp6ttqgxDF5EpniGsrMXFwjhHkA4
m4z5r8dUI0rihrsGJM+EcJTKFcz7uySuIDdtGUT0cSyEdMAIKvt1lPo3nlmG5lXU
YACHPEJYyNRICzOBelhKA4qXpSUoGM4ion56sINhQWifPA3rR10j3tGjaeBfBKHj
OZYKE5iA0EWmZesA9YHc1p5nC7dLvA/Z0uQI4dra+b2g7r4BazbnBtmaOeuKeGlF
uzDCoC6+ZA3iWPyAa9c8JMd9saLnbk8ZJWDRKwrmOchXzU0ztwQXiTGrqueJ5Xfr
Tdgj5BCwjvzm4T0RGeOo9azmE/AwQjvQvI1J2rR/jQZMTkHungSlRN61ujWSvVjc
TWn0s14mjlHaPWo/F6xnBDPVd9/q4Tc7H8Vb7rchLb95C2NPdvV4qjdXS0YjFyAJ
W5RQ8GEH/wDYwFphoczlAGo1RxPHHpWxYd2qFVTujnS22U0IU58gKPIp/PPJ2Tz0
GjtZiuEV9748Y6igH8QGdIHewLQgrssl/Iywd3R+Mfm4sNdEiFhLqiYJeXqDY1fP
TS6pa4yCkQodOp50doJFeN74ajogfgDmHNO9kB0WrZ4Z9YLlJyzlmdjq1+4TI/d/
t59RtxES+wKzXXIMvduu
=4PQG
-----END PGP SIGNATURE-----

--=-7wSZ73uZyOcU+BIQ4VKF--

