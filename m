From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 13:45:15 +0200
Message-ID: <50A3844B.8040208@ti.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35ED47BFC740C2A90C23EF4F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40777 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161139Ab2KNLpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 06:45:31 -0500
In-Reply-To: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enig35ED47BFC740C2A90C23EF4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-14 11:26, Russell King - ARM Linux wrote:
> OMAP* allnoconfig fails:
>=20
> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput'=
:
> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bu=
s_tput'
> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup'=
:
> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_ear=
ly_init'
> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_d=
ev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_d=
ev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_in=
it'
> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_d=
ev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_d=
ev_context_loss_count'

I'm not able to reproduce this. I took v3.7-rc5, and the omap4430-sdp
noconfig
(http://www.arm.linux.org.uk/developer/build/file.php?type=3Dconfig&idx=3D=
2711),
and it builds fine for me.

=46rom the error log
(http://www.arm.linux.org.uk/developer/build/result.php?type=3Dbuild&idx=3D=
2711)
I see that arch/arm/plat-omap/omap-pm-noop.c is not compiled, which is
where the above functions are. However, the config contains
CONFIG_OMAP_PM_NOOP=3Dy, which should cause omap-pm-noop.c to be compiled=
=2E

 Tomi



--------------enig35ED47BFC740C2A90C23EF4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQo4RLAAoJEPo9qoy8lh71qDwP/0lpDtLEnfJZk+7ZV+xQ3Iwg
yoe3+Rk4fMK2634VotvNeJ2AOqVlBQ3cmqepD0i7QLfW8R7ZRRwR2aIdoTOmu1m7
dqSj48Tal9eHD7Kya3ixx+iOb/j4HR95J7+x85K8wzqPEhg9roDBVLWkN45k/dIW
spBP71o5RMHD7rnZM4kwyK9+v7MhCkQqq0baUw1e+ofQysAOkRoSYjV86IYLTKPq
9RD8TeJyn9rkm9LLVRUpMtYoepThRAQqJvwfKmiJgFvf4rQ/rAvu8XcrWg6RAlj0
o70sbqGMAyfJmavCO0ywvVpXXXAg/GgIcWFy4wAMCqnr6BZeE3NnVdVQPKiAW6dS
0QtixzUHjQJ+xAFnBfd+pqrNHMVQHgumdoGWHZiz0uhio94SvMVv3U3F8GbRJdAm
WpTEmu0fAzJ1k3du7ZtjmDHIyy4aOu3FO/tvM8z6SvnON/OzYg6rGY1Jm1KBFvHJ
R9gK2EDGoY6FSNHV8gfMi9+XKZkxfoeB/Qkwhu7qTcuG0oabUpINIMwnDfYftxiH
elMW7CewFrHZlFOzfETTYb/0AemqRMbCeLDyS7g1pkXwhyptAJ8ESz+Cz/jy6h44
CWrBFBtpqFC/KQDp9ogCiiDJjDYG2t0ViStIYwkVfwPToSnxmNgOUZgMz9XIDp9p
wkvL8p5mr6Y88+wLNiYA
=lvDs
-----END PGP SIGNATURE-----

--------------enig35ED47BFC740C2A90C23EF4F--
