From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/11] Exynos7: Adding USB 3.0 support
Date: Fri, 21 Nov 2014 09:11:30 -0600
Message-ID: <20141121151130.GD7508@saruman>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60722 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879AbaKUPLV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2014 10:11:21 -0500
Content-Disposition: inline
In-Reply-To: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com

--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 07:05:43PM +0530, Vivek Gautam wrote:
> The series has dependency on
> a) "[PATCH v7 0/7] Enable support for Samsung Exynos7 SoC"
>    http://www.spinics.net/lists/linux-samsung-soc/msg38734.html
> b) "[GIT PULL] Samsung clock changes for 3.19" - specifically the clock dt
>    bindings header.
>    http://comments.gmane.org/gmane.linux.kernel.samsung-soc/39142
> c) "tty: serial: samsung: Clean-up selection of number of available UARTs"
>    http://www.spinics.net/lists/linux-samsung-soc/msg37418.html
> d) "dts, kbuild: Implement support for dtb vendor subdirs"(merged in linu=
x-next)
>    https://lkml.org/lkml/2014/10/21/654
> e) "Samsung pinctrl patches for v3.19"
>    http://www.spinics.net/lists/linux-samsung-soc/msg38744.html
>=20
> Tested on Exynos7-espresso board with 3.18-rc5 and above dependencies.
>=20
> Clubbing the pinctrl, clk, and usb driver changes alongwith the dt changes
> together in this series only so as to avoid having 'n' number of dependen=
cies.
>=20
> The USB driver patches in this series were part of [1] sent earlier.
> [1] [PATCH v2 0/4] usb: dwc3/phy-exynos5-usbdrd: Extend support to Exynos7
>     https://lkml.org/lkml/2014/10/7/191

I took dwc3 driver patches.

--=20
balbi

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb1YiAAoJEIaOsuA1yqREyl4P/0fQmqSnGXnX25uUiNXcnFLL
TtQthuYr674d0JJ+wNi9uaONTWpZKnr20JLNvV9gkFt/yh2w6N6GFBwvhVGLqTMn
wkjccayRKHVM/c5Zr8z/+sQQeEPpXXGKOSC8lLZ5nv3FQWL43lkNflFog+Ej6dGy
cMT43xzBGLoAxwdSh8JdU6uryDqv05i7viekAo/VSy09xFRbabgf5WIXsMjjZinn
2Cf7ITObEn/G1uSfMBnRc/quyTIgXmt/g2WDUsxyAwn97glNYTYNPwa42X+YRMIU
2lOu8Ux7/5gkEBsDhV76RsRUEkgwdyeLaD1zivBmOG7Y3UVyfupyRJ/aH3L2epYr
AgfEC83+B09fz3sTCOusuzn1tJcC35eQ3dm5ahJrAXXhoOtK6lJheEzy7C88m78L
zxKqnS0Wx3VKr1LSfGcTQ+MEw02JXQvTJGgVhoFhStXy0igVhBROeWocFjD6Y+Gf
Jha9o4WBMKxOMkJd5qpTGH5WdY/BzcLpsvsDwXF+vPoXNZjjVnJ8syRzDp6S5zNO
jqp7xfri3pnQ0aVXYWf1aRf9BpoMSfrkIUohxWNcZNLfxBnu5TVtxpAmCqwfq2xQ
dKwJxOw7bkj9Uo6SeIZ/qTcUHgVtiVXwJOi/jxKSrc8L7gDSRmW+tKhq+9YZyCRK
s4+xieUDSvlVd5OJgaI+
=RxWf
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
