From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Mon, 19 Jan 2015 08:41:07 -0600
Message-ID: <20150119144107.GC20386@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150118095214.GA3574@x1>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbbASOmZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 09:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20150118095214.GA3574@x1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>

--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 09:52:14AM +0000, Lee Jones wrote:
> On Fri, 26 Dec 2014, Felipe Balbi wrote:
>=20
> > STATUS register can be modified by the HW, so we
> > should bypass cache because of that.
> >=20
> > In the case of INT[12] registers, they are the ones
> > that actually clear the IRQ source at the time they
> > are read. If we rely on the cache for them, we will
> > never be able to clear the interrupt, which will cause
> > our IRQ line to be disabled due to IRQ throttling.
> >=20
> > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > Cc: <stable@vger.kernel.org> # v3.15+
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/tps65218.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>=20
> Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
> an Austrian mountain. :)

now you're just making excuses ;-)

> Applied now, thanks.

thanks :-)

--=20
balbi

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvReDAAoJEIaOsuA1yqREzTEQAKUiV3wcT4B0fNjFeTHiffC4
GyeF0MVYuexwwnb+EhNfSm3ykAc1DU6T8C0xvcgfWhS9H4hy/EQcVVtVLQJybUm2
pYZkNuOcN+FN1sZOBIwXwMu3ggmZpltMTW6rmR8wu6/9uWfVwDdg/5vfjyWmMsZu
8EsXVZzzmrqL1W5Fd+iOr89qlWnLICl8FQ0QdSwdVRgsOZrv7+zB05iXcGPB/SU3
/bbKFTX8v1fEr6RXJyX86DsJQCy3LZBU70Wienvbk2JJxcn4hH0KHNnHHfKMaTZB
vGwJqGQ2mP3IEAN23rItI5QQevWIUh+iZgZT/vyjwl+oCfW3dYYCZfdrVMBhrPVY
GC56zvTHrC5TSlZotbNG+bGNfohNnQ1wJV7YCk1MpCEdCmYoALfIsdtbJDrrIyeN
xJJwKZMCjPM+C3jQhEq7mgmPrs1nTmHiyQGWu6VxmcauUgbX0hJ0Qbxl1HLcVRNk
1G1RwrDhkjh4/NUC1Uhaetqq/va8456dhjDRS08JzGF9HfRhEE59meqmnOxiw/qZ
VPq18e+Qbebf374NMQlr1RioXnj98NVZcNqjG0RI2e0+Zohxy/niCqYaGz6MBBxt
LtJJvbC1cczRSP7e9bSPVaUxkFh5gclMrwjJYXarlGla84vUckLplqvydMSZcWJd
zcfWffnqoly6MbeuMQSB
=lUXq
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
