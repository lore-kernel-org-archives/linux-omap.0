From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH_v2] watchdog: Convert twl4030_wdt to watchdog core
Date: Fri, 14 Dec 2012 02:28:28 +0100
Message-ID: <20121214012828.GB402@earth.universe>
References: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi>
 <1347343270-16881-1-git-send-email-jarkko.nikula@jollamobile.com>
 <50643D2A.7020402@jollamobile.com>
 <20120927212312.GJ16482@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:57439 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952Ab2LNCAr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Dec 2012 21:00:47 -0500
Content-Disposition: inline
In-Reply-To: <20120927212312.GJ16482@spo001.leaseweb.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jarkko Nikula <jarkko.nikula@jollamobile.com>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 27, 2012 at 11:23:12PM +0200, Wim Van Sebroeck wrote:
> > On 09/11/2012 09:01 AM, Jarkko Nikula wrote:
> > >Convert the twl4030_wdt watchdog driver to watchdog core.
> > >
> > >While at there use devm_kzalloc and set the default timeout in order t=
o be
> > >able test this driver with a simple shell script.
> > >
> > >Signed-off-by: Jarkko Nikula<jarkko.nikula@jollamobile.com>
> > >Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>
>=20
> on my todo list.

Will this patch get into 3.8? I did not yet see it
in linux-watchdog-next.git.

-- Sebastian

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQyoC8AAoJENju1/PIO/qaA10P/19RHqQ6FIE/l97GTjdylcHl
D4+AqH4OnVjHoXLaxylke4FEgdXGCpqrKe/Iyv+iBgYLy7XzItVK+ZJh95ExzRPI
i/+8rCFG4od5PhylVTis8qCwy6vdMHYsvxa99Uy9+0HrTX5UL/gngH6UgEPvYxjW
otreZQcRPfoarOTzkVk9pAnezxIh6PDv3TVYdNyUx9ok21rmrX6jq87lduMy2eR4
kSPja2o3ffmLxIdOQ/5hPAs1INYS8t/LUGBpmQh4/9BpLiJS/Dargd7NOpdHQdut
w1uvFqUGHS13vwNrWHxXO90VaSfuuKzLpcAbMkLtAH6HOcTjo/oA7wacZ6oB/L5p
TzR4F8spwMZPXfyz3C/f9OSo7EFq8T4vSDOdL4x3uLgW2Gf2LOGfxJ9E6FI7dGKx
DXCxzkVRoVCIFOC7wZFmY2GH3OrZdyxWEPgqBpIfLKHUVUzAdYdOSNaECkHtFIEv
4WsWFiQtLpZ/BKgI5qcX83GOHWQ38LaWlzMh4gLoUEDYcrfHYisTCXxU+Ud2B4D1
bAl5/BTsoOlqhv6HWlyft4JZtphMCxVoODrB1JBfIM7P5Y2dVmigEfa7V2BHD2ld
iOstwa9jc0C9dZG+AFpz9VUgWrJbCXHBYhxuRuAM3SPgGsNBozvqxpV2vpu0B5jB
FmrAfwrBOpaVRG58/xLE
=T+78
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
