From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
Date: Thu, 8 Jan 2015 15:25:38 -0600
Message-ID: <20150108212538.GU31926@saruman>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoibaoN3dya3u5fy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbbAHV0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 16:26:38 -0500
Content-Disposition: inline
In-Reply-To: <1420751680-21230-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--FoibaoN3dya3u5fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=3Dy
>  CONFIG_DEBUG_GPIO=3Dy
>  CONFIG_GPIO_SYSFS=3Dy
>  CONFIG_GPIO_TWL4030=3Dy
> +CONFIG_GPIO_PALMAS=3Dy

other than the power button, do you have anything else attached to a
palmas GPIO ? We might not need this for boot.

--=20
balbi

--FoibaoN3dya3u5fy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrvXSAAoJEIaOsuA1yqREoJoP/jG1wYYG6RPpCUeiKI2M1Z2l
GUUE+82OxCIChm2akzNIDhVAEiaaXKJADLUtS8cRe+g60TZQa6rWQnVTGT0Zx2Rn
bTKnn+SjsvpQ4raFreFr7NTxQXKs9YulXBdZnb7IVqm/4K5Gnt0N/GVd6hn4QHrf
0U8W3n/RyDwTG00xfQzlS9cPJFevKthIgAKZPXi2nx2MZWJTa2xdAmBX+iHKqjR+
r3ZBv7p3flrAi9Yn7B4AWZgRr0pF4re43bF+ET2EQWAprJ9iNBTOyIjja6mTfrsY
c8Rylu7mlor4l0grinm/bp4jbXvWEBJRTwmKLOCI/3MEQHbdDOWgT1x5fFGUzmMB
zYGEZemRx3RrYaZogq+aAQBNAutfjJQFdIqpzdQJ8qN+K3ntVxa59yYmwm/ukbD3
X0FJEKNUONR3x/QbDASfVRYo3hjXxcdVy9arR7s883JOPujJtY4C+8QfGkpQeiyp
WCDtN72no37t074jrWAnqdFOZcr6xhgtBvaqgYppU5Q1dGRxYy2L/QFsqMc2HUbo
/nWlQNwNLEwrcvPgQBPW6govTdPsaKI8V47uoOqftbgaIBhqzpB28wrBFXBMRqH7
anxnML8iSEG/IV/GGEcZ8Ba3MfHo7ipM1a53fiYMB4NyFmCzSpu8OsJRGGz1ZV1n
0raefnxejFV/3XXxNUOn
=z5kH
-----END PGP SIGNATURE-----

--FoibaoN3dya3u5fy--
