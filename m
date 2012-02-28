From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 HDMI PHY bug work-around for stable
Date: Tue, 28 Feb 2012 10:03:13 +0200
Message-ID: <1330416193.2123.4.camel@deskari>
References: <1328787865.1909.64.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-t9KbM1gr8f/ep2e1fxOW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40481 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755350Ab2B1IDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 03:03:19 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so8321171lag.16
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 00:03:16 -0800 (PST)
In-Reply-To: <1328787865.1909.64.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@kernel.org, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org


--=-t9KbM1gr8f/ep2e1fxOW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I haven't seen these merged nor any comment for these. Perhaps
stable@kernel.org was wrong address, so adding stable@vger.kernel.org
too.

I have added one additional fix into for-3.2-stable branch, which fixes
a problem with panel detection that the GPIO changes brought.

 Tomi

On Thu, 2012-02-09 at 13:44 +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> There is a hardware bug on OMAP4, which may cause the HDMI output to
> break irreversibly. A work-around for the bug has been merged into
> mainline, but is missing from stable.
>=20
> I've backported the necessary patches on top of 3.0, 3.1 and 3.2 stable
> trees, and pushed the following branches to:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git
>=20
> fixes/for-3.0-stable
> fixes/for-3.1-stable
> fixes/for-3.2-stable
>=20
> 3.0 and 3.1 branches additionally contain a patch "OMAP: DSS2: HDMI: use
> default dividers", which fixes a problem with the HDMI clock divider.
> Without that the HDMI output won't start at all on those versions.
>=20
> The branches contain the following backported patches:
>=20
>       OMAP: DSS2: HDMI: use default dividers
>       OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
>       OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
>       OMAPDSS: remove wrong HDMI HPD muxing
>       OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
>       OMAP: 4430SDP/Panda: add HDMI HPD gpio
>       OMAPDSS: HDMI: PHY burnout fix
>=20
> Of those, the actual fix is in the last one, but as the GPIOs for HDMI
> were a mess, they needed some cleanup patches before the fix could be
> made.
>=20
> I'm not familiar with the process with stable kernels, so are the
> branches above fine to get them merged? Or should I send the patches
> with git-send-email?
>=20
>  Tomi
>=20


--=-t9KbM1gr8f/ep2e1fxOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTIo8AAoJEPo9qoy8lh71HrAP/1OV51NZOyWKYXoyU8bZLzpd
YpbDRo/ZA+9rfQGC2agGZL7izttdg92WrowvPbYTZWIjJqu3vi9V9xtOtPLF9EMU
11cy0y4NXAVo+ZKFecyt47YxnKRCebv4RR2YgGTTsuLTdbKP3/a7wdxUbVGV5w7w
tQO8NzLIiMUlcrtFe17CVdODMMJnL3v2aZMo9yG2A435FpfchGlLg99Xmx1sCmAO
LAWHpuoLUHqnUKfvGjVdeVVseDmGQikNnXVkZOElRPNSlHz+VzXUiWSnZNXL4Lty
L2i/Tpe2a/H+4mCkQHCwrbXYq9GmwBXxk2JEc6hZX7R+54+adzvZtW3OqS639KTB
DVfn8/QQy6FfUgNqPNmNeTkniDVHVdSXMyL9OwabvktBAiT8TuVEkAVWvEPty8hY
9niN1k+2UFehTB2ClV3AceaW9QTvmdVeZwHLwwEt8tyPIYXKZ6mauYjfmFgzWENf
36Fih14uzplhwlSwh7a5dDbwDfvT2QUl9VjUrrjLbfDkEoF1/BkDCx5AYboRF4Ug
DMX+d4J17tj7jcXKA7QqWU5kyo28yDcv9SZZnnW9omY3AT/9n28nrOsU+vOY2tRm
7imrqZmuWOa5lxQP7PIYBmRlYHAkwiYWaRSaryS/uYjEt7UP6hWeWPA22Y6Qt9Jd
+jVOVzUPb6mfdGWNhFYe
=jh8A
-----END PGP SIGNATURE-----

--=-t9KbM1gr8f/ep2e1fxOW--

