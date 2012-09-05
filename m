From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
Date: Wed, 05 Sep 2012 13:54:58 +0200
Message-ID: <50473D92.9000500@pengutronix.de>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF8B7ACAAC025BE2A343A9FC"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF8B7ACAAC025BE2A343A9FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
> Adds suspend/resume functionality of d_can driver along with d_can
> raminit support which is required to initialize RAM while data
> transmission.
>=20
> This patch series also adds pinctrl support to c_can driver. These
> patches were tested on AM335x-EVM.
>=20
> This patch-series is based ontop of runtimePM patch submitted
> earlier - https://patchwork.kernel.org/patch/1348081/

Looks good, I'll apply the series after Tony acks the patch 3
([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
pass d_can raminit).

Marc
>=20
> Changes from v1:
> 	- Incorporated Marc's comments on v1
> 	  * Changed marco name with units in it
> 	  * Used ndev->flags for link status instead of new member
> 	  * Added BUG_ON inside *_power_down and *_power_up APIs
> 	  * Added new member "type" in c_can_priv struct for keeping
> 	    dev id details/name.
>=20
> AnilKumar Ch (4):
>   can: c_can: Adopt pinctrl support
>   can: c_can: Add d_can raminit support
>   ARM: AM33XX: board-generic: Add of_dev_auxdata to pass d_can raminit
>   can: c_can: Add d_can suspend resume support
>=20
>  arch/arm/mach-omap2/board-generic.c    |   40 +++++++++++++-
>  arch/arm/mach-omap2/control.h          |    4 ++
>  drivers/net/can/c_can/c_can.c          |   95 ++++++++++++++++++++++++=
++++++++
>  drivers/net/can/c_can/c_can.h          |   10 ++++
>  drivers/net/can/c_can/c_can_platform.c |   79 ++++++++++++++++++++++++=
++
>  include/linux/can/platform/c_can.h     |   36 ++++++++++++
>  6 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/can/platform/c_can.h
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBF8B7ACAAC025BE2A343A9FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBHPZUACgkQjTAFq1RaXHOBgwCcD1Yfjm/arRorT+doe7+MICnm
QDoAn0VaKiQR6LF4+ket+CXbcMjLFuom
=KoTN
-----END PGP SIGNATURE-----

--------------enigBF8B7ACAAC025BE2A343A9FC--
