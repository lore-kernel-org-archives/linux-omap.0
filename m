From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/25] OMAPDSS: clean up the omapdss platform data mess
Date: Fri, 04 May 2012 11:49:47 +0300
Message-ID: <1336121387.2701.10.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	  <1336053481-25433-9-git-send-email-tomi.valkeinen@ti.com>
	  <4FA369D2.1070809@ti.com> <1336120320.2701.1.camel@deskari>
	 <4FA39501.3070205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gnRfqxmlrkZJazzQMlCP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60048 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753584Ab2EDItw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 04:49:52 -0400
Received: by lahm13 with SMTP id m13so1915025lah.9
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 01:49:49 -0700 (PDT)
In-Reply-To: <4FA39501.3070205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-gnRfqxmlrkZJazzQMlCP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 14:06 +0530, Archit Taneja wrote:
> On Friday 04 May 2012 02:02 PM, Tomi Valkeinen wrote:

> > Hmm. The sequence shouldn't change. The order in which the devices are
> > registered doesn't matter if there are no drivers registered yet. When
> > the drivers are registered, and there's a device for it, the probe will
> > be done. So in this case the order of the driver registration will
> > dictate the order of probes.
>=20
> Oh okay, I don't know where the initcalls exactly happen, but I guess=20
> they will happen after the .init_machine op in the board file.
>=20
> Do you know where the initcalls happen, I couldn't find it by browsing=
=20
> the kernel code :)

Well, include/linux/init.h lists the inits in order. machine init is not
there, I guess it's not part of the init order, but even earlier.

 Tomi


--=-gnRfqxmlrkZJazzQMlCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo5grAAoJEPo9qoy8lh71JGMP/3hQ6GPHwxjhUcTNy5MXoyWM
IYJfwt0qzEQkfGfoy5tyGQb0QR7OcQGl/wcWOqpi2omMZr6M/aoBkEKd/ZKeewzK
FHmglNYT+gqg1uyPt0pofDXQCA6wlVI1PuLftOc5b4GWhjybjFU41VYC7pgnrl78
ZjP+e9wIibQCIngvZJCs2bF+i9SVq2FBfjHKb3qICzdk6BfTMhqjDME9nOehCgJj
I8yBiyEQWx4QFSf0HMG9JGfHNpThd62kTBQ/LEjnD5ytsifD8SpkMQL9bI+I1bOI
qHsi/9eYVg2oy3kiGbt24spFgeuyvfrnMirZWVf/VjQloaiGCJyQD5YSQQjY8N9X
Wd1gEmBb2CIUKWH4Ne5rruaHaiIOf5dDgiUEO+scT+xPcov20FkxmmTt0UTx4Z7a
uXAxgOwbErELuJv7YyFynaebQ5a51HoFEN83y7ydeiM9fbZDPukdoTYBmU74XKL7
mP/wLgLIfv9+RJ2Qktgo5y42p5Q91JARpQqPQ4VhD6W8C5zGx2y0XqJBIweNnZN5
lIuVDYW0EvhGSOVZGBdPoElFY5BexIZ5Ewx2Vege6+XE8iqCxW6fKkSkLyXsrie/
8veyDBI7Kt4rYAwqU6NyjwkGLQ3cgvqJcfjZh3DXKdBPMz7ns88NNpTokNR9gEGa
pA+H55VqxrlpR+/VlqFJ
=afbU
-----END PGP SIGNATURE-----

--=-gnRfqxmlrkZJazzQMlCP--

