From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/1] Possibly fix USB OTG on GTA04 and N900
Date: Tue, 8 Oct 2013 18:04:42 +0200
Message-ID: <20131008160442.GA14263@earth.universe>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381152493-28055-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, pavel@ucw.cz, aaro.koskinen@iki.fi, marek@goldelico.com, balbi@ti.com, tony@atomide.com, kishon@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 07, 2013 at 04:28:12PM +0300, Roger Quadros wrote:
> USB OTG on these boards might be broken on Greg's usb-next branch [1]
> after the Generic PHY framework and associated patches were merged.
>=20
> This is a probable fix but I'm not able to test these boards. Please
> give it a try and your Ack if it works. Thanks.
>=20
> [1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

I have tested the Nokia N900 part of the patch. Without this patch
the USB port does not work:

[    1.015014] musb-omap2430 480ab000.usb_otg_hs: unable to find phy

With the patch everything seems to work.

Tested-by: Sebastian Reichel <sre@debian.org>

-- Sebastian

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSVC0ZAAoJENju1/PIO/qanpYQAIZZoBL5qeQXW7O+SSvaH4kf
ap4PVDBJE0Y/74OTFewJKOjeUe/smcMpDixCebLy+MHv+XVuYE1fqyA+NCpwIrD9
Sjv67U3E9oE1c5qj/pObv/YjsIvqZePGiIm0KCkvmnV9AsM1jZ5fa8Vf0mX0CKP4
O9PNgu4CsLpZ0ncsdahOKV7jZfdm41SN1g/MwxW52CEyFQY7TUmC0P0F7bU8rb2K
9QOzyiWt8CIvDuLSGC77xcUUsyBmmS62ArsT9hFHYgKHOB58ENe+wl/xIu8P9y/6
lGH14VWRC2AT18wSEx+yUh68TB5q6tvYgjJvO/7dEUxPEvU6ApQunPQMNWbXZ/BG
Jv3kcSTAWNvTzLWjIFk9UNn7nz29/XfPdhEjSAbUS6jecS18/xqDcDlymkhGOReG
VRWuzWXrPH4gHKHdvZLpLLmufsk9tkR5BcuZfXu1lBDazCCR4IiK2jZZd04OADWp
3ASdEdqCALcoi+i44US6PcgMXB2vZ0qPy6BSuLhaciQIPAtFa/2G8QkTZhiUqp1T
KvXgtG98rlNY3IgD5+ZfVEMkBPYbs+FGSFrBqECzzVhQNwnL3CIp4cUgnbKoTDRa
7+jLKyPFIuSIAmScbeX1+cwXiu5bABEgPTNA7OAWmCM7309xwdYhf/e+kwo1wch/
9UcjUa2eaC5+AIZQdN6i
=lAjt
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
