From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Mon, 5 Jan 2015 11:27:37 -0600
Message-ID: <20150105172737.GK19336@saruman>
References: <1420475549-28492-1-git-send-email-nm@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34774 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbbAER2a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 12:28:30 -0500
Content-Disposition: inline
In-Reply-To: <1420475549-28492-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org

--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 10:32:29AM -0600, Nishanth Menon wrote:
> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> Provide device tree node to enable the same.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> V4: Change format of the speed-map used.
> V3: https://patchwork.kernel.org/patch/5562121/
> V2: https://patchwork.kernel.org/patch/5445111/
> V1: https://patchwork.kernel.org/patch/5444911/
>=20
> Enable and disable can be controlled by (post the RPM, it finds
> closest match - even a 1 will do)
>=20
> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> and
> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
>=20
> Test log: http://slexy.org/view/s2T0ajh46z
>=20
> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational

oh, perhaps add these as modules to omap2plus_defconfig ?

--=20
balbi

--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqsmJAAoJEIaOsuA1yqREMlsP+gMydj+y5LJ8q5GxVpr6C4z6
jF178oYRxDzkto1pK3lkW34qAAXCNPg4qTipniyo1sluEHWewYn6zpWK0ZXrQoKO
3cWjLiOKozZOO60mbCe24zaWAn57QIoZcEj/MPlGwEzoqRSDoVQ7qAZwtsz2EoNd
4HwDtdjSQfxwJKY2K8jgSSahrb4y9EroHTrd0Vd2ARF1t2daSoM69XLCD9lZTyFw
dsgRKHy1+n+umobfU4PFo3uMVbscuryymtoTnMRjmgwVCIacvd430b5LTilU2w0b
V3lEtvtfFaIcSxhwFrZFvBnuOGd3e3vmr/GT4gyp9Vk+qlIV71/hCnF6/5h4t6Zg
46NMLPKY1gycWRJudUYRhAku7EwjVQLJ52MBS41p/r7/O7VxfAHawzmacsdFXk/5
drvfm21BIGccYfC0LYKQhf8WkcpbuaqysuccWvHkT1jtcTMWQOS9crdh2mAdohVK
vzC6LXpfdL4mCuEG84necsqq/Iy8+NoQ2XLxZS4FLUT/K8yBNYOvkcwjllcYWZgL
rV3U4Pg/riPptrKgAHdIPF88Oax+/qj4JClsxhgC9URyTNHocQUP89ezSSMyy8+K
nq+DLhcWFXuRIx3p86fHRPifC/XCldsECd99HXNuLAzVyk40Jre9cOkZhmovZpg5
GLCdeq4DkSjKiPwQ4U+H
=yrLb
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--
