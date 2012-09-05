From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Date: Wed, 05 Sep 2012 13:41:53 +0300
Message-ID: <1346841713.32747.6.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
	 <5047182F.3030507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CuM6RV9usGqGIT/leT9O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:59100 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752186Ab2IEKl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 06:41:59 -0400
Received: by lagy9 with SMTP id y9so206080lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 03:41:56 -0700 (PDT)
In-Reply-To: <5047182F.3030507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-CuM6RV9usGqGIT/leT9O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-05 at 14:45 +0530, Archit Taneja wrote:
> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> > dss_mgr_set_timings() can only be called when the output is not active.
> > This means that most of the code in the function is extra, as there's n=
o
> > need to write the values to registers, etc, because that will be handle=
d
> > when the output will be enabled.
>=20
> We need to fix dpi_set_timings() before we can make this change. DPI=20
> still tries to change timings on the fly, i.e, with manager enabled. We=
=20
> need to disable and enable the DPI output like we do for other outputs.

Yep, and for HDMI also (I didn't check the others yet).

I think the simplest way to handle this is to only write the dpi.timings
in omapdss_dpi_set_timings, and remove the call to dss_mgr_set_timings.
This is not perfect, as a call to omapdss_dpi_set_timings when the
display is enabled would result in changing the dpi.timings, but the
changes wouldn't be actually in use.

However, there are only a few places where set_timings is called, and we
can make sure in those places to first disable the output and then
enable it again.

 Tomi


--=-CuM6RV9usGqGIT/leT9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQRyxxAAoJEPo9qoy8lh71Kr8QAIMlvZjYeJuAOMiE9tCl2ewi
g6BjIKcEkrldz7QJkiO4LhNHRY5RZZ9UIJomwxYoDb3R5yAw/uokbmV+p0kmcSnw
rck41Uk2VYb3hPlXE+jHPtqlMOsjb0WzmP8NEHJptQOLnb2Hiuaow1KZRRFw1PKa
O3h/V4GajcdWEc/TWRojSLqXdNuVsqn1BxSNpENEyBNjzHzGl4hi4XWDkjCVqD1E
VxrEJjEVLo41fcOB0yJ0FdfshK1rM9Tcx/7VQ7Z6Lglu4vwCs9AgcAZu72pe8Ksg
r2yDl568PNQ4V3dTIwLx8d9xrWsHhUlrv/Ui4cH+09cfUWP5nia1o8ZKl7k3ahHP
bR2tvwkdYjY5I2TOeIiB7XY3zyjMoFUT6mtquy6WyReZ5l1lvIQow2yIVjNWPevB
6xcydWvLJ5bCR+qiiDcwLv4RerumCrjDMEzA+mQ+X1r454wxjyWxNBheWEJ2Qn1f
jgdL0DitpMfrY+kFU0GS9GbDNzm5j7vxTIU/14XZ9go5bh3v9eP8zM22CYtrHpKx
xSEk7OEZxR/6AjAsOMc9GtQ89gUaf0ibnQ8Yp2SxGAh5Ur0U/P6BIvdvRFqVcEql
aYYFt8ZJMRl4mC/ggLFrmETh1VxNaknKU8t/MUbR2HbvEKfPCNXrc5OWlWaXrm9f
kgiEVMHIvx5RYMTOMFof
=U8e9
-----END PGP SIGNATURE-----

--=-CuM6RV9usGqGIT/leT9O--

