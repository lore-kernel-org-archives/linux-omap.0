From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] dwc3: linux/module.h included twice
Date: Thu, 23 Feb 2012 12:04:27 +0200
Message-ID: <20120223100426.GQ18463@legolas.emea.dhcp.ti.com>
References: <1329328551-4957-1-git-send-email-danny.kukawka@bisect.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329328551-4957-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Felipe Balbi <balbi@ti.com>, Danny Kukawka <dkukawka@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2012 at 06:55:51PM +0100, Danny Kukawka wrote:
>=20
> drivers/usb/dwc3/core.c and drivers/usb/dwc3/dwc3-omap.c
> included 'linux/module.h' twice, remove the duplicates.
>=20
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

applied, thanks

--=20
balbi

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRg8qAAoJEIaOsuA1yqREtWIQAKB2gu7sabASrDPxXKoIcxv7
AVHIdNXa7LVYTR+2YiRX9voGytiq0xlQ62temoRgWjKVx/DN9rezzrUXGPYSGhsa
tRX3jNpai3j5uCcqqm9x5zOLgZOnOJsxnlUlHYtCNWegrOjqASm0nuquz11nmLKH
pCXRFBMscr57Ee5HiKiV2XpKK4dykqAGYlP1Gtjvsd25xWr+R7GLjNMaD+oFCzEv
F8P6ITB/RDMEozZnVbWSO4RBQbrCHzEYmMeKXqEWYmB1s9cxDzKCQXgPZavrHGWO
rx1+VYBdRcbhSjegufcCBTgkjXnWg0UGulVo8fjpktca5++nqxuXspKbLNf71j5V
Oi7cTbLUrIbKDQaLT9lE7oC+waihuzfXFUzPNLuPDXjsmG+lJIaSnPuNpwWKUbRN
XG1WFFUYtcoxRMDAMKbGfcQbd3O+pcNejlU/5aw737myCK+QA0otnHHsOYw9iQfU
Qq38LJpc2F16FwBE26PS8rSp3JHy3PFCCm2GrDkUMEmmatFx2kSpZiiNgO7oJI/p
fN7wvHzM+2P/MVGaZDFgPI9XD/8W2UsQgGoC2VIhNL/rhsrPodi5qH5V3N4QClGl
Qa+74aoe4BDoEL6YG8Zwr5cTCcZ3wdT2QZwzLsxiq1x+uv7mh+EqNwUQJ1k8uJrQ
WyPSlaQRKuJalsgNxAQ1
=vAIQ
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
