From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 8/8] ARM: OMAP2+: Limit omap_read/write usage to legacy
 USB drivers
Date: Wed, 22 Feb 2012 10:14:01 +0200
Message-ID: <1329898441.2070.10.camel@deskari>
References: <20120221233619.18709.87982.stgit@kaulin.local>
	 <20120221234051.18709.3571.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-hGaf9HnPqA6s91vrxpYC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45455 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777Ab2BVIOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 03:14:07 -0500
In-Reply-To: <20120221234051.18709.3571.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-hGaf9HnPqA6s91vrxpYC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> Drivers should no longer use omap_read/write functions
> but instead use ioremap + read/write functions.
>=20
> As some USB legacy code is still shared between omap1 and
> omap2420, let's limit the omap_read/write to plat/usb.h.
>=20
> Also, let's make drivers/video/omap/lcdc.c depend on
> ARCH_OMAP1 as it is not needed for omap2+.

I'm ok with the lcdc.c change, but I also have a patch series that makes
the same change, plus removes the omap2 code from drivers/video/omap/.

Can you check the series, and give ack if the arch/arm side looks fine?
It's this one: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup

 Tomi


--=-hGaf9HnPqA6s91vrxpYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRKPJAAoJEPo9qoy8lh7190YP/09+OkEGMJuQBQp/ypauztt5
BnUm9E7Kw47mubN+8tisiB6G6Hup5CbJgX3vCyarYNI7bJ4PWdjqVU36UxWEyiRP
Rs8LFDN8W5dKQ83wURPLBP4MsXj716mc07rPw1duxfs+fLmtPSAqR7UxaZ2QjEeJ
Hjz+/mGE4h9CZKmKLPYIRLr6cn/gomj57m07sdX94fseTC3q36YzztlcdljQADvm
aTEzthVxs+rFDeghklhgl1lpeAYEDnaj/hSX8V6cUnKxgXumltOoT6y7u+DaLeFr
kC+jrxF3w6BG+HIrHZzR4I441UO/WvBYOEhazax8zNRVTV3j56gMyJOV0Qpk0j2B
w0sv6TA08Lk4nfEdKdbgB7P5ShmeTX5QbfEZuzFIMI+GLOdTqKI8uNXVcQV60DPd
C69L18lu0pkfXkGZLe0YTJ1GNKifPf/JXGEIZlhkpg5opX4lXz7tNc7YYDDQbbhB
cMkTUVlvBOYCyfmfpc7aTCUUA4e+hmgUWjaN4/2OoaASkeYt3JgUrpPyhthj6iXv
sCJrU8p8fpaKuz0og680MzScqxBFsS1647Awa6r36gI2d4gXgTMK34FonGaMegHm
AOpTOk80eWrcCdzaQOklamRBwuxtdpKH85b0EhUIvIDJ1hxJHzVm/EN/Qm1RT0u9
IoAct649PmdKFkKS3b0q
=n3pr
-----END PGP SIGNATURE-----

--=-hGaf9HnPqA6s91vrxpYC--

