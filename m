From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] video/omap2. dispc_mgr_enable needs runtime PM
Date: Thu, 5 Jan 2012 18:32:41 +1100
Message-ID: <20120105183241.751b8086@notabene.brown>
References: <20111230123755.384a5b5c@notabene.brown>
	<1325663456.1875.14.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/h/lmwTIPJ4dCSbL0zIIIknV"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56210 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757434Ab2AEHcx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jan 2012 02:32:53 -0500
In-Reply-To: <1325663456.1875.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--Sig_/h/lmwTIPJ4dCSbL0zIIIknV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Jan 2012 09:50:56 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> (dropping the Tony and Kevin, as they're probably not interested in
> this)

Thanks.... takes a while to figure who cares about what :-)

>=20
> On Fri, 2011-12-30 at 12:37 +1100, NeilBrown wrote:
> >=20
> > When dispc_mgr_enable is called during shutdown the device might
> > be asleep, which causes problems.  So ensure it is awake.
>=20
> How does this problem happen? dispc_mgr_enable(channel, false) shouldn't
> be called if the device is asleep, and thus dispc_mgr_enable() shouldn't
> use dispc_runtime_get.
>=20
>  Tomi
>=20

The stack trace shows:

[  101.764556] [<c0205b3c>] (dispc_mgr_enable+0x40/0x2e0) from [<c020c10c>]=
 (dss_mgr_disable+0x14/0x20)
[  101.774078] [<c020c10c>] (dss_mgr_disable+0x14/0x20) from [<c020e500>] (=
omapdss_dpi_display_disable+0x1c/0x88)
[  101.784484] [<c020e500>] (omapdss_dpi_display_disable+0x1c/0x88) from [<=
c021efa4>] (td028ttec1_panel_suspend+0x1c/0x88)
[  101.795684] [<c021efa4>] (td028ttec1_panel_suspend+0x1c/0x88) from [<c02=
1f03c>] (td028ttec1_panel_disable+0x2c/0x50)
[  101.806640] [<c021f03c>] (td028ttec1_panel_disable+0x2c/0x50) from [<c02=
0ab6c>] (dss_disable_device+0x20/0x2c)
[  101.817047] [<c020ab6c>] (dss_disable_device+0x20/0x2c) from [<c024ad08>=
] (bus_for_each_dev+0x4c/0x8c)
[  101.826751] [<c024ad08>] (bus_for_each_dev+0x4c/0x8c) from [<c024ca0c>] =
(platform_drv_shutdown+0x1c/0x24)
[  101.836700] [<c024ca0c>] (platform_drv_shutdown+0x1c/0x24) from [<c02481=
64>] (device_shutdown+0xcc/0x10c)
[  101.846679] [<c0248164>] (device_shutdown+0xcc/0x10c) from [<c004c134>] =
(kernel_power_off+0x10/0x4c)
[  101.856170] [<c004c134>] (kernel_power_off+0x10/0x4c) from [<c004c420>] =
(sys_reboot+0x124/0x1e0)
[  101.865325] [<c004c420>] (sys_reboot+0x124/0x1e0) from [<c000e9c0>] (ret=
_fast_syscall+0x0/0x3c)


td028ttec1_panel_* are in a non-mainline driver that could well be buggy.
.....
yep, that looks likely.  The 'disable' routines of other panels only call
omapdss_dpi_display_disable() if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACT=
IVE).
This panel calls it unconditionally.  I guess that is the real bug? (and
putting an appropriate test in fixes it).

Thanks for your help.

(If/when I get this td028ttec driver cleaned up, would you be the one I send
it to?)

Thanks,
NeilBrown

--Sig_/h/lmwTIPJ4dCSbL0zIIIknV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTwVSGTnsnt1WYoG5AQLL+A/9HGJSHzYRfXs6Xc9vfExx7Iazn1BDFL1h
xrZElQQWYErv1yfMaf/xg/kmpl7RPik8OHgV3zkdjmBjnR5eKKlb17f9t4PDVQGZ
/0ysYwEIz0fEIqvVFV4X/QhL+lSJ+36VrD54cwhoun301SvEdyXMKQ97V37dNIhg
IeSFUqvrQiwtcO/yu/YuOb7qLxSGRhqWlGEou+KpjVH2XUbmVfiEW4qXih+X0oDr
KJw2OWuWaRe6gNABgHyzUtuHY2K/nxBexblYdcf2ZhyZtcY8BTzQeN20TF3KdjE5
yIbqtJcRaKNNxPudHFMgGYVlB0Ig92rRrK72qqiI+al7kGkcre+UcE0UWluiOcQP
gg0gNqsoIgg2HJlDLMqr1BihYo2k0Kiymie6SwkJd6lEGUUHUqSu11IcPQTKgIx7
2weGTD5EZXHdt3qMqXi+KTTQ8sjP52HS57aTaX8JsRfkJGicxgOX863RNyCyfX5I
MITYQqrIE+T51+7ReOZaL+Lcp2qGg4rwucoxqTO8gwTJyjhvS+CHaP9WJxwGvTsi
/0wBvmcRbRiRRbpCIkgykW0wrwnGQG0jMxhdgc33vnnHfzOSstYF/NdZrgAb6+YT
qMdeYXK4q1JtUGkPDFVYZ7H/Yd258ePjZSb1JN2AGgWnVZ+Dg6eco1XULsfY1ZR7
HFQj81aGcUo=
=hOH0
-----END PGP SIGNATURE-----

--Sig_/h/lmwTIPJ4dCSbL0zIIIknV--
