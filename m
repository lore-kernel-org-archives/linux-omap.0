From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 18:55:16 +0300
Message-ID: <1337615716.2717.9.camel@deskari>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XYYe_3xprvVORXkdX2N54iDn_2v7GXndB6+cCtU0bLhcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-v3uH60Bmro8whaOjY0xt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41019 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529Ab2EUPzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 11:55:23 -0400
Received: by lagw12 with SMTP id w12so3492003lag.10
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 08:55:20 -0700 (PDT)
In-Reply-To: <CA+Bv8XYYe_3xprvVORXkdX2N54iDn_2v7GXndB6+cCtU0bLhcA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


--=-v3uH60Bmro8whaOjY0xt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-21 at 08:52 -0700, Russ Dill wrote:
> The correct patch for this was sent earlier:
>=20
> http://www.spinics.net/lists/linux-omap/msg70042.html
> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
>=20
> On Mon, May 21, 2012 at 2:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Tony,
> >
> > There is a bug in the for-l-o-3.5 branch I sent earlier, causing the DV=
I driver
> > to fail to request the power-down GPIO. This patch fixes it.
>=20
>=20
> The correct patch for this was sent earlier:
>=20
> http://www.spinics.net/lists/linux-omap/msg70042.html
> "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"

Right, and I was cc'd. Sorry, I somehow totally forgot about that =3D).

So ignore my patch.

 Tomi


--=-v3uH60Bmro8whaOjY0xt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPumVkAAoJEPo9qoy8lh71D98P/1owIBzD6kNzingqMpqqhW0t
b3hrrS0cJSw+WsNw+rjGIY2taDY55zlGBpOw647xetqiA3aZtuTjnBdq236ZKYGU
rtVPvRzPDioWoM8NW1GBCmezqYfNVfeNZSD3VgNkjo0Kc7IT+BnTHpUJwsB18mc4
fXazSSPHxork/SDruhKydfbOlWc9C+23EAu+bBZ2JxXMfPOCP6NilJfmAFs1Bpc0
nreoDN+RY7iN6EvI9/U24mXazTs4e2Kfws+clY7kAcbsRJQj1ySyQlGY7E/xE8vF
GAS8ArhMt0pTqkHZAWuQCLlspcdYSnCmn9tQPuvSapzSJCwUlR0gccYAzXfyxMuo
gxJm8C+/YnCJm2aLuKAoWIWlvxVTf3hIHSsi2tIw7ZsUxWhSaNX8ahcraSOwR74u
6og0bkiWnPay+L8ibu7cLujUUk2+nvwOBQb04qfK7MHWM00XzvjP0EgcONEsMa5T
/5WPIEGRMzZKm2kZOQ/O5ARC/ROlWPgFlHQGBoa3RYn3z/BKwzgeJkHQCuVPhzq1
Mwt5cjGSMmDXC0KM95kUMrv9PsfAVRKIWip+KVI4l9MZLKYzXcVgdSZfdfiAZuL9
YHOJSMal6OPUb38WSBmjh67KkGZq+9b5iM3QDezgMezNH6Io83WcMt/IKoiaP0wy
pg4IWSIuTkylyd9z60lL
=bHfS
-----END PGP SIGNATURE-----

--=-v3uH60Bmro8whaOjY0xt--

