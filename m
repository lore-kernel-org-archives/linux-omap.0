From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH/RFC] ARM: omap3: Split the pinmux core device
Date: Thu, 19 Dec 2013 18:17:33 +0100
Message-ID: <20131219171732.GB24230@earth.universe>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:34229 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757Ab3LSRRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 12:17:38 -0500
Content-Disposition: inline
In-Reply-To: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, sakari.ailus@iki.fi


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 06:11:50PM +0100, Laurent Pinchart wrote:
> The omap3_pmx_core pinmux device in the device tree handles the system
> controller module (SCM) PADCONFS fonction. Its control registers are
> split in two distinct areas, with other SCM registers in-between. Those
> other registers can't thus be requested by other drivers as the memory
> region gets reserved by the pinmux driver.
>=20
> Split the omap3_pmx_core device tree node in two for the two memory
> regions.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 45 ++++++++++++++++++++++++++++-=
------
>  arch/arm/boot/dts/omap3-beagle.dts    | 28 +++++++++++++++-------
>  arch/arm/boot/dts/omap3-igep0020.dts  | 26 ++++++++++----------
>  arch/arm/boot/dts/omap3-zoom3.dts     | 19 ++++++++++-----
>  arch/arm/boot/dts/omap3.dtsi          | 13 +++++++++-
>  5 files changed, 95 insertions(+), 36 deletions(-)
>=20
> While working on the OMAP3 ISP driver I've run into a failure to request a
> memory region already requested by the pinctrl-single driver. This patch =
is an
> attempt to fix the problem. An alternative approach would be to support
> multiple reg values in the pinctrl-single driver, but that might not be m=
uch
> cleaner. I'm open to suggestions.

Acked-By: Sebastian Reichel <sre@debian.org>

I haven't checked the board dts files, but the change in omap3.dtsi is
needed to "fix a external abort on non-linefetch" when doing

cat /sys/kernel/debug/pinctrl/.../pins

on my Nokia N900.

-- Sebastian

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSsyosAAoJENju1/PIO/qawUwP/iB9pXVflae8UryX+XDYYy2N
h8xvsM2tWzCfBcMl0KHFI9kWViS1O7ksMVNBnKruoMRj5mtNRj8DVsCqDi3z7ZtK
GbINM4HeI5tqxOWRSdsihtOtUCVToQkzjuu8zf7bx/TrpaqZHBSn26E1h+j9leNa
4VTox6afR5y1o05H7RbNaBIDyviGaHDzY5UeaY5fLJSmqbCFLqKvWUWIXNP2lsny
S1MmDYUwFELkZL8PghegHqDNOxgQSQOmAyf/Hvln7FuZlIwwh44kQ+c9zRqRHDct
2dUnh+i/4i3YRz+C+R1Jd4EAElAfUse/kYpfcp9gOxqDzi9uJLrjag9GmD/8sTxq
KWusDdkWtLtxUWP4POkR+K7nZABhrUS+hEYHFS/IS3VnlcuOJeWhwWFvSamQMuD3
BBPR/n/9b2VEOKRDDx3iCSDeo0bPRb8THSNOn6JDxo4/EhgJZXGgZHJqzftrkdBB
206uWmYOTFuMfsmS2AAVQ0cBZiJiHOo4hIu4LP350/XgD6EiMBcJs7lzo6XGHs+N
UbrN30LYvzZMYIJwveMV9fowGT0ungDHyRtmAk+YgU9Lfz11/nPkdpDU+kC97x7U
kzeVRUlPadxy47LecNrykQ45cbVS4GD8oECRGQXGZTGy0c7LgwJK05y4fLScPXpt
Ykil1g2YiI1OzOSQGPuE
=Yw9D
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
