From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 10/12] usb: phy: qcom-8x16-usb: Replace the extcon API
Date: Wed, 30 Nov 2016 12:42:08 +0200
Message-ID: <87vav5mepr.fsf@linux.intel.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com> <1480485460-2663-11-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1480485460-2663-11-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch uses the resource-managed extcon API for extcon_register_notif=
ier()
> and replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlg+rQEACgkQzL64meEa
mQbHQBAAkHgsJpqwzZjg0zQOE/2YIN6Ey3yJxmsH2pMMNl0pfxWgeovxfckXnx7n
JKe6vSgPenixprb0aFdqvP9iflfOSe621F+SaKfoKuf1/Yy02h22DOl99JwpGJYx
/HIb+NG3T2OaOsYkxoIQjaqoqbVJ8ZTquQUgnUn2NOId6xqkU5riPIXgvJq+PE5P
+g3wf7N1GF4WNvpBng3XhkVnDdkgpsaPRMLnA/L2bykDrUWQnYcyxZkfBl0tgCjj
glsw2sSEbO9Y5r9QMyRF6/rpgJHZbISZdmyljytVGVVGtFtmxYrFw1+79XQTPBqE
tbsG4wG4ehFaNCXI3dyirXfNzTAQBxLDUx0XNsek0CFi9yuVtzp0EGRVOwjnYI96
Ibgl0XqfZLTLcNyezx6F4HIyPt2eN0lX8RyT+GiVm1rWKfcLxg6Uwmqt4YDU3Psk
8ay9cN4eEnXREeSupjP7XNo3QbqrAFwDxuy1vJy1aNVdNmzrzMYVrpjgtxYqz61S
ejauss9JmTw8lwuAffOmHVvjWMDRc+ePoYzljYPj8zT9PBhlBrvJFAthpdjp11q5
07rvIhUci3mcIWLFwwD2x0IQxtGSiqhW/MKrfsipgjhygsGml2CnmY8TJLfY9/xO
97BgKAjVPxZYGX/u/XjzGIffVL3fGcN+1+UoShKpytY6u59bU9o=
=d47u
-----END PGP SIGNATURE-----
--=-=-=--
