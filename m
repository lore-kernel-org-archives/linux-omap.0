From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Fri, 16 Jan 2015 16:57:32 -0600
Message-ID: <20150116225732.GB6254@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150106173734.GL6502@saruman>
 <20150108162512.GC31926@saruman>
 <20150112164654.GB6525@saruman>
 <20150114170716.GL2419@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53061 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbAPW6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 17:58:44 -0500
Content-Disposition: inline
In-Reply-To: <20150114170716.GL2419@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Torokhov <dmitry.torokhov@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Andrew Morton <akpm@linux-foundation.org>

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 14, 2015 at 09:07:17AM -0800, Tony Lindgren wrote:
> > > > > STATUS register can be modified by the HW, so we
> > > > > should bypass cache because of that.
> > > > >=20
> > > > > In the case of INT[12] registers, they are the ones
> > > > > that actually clear the IRQ source at the time they
> > > > > are read. If we rely on the cache for them, we will
> > > > > never be able to clear the interrupt, which will cause
> > > > > our IRQ line to be disabled due to IRQ throttling.
> > > > >=20
> > > > > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > > > > Cc: <stable@vger.kernel.org> # v3.15+
> > > > > Cc: Keerthy <j-keerthy@ti.com>
> > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > >=20
> > > > ping
> > >=20
> > > another ping. Without this and the following patch TPS65218 power but=
ton
> > > driver which was already applied by Dmitry, won't work.
> >=20
> > Anybody ? -rc4 is out and tps65218 is still broken because nobody has
> > acted on these two patches. All other patches which are meant for 3.20
> > merge window are applied and because of these pending, those patches
> > won't work.
>=20
> Lee, are you planning to pick these two drivers/mfd patches?

Samuel, Lee, is someone planning on picking these two patches up ?
v3.19 remains broken.

--=20
balbi

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuZdcAAoJEIaOsuA1yqREIbYP/3XH7tMz3eXeZwksb7wCN+OX
IvMSYWKc7V6qiT5/KexhhasVonG3Mgo+BOoA1vzynyMJj1W2IaiwhWu5n1LvLbv3
4h526Okv244Nmq4YIcODt6WOVEWyeFQS3rVcgAErqJ09s6GOY0mOI89rpZKco149
+TwpuMgTYdi/YoGwlOUjt+YVw09xWeNTpMdh0UW5GHDJ0q5JVsJt1+H3+tkR27Rj
yh6PO8o4Z15SOTJ9NSqHDyGDUOxvh6Tp6L8GDX6O893oDIgWO7hMfoQZ42dYHCmV
glzp2ShHQTqQL7rOHfFHWTBLdC1FTCtaq3I3JrYdTDjOmCL7enM0HjgNwBzBeWwf
iVig33JSOgOnMeL66THAqW/XXMfC5Eli1wlOlMlOKggUWCjExnlGK5WxCY0WWgNi
DK+NlcGif1TmKwhFEr/G614haf3EAyIhajZukD2nZy2An+QwmIXzl9vpujKZ6NoD
PWs4+WtO/LNg/VgyMfFSBcx+VlbxdNeZSxR9Ya7ykXtlxaygZWgAo4fMYQDyEP+l
QdwVRjpvQv50Fp3VepaI4tPMqMO43hyhAIUL1PP/WFDnP+P7IiJubV1yt9LEXpI3
pAgpcCN0VKJuc9YqgdR/DLQDkS3JlgDCi6/9YmIPwHWRm/DcgU6OZPbi3ZZrbM8C
JoROItwLqz0H9Ok7iQtB
=Ae09
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
