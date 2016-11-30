From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 12/12] usb: renesas_usbhs: Replace the deprecated extcon API
Date: Wed, 30 Nov 2016 12:43:39 +0200
Message-ID: <87poldmen8.fsf@linux.intel.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com> <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, cw00.choi@samsung.com, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlg+rVsACgkQzL64meEa
mQb/WhAA0sSM3coKRSXBr8sUHuz8nXjwXC5EqmSKYJoDlxlLeEsaEDsH1zf8kwTN
cgVZ7kOVUPdscjpcHeCVh6uNzxCm66s/rO+zio+qlIo9ylBsbhRbjz4bDa1Hh+43
gt6uq0GOF7VmA+x7FOrf6mdoezXPUrBIxh7Dj41BqW23unBx6HM/D235XILj7AeL
qDOBhCEpy3vls2USBep5c6TJiz9HB9zuRkIvMYIs2J+6eRUgPLxjDnyue9ffmHpm
tzaGZs8xqkDOnobhlehXA20r23jO4M557Bc6sukpCeJxYBb1592h1EZcP41eSpsS
ooyBebc1VitoFun5WfxZPG7Kz9w13wdIJR69LXr4EkPUajWP8STVvwaRuM/S1UAx
6yp4o/TXhj6RkJ/WV9YR/d5nFU08pnC/bWF96c/fVXWKLAMuZrzkE967qKa0GYo1
OmHQvVyjmo1AQN0c1JWsfUhnC8GNwBjIX5ZixW3MLWzmjHCURgdx8jgepDziR8V7
AZywYUp9llgoPPKvl00g1OEkHnEKfARIrSKZW7UNUQFFy4lJmZpcUkqVwvCJ6blj
AWUaGhVYst3BVk4KYl9x3SoJ6TYyK86tcs3O2n6cpqoPTmUt3uS3s/Hjj6j769PG
HAYb9mEJHVmFwtIuJ0ooRjFHhwDS+ju5J9XOwmrEs3i18nycmog=
=Tb5p
-----END PGP SIGNATURE-----
--=-=-=--
