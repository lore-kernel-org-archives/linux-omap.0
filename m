From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 3/3] OMAPDSS: HDMI: Sysfs support to configure
 quantization
Date: Fri, 09 Mar 2012 14:26:52 +0200
Message-ID: <1331296012.1927.60.camel@deskari>
References: <1328682261-22493-1-git-send-email-mythripk@ti.com>
	 <1328682261-22493-2-git-send-email-mythripk@ti.com>
	 <1328682261-22493-3-git-send-email-mythripk@ti.com>
	 <1329222123.1845.82.camel@deskari>
	 <CAP5A+B8J_y4GOMJ1pX1koYSDzGNA15i6ebY2i5ZZ5ZMZsvPE3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-krtQFRyXXZtiAee8xDoP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:47386 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755042Ab2CIM04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 07:26:56 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so1589140lah.15
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 04:26:55 -0800 (PST)
In-Reply-To: <CAP5A+B8J_y4GOMJ1pX1koYSDzGNA15i6ebY2i5ZZ5ZMZsvPE3A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-krtQFRyXXZtiAee8xDoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-09 at 16:17 +0530, K, Mythri P wrote:

> > I also only now realized that we have full/limited range setting in
> > video overlay's ATTRIBUTEs also. And it seems that we currently set it
> > always to 0, i.e. limited range. I wonder if this causes color
> > degradation in case the HDMI/DP output also sets limited range, and thu=
s
> > the color range gets scaled down twice...
> >
> yes there is a limited/full range bit in dispc for color conversion,
> did a quick check using analyzer it doesn't impact the HDMI color
> range, so can confirm there is no degradation.

Did you try what happens if you set the range to full in DISPC? Because
it should affect HDMI also, so I don't quite understand how there could
be no degradation if both DISPC and HDMI do the range limiting.

 Tomi


--=-krtQFRyXXZtiAee8xDoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWfcMAAoJEPo9qoy8lh71HGMQAJ17rkYNGoyOpTlAaRa2w9DR
BANsKDEUfL/+9Y7FHE3j37VMtCBvG/M26vrIDtuen75NdV10gVkHQ8fvGQl/dJbO
he4ZvB4JFVVrNhNt53KhLvCHDE6MYq3v6/6iUeqsRV9o0pfcPIGTTuoZCM/Kzy3u
dh+AjM8qHCRmXsQwr3YKkwnHzQNiF7QmBWn7s8oV6sdRrFW9MBcqkf5HbiFnnor2
d8cW704Z3iA0d82IzPeeZi9LrhaDI9y3/3H7j6+04r0xGLIgm0NlxyK7i64kXP5m
PvFRq40m0+ZPqrc2eokoHOdVkMqn8KntJcQtSHhcM/Dnm4nzqxJBOFAosxGAbfIx
lkgiIzzXQHYJQ085BxsnDCbBrnQNJWAtFd2d5zB+XKZMcAR4cywZW8bcxtD9M1fN
trOvFkoO9j4GvktrDX0ewn8QgsWxj3fUf37Z8boVF6rz2kEneK7jcN5h6rrbP6fz
HZ5sUFSmcd3niAY4k78QDK7m1b9YbYri8yBoCiLzMcaOlIdkjNxQtImTNCvC3KPK
ZWb6Fc4zl3/hjfYXmBcPkvWji0N7Eh1P1+6SPDI8Vg7TW+mr+GBSWYzfo55qzPil
gZ0rvYMzEJ70s1X+LuD9PxNvtIaa9oALN6EW/NmRdXgQ1Akh3wNQosCL+t0kQ1NW
QtiG6xW1i9N+ARgn73GC
=qe+t
-----END PGP SIGNATURE-----

--=-krtQFRyXXZtiAee8xDoP--

