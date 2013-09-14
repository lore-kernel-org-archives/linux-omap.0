From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/4] Add support for charging battery in Nokia RX-51
Date: Sat, 14 Sep 2013 11:38:44 +0200
Message-ID: <201309141138.44950@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2221749.PzqJghzPj8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>
Cc: Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

--nextPart2221749.PzqJghzPj8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 08 September 2013 10:50:35 Pali Roh=C3=A1r wrote:
> This patch series finally bringing support for charging
> battery on Nokia N900 (RX-51) without any proprietary Nokia
> bits in userspace.
>=20
> Pali Roh=C3=A1r (4):
>   usb: musb: Call atomic_notifier_call_chain when status is
> changed power: isp1704_charger: Fix driver to work with
> changes introduced in v3.5
>   power: isp1704_charger: Add callback function set_current
>   RX-51: Add platform function and data for bq24150a charger
>=20
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   56
> +++++++++++++- drivers/power/isp1704_charger.c              |
>  107 ++++++++++++++------------ drivers/usb/musb/omap2430.c =20
>                |    3 + drivers/usb/phy/phy-twl4030-usb.c   =20
>        |    2 + include/linux/power/isp1704_charger.h      =20
> |    1 + 5 files changed, 117 insertions(+), 52 deletions(-)

Hello, can you review this patch series?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2221749.PzqJghzPj8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI0LqQACgkQi/DJPQPkQ1IGJACfXYZ9JtqJAGRscYKVA2sr0pTY
y+EAoLv/ZHcGHhw9KB3yKfYgluu+AjLv
=Q/Zx
-----END PGP SIGNATURE-----

--nextPart2221749.PzqJghzPj8--
