From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7x-evm: beagle-x14: Fix USB Peripheral
Date: Tue, 17 Mar 2015 09:54:28 -0500
Message-ID: <20150317145428.GA5001@saruman.tx.rr.com>
References: <1426585431-29914-1-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbbCQOzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 10:55:13 -0400
Content-Disposition: inline
In-Reply-To: <1426585431-29914-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 17, 2015 at 11:43:51AM +0200, Roger Quadros wrote:
> Now that we have EXTCON_USB_GPIO queued for v4.1, revert
> commit addfcde7c485 ("ARM: dts: dra7x-evm: beagle-x15: Fix USB Host")
>=20
> On these EVMs, the USB cable state has to be determined via the
> ID pin tied to a GPIO line. We use the gpio-usb-extcon driver
> to read the ID pin and the extcon framework to forward
> the USB cable state information to the USB driver so the
> controller can be configured in the right mode (host/peripheral).
>=20
> Gets USB peripheral mode to work on this EVM.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

on subject: x14 ? other than that

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCEAkAAoJEIaOsuA1yqREQmgQAKac4t4FkFi/zMz14BSMdj3E
oblWTNNQ5lc1qBfPXLYVIdyyU2cnGl0uRyIN9BuQk/V+MUsM3gXk7I6ENRsdTizk
ynFy4Zfh7Edw11Ct5iMMLx+gBhlGKRc+h5UedEnnTztJnxUbxPvVX+jITXau1kDq
YH1f0jCH9sAtejt3fKIxgWOSrI6R4pNmMV6mkMoXH/CE9kZCspq8beSDGQDzWwIr
3tjJql8vgHC8RlPNiKHBeCwosXJsSgU12OV3ntlf/ZnbMLyVbJw9TCeqWwFIzVAf
ECfXD47CXwcEWeBbXlUGjiG6ukkiQ3TVGMZVGXdxGwk8kQjrbYepuUUGP9mOznO2
IXud2pqACxzTwnkXqt5Q+2Kz1KAgHJxVifQdC+vQMVBGPgR2vxPbA4Tftn7FlqG8
EEZo4eYDGaLeXvSpj7J273vAhln8ONvbcnCopz5MZzBbYhDhFQB8NkJV8vsSiz6V
Ky/g8KdecBgZxB1os56+4eXzgTjSPA6ttLAstYDi87N8tL1+eZl9cXM1PePNqlm5
/+VO0eoGij/rFhTAhYjgjtboYtLp3ninqX+6ul83iU4Hvbh8/W7/S/GxI9OYQEBq
U0O01Y0eQVbAeeQ2+Du6RZ6lzD/cPMiRCduOvmDeB+cF3FGTFfgG0hi8QL2lQZcM
JN8H1IlpU6mtQyUo0ZO/
=5Lwk
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
