From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/4] arm: omap: display: Ensure DRM/FB/V4L devices
 are created if DSS is available
Date: Mon, 16 Sep 2013 11:50:02 +0300
Message-ID: <5236C63A.9000709@ti.com>
References: <1379315911-24634-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="T1Q8qTHlWo5K6GHSfQOqciPLThCFhdsRH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab3IPIuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 04:50:09 -0400
In-Reply-To: <1379315911-24634-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org

--T1Q8qTHlWo5K6GHSfQOqciPLThCFhdsRH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/09/13 10:18, Archit Taneja wrote:
> Currently, omapdrm, omapfb and omap_vout platform devices are created a=
nd
> registered through omap_arch_initcalls. In a multiplatform config. It's=

> possible that all the corresponding configs for the above drivers along=
 with
> omapdss config are selected even if the hardware doesn't have a DSS IP.=

>=20
> If the image is booted on a AM33xx platform, the above drm, fb and v4l =
devices
> would be registered throuth the omap_arch_initcalls even if omapdss its=
elf isn't
> registered. These platform devices don't cause any harm, but are unnece=
ssary.
>=20
> Move the registration of these devices into omap_display_init(), which =
registers
> omapdss devices and is called only if the platform has DSS hardware.
>=20
> Also, the first patch prevents creation of a DMM device when omapdrm de=
vice is
> registered. With the removal of address and irq data from the omap4 hwm=
ods, the
> probe of DMM driver fails and omapdrm isn't able to utilize the DMM har=
dware.
> This will be fixed when DMM DT nodes are added for omap4, omap5 and dra=
7x.
>=20
> Changes in v2:
> - Move device creation for omapfb and omap_vout to omap_display_init to=
o.
> - Keep the DMM DT conversion as a separate patch series since this seri=
es does
>   something different now.
>=20
> Archit Taneja (4):
>   arm: omap: drm: Don't build device for DMM
>   arm: omap: display: Create omapdrm device inside omap_display_init
>   arm: omap: display: Create omapvrfb and omapfb devices inside
>     omap_display_init
>   arm: omap: display: Create omap_vout device inside omap_display_init
>=20
>  arch/arm/mach-omap2/Makefile  |  6 +-----
>  arch/arm/mach-omap2/devices.c | 10 +++++-----
>  arch/arm/mach-omap2/display.c | 28 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/display.h |  4 ++++
>  arch/arm/mach-omap2/drm.c     | 24 +++++-------------------
>  arch/arm/mach-omap2/fb.c      | 14 +++++++-------
>  6 files changed, 50 insertions(+), 36 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Tony, since there are no driver changes here, and it's unlikely that
we'd have a conflict between the dss driver changes and these changes, I
think it's best if this goes through linux-omap.

 Tomi



--T1Q8qTHlWo5K6GHSfQOqciPLThCFhdsRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNsY6AAoJEPo9qoy8lh7116cP/itu4J7JaEvpSsfFRpAH9rZ5
lGFxuLPbbbK4p9DL/epSJL0zJjz+Bp+p8Mb0/2LXQkq3xEapi7q/9tXtkAOi9bRw
802lCIIMq11ardNuEgcjP2xeF/gl8KT9aBuwwAAQls01YY479OSeFLiL6hKMD1wj
I1XSlMoUrJO8+eMzLLY0BjxEZtMo7T3KZjswAPyLBQM/82wOLcLgNQOyKCUMJ4HD
RBloUnAkmaEjUwL92rJMtDMoksb2yo8iqv/4LcaD7PbAAl9zbfR0Xuv7jsIq6Av8
x1LSCme3ZrkD9YaNWUTLccbd6Qusb8tuVtJdUcPFg3V4i5nWmo9NgDmS3AOiFimV
PuVlU3ahNqBpx7eJIKwMNNU6jRZiKciw1AYyMPxsiHfKy2gYM2fBiJ6yHBukHfeC
vf2xJ/p8qg/Ma2tnM/ztPZBYp88QyGpyiAB+nAwJ4jwADSVR7cVs0ysJvP+mYEWF
YEt2hKybtEqkVb6e36W0dEztN5bQFuA5KoIizwQ0jw2Ftk/PwEm0m7nVccJzX2L/
gsPsOHhz3JSqt9JGepaJaNaVG+mx7St6oU577x82b8ZiGU2XNLbheaITDoGl5lki
c+/I9g1ohoRrehmSmzytipdmpXiXFluqH2W1KMTb5HddKuO/tFHr3SqJl9fZSguj
Ic/iQHXoSkuuAqhdc+Ew
=ass4
-----END PGP SIGNATURE-----

--T1Q8qTHlWo5K6GHSfQOqciPLThCFhdsRH--
