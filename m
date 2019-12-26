From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2] phy: cpcap-usb: Fix flakey host idling and enumerating
 of devices
Date: Thu, 26 Dec 2019 11:45:31 +0100
Message-ID: <20191226104531.GI4033@amd>
References: <20191222180019.55417-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191222180019.55417-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-12-22 10:00:19, Tony Lindgren wrote:
> We must let the USB host idle things properly before we switch to debug
> UART mode. Otherwise the USB host may never idle after disconnecting
> devices, and that causes the next enumeration to be flakey.
>=20
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> Cc: Sebastian Reichel <sre@kernel.org>
> Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

But it does not apply on top of 5.5-rc3 AFAICT.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4Ej0sACgkQMOfwapXb+vIpXgCgpw8ow7BAI9AIa4DhiKn1Aloe
6RIAn13zm1SNFtJWZ+ZLsyiIZou3MwFe
=eChF
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
