From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/14] OMAPDSS: DISPC: store core clk rate
Date: Wed, 20 Mar 2013 13:36:08 +0200
Message-ID: <51499F28.8090109@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-2-git-send-email-tomi.valkeinen@ti.com> <514998B1.8040907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FA955B1C128890EB61CC33B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34858 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3CTLgL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 07:36:11 -0400
In-Reply-To: <514998B1.8040907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig6FA955B1C128890EB61CC33B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-20 13:08, Archit Taneja wrote:
> Hi,
>=20
> On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
>> Store dispc core clock rate so that it's available for calculations ev=
en
>> if the HW is disabled.
>=20
> I think the core_clk_rate variable should change when we change the lcd=

> clock source through dss_select_lcd_clk_source() for omap3.
>=20
> If we have the following sequence:
>=20
> ...
> dispc_mgr_set_lcd_divisor();
> dss_select_lcd_clk_source();
> ...
>=20
> The value of core_clock variable would be based on the previous clock
> source, and not the current one.
>=20
> This situation doesn't occur currently as the 'apply' framework delays
> all dispc writes to the point when we enable the manager. So the
> sequence above cannot occur. But maybe we should keep this in mind when=

> we move more things to omapdrm, where 'apply' isn't in use.

Hmm. Good point.

I don't think this has to do with apply system. The clock source is set
by the output drivers, and the output drivers also calculate the
divisors, and call the functions to set the divisors. Both DPI and DSI
drivers first set the clock source, and then call the
dss_mgr_set_lcd_config() which sets the divisors (causing the recalc).

Whether using the apply or not, I think it should work correctly. But
it's clearly something that is a bit fragile.
*cough*commonclockframework*cough*.

 Tomi



--------------enig6FA955B1C128890EB61CC33B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSZ8oAAoJEPo9qoy8lh713EQP/3sIk0ZN6ABnaIdtmwom0A4i
Bb0J+yUQBkUIWy1+F8Ug7bHEoKWDGvpm9Q+04Mxj9yakVzxYAqfgBwYCc8qjyhnm
iXdaaC5N17xy75k2p+mCP/RpuJJWVtvrMUibMs4CPK2uDm+xcZTYW6hAKHDuxwU6
sy+UX7gEjIuYj05l42Qy8pENn4NNbLaHIL3i9N/HcQKaicYucVAbEQq9Dj3Cnkaj
06AYtU8pQwPAsT+R9SVXnlOfj4soNqakGGYDoe67D03i2WtaLBc4i9BhmhFzBYZ1
PtgcQLsnkG9tiOqWV/45YKSgOaGR5z0r02zg8FSTgVyLsp6qnsY+rsu9SF4saOiv
EycRzZfXVvcK+4eN9DtDAb2Gukg/oSSA/qKhmvJnuad6Tw8348Nx76bj76t0NnEi
KeDnkk2EIF218L4tGr7eU5YV0iQHXI1t/CXcvCdZckah+kG9eZcGCir9SWafB8A6
viLA+bfh6iURPMO3zSDOpclVxj21mjTS1qlP8DtHxrWKapSP4W7E2Zhfkvf00RcG
2sQ7TnT1gBM8Ih1+4p4cnRwWy1h1OEDUwT3J/65ghGtcHNhVWSy/Val1hOsgCZRM
wGhXeH8+tmo7h74huX0u9cSD+L3MT3tM5uQS971orYuiHaiVNsluizdA4KmV7AWe
Au9KhWwORt9lQQLIpISz
=FUu3
-----END PGP SIGNATURE-----

--------------enig6FA955B1C128890EB61CC33B--
