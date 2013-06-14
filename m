From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP4 Panda DVI problem
Date: Fri, 14 Jun 2013 16:52:28 +0300
Message-ID: <51BB201C.3000605@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2LBJJOIJNJNRIEGDOWOOE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52968 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab3FNNwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 09:52:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

------enig2LBJJOIJNJNRIEGDOWOOE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony, Roger,

I recently raised the i2c issue with reading EDID from a DVI monitor on
Panda, when booting with DT. I just couldn't get reading EDID work at
all reliably.

I now see problems with non-DT also. Booting with 3.10-rc5, with DSS
compiled into the kernel, reading EDID fails during the boot. I can
later read the EDID fine from userspace.

With help from Roger, we found the issue.

DVI cable has a +5V line, that the source (i.e. Panda) has to provide.
This +5V is required to read EDID, but according to the documentation I
think it's actually required to show video also (although I guess this
could depend on the monitor).

I think for OMAP3 boards the +5V is always-on (I haven't looked at OMAP3
boards yet, though). For Panda, the +5V comes from DC_HST_5V, controlled
with a GPIO, which is used for USB and currently managed by USB in
arch/arm/mach-omap2/usb-host.c, which creates a fixed voltage hsusbX_vcc
regulator.

So, basically, if USB is disabled, DVI doesn't work. This is why I see
problems with DT (no USB), and non-DT (USB enabled after DVI is enabled).=


To fix this properly I need to add regulator handling to the DVI driver,
and we need to share the same supply with USB and DVI.

However, while the above shouldn't be particularly difficult, it's still
not simple. And additional complications come with DT boot, as DSS
doesn't support DT yet. We have the hack that enables DSS for Panda and
SDP board when booting with DT, but I don't think it's possible to
manage the shared regulator easily in that setup (ie. USB and the
regulator being described in DT, DSS and DVI added the old way in
dss-common.c).

So I think the simplest solution is to make DC_HST_5V always-on. This
should be fixed for 3.10 also.

Any idea if DC_HST_5V is a big power sink if it's always enabled? If
it's a big one, I could look at how to hack the DVI driver so that it
would find the regulator. I'm quite sure I won't be neat, though.

 Tomi


------enig2LBJJOIJNJNRIEGDOWOOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuyAcAAoJEPo9qoy8lh71QkMP/jy6s/wq20DoZc8ARCU0W4cU
3MYOy8rzggtqmXk7nxfZ8apD3S+9ebsoGlBBCBJOpx5W0Gev5G6Jj4s1IeEKcXSQ
MBnQMnH1xs1aa2ukKqBwDRrwSk3KCts8L9ZcoBCz5zrFB3Gc5AVjHJxXl7YToL7R
fAck5R4axurce2fupNWTULp5ft2Ycuq/ZfMKr1UGrw0Qq+M6ZnMeIXGo2XqmIM+d
S81qDjDTFP2rp8JwkaTy7hWXegbZUqTyP4vbNZDYOMZGKlnj/azo+1pHDXalnpJo
ejomarMzJHRATbAHjj4rMh0PqIrg9rMX39heByaspiZNWJQCfIE0LOa6qFR3eVII
HDTJiBS/WLFwdIChkSvk0uJ0cc7J0n1peUhpfG6GSHdzbWd+gy0vgteAXCl1TvHV
cudW2jjh2Z5cuduGauHhQIvg1oZG6P05m9OxkxkgjzXVo7xoUxQd6EpiOY0LvSEL
+Lr1sBs3Tcvl0Ni22epdxU2j8Wpp8cpO+/vOzI9VjyYnMgHfhNXQX8NLWChgXkb5
jvmi0wgOQKLKMnkjaAI3B4U9CUiuwadrqTbMvUghsRSCUIUhKIx5msLgBijJimEg
1ipvskTmwmJm+yBBvRHiX8latbLNaVwa+15UGt/ZYHDYjF071a/Z0JedOmsw+4vq
zgfw3kZpGl8cJ49n8TD6
=sXyZ
-----END PGP SIGNATURE-----

------enig2LBJJOIJNJNRIEGDOWOOE--
