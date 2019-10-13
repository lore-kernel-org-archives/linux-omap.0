From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 8/8] ARM: OMAP2+: Initialize voltage controller for omap4
Date: Sun, 13 Oct 2019 17:08:15 +0200
Message-ID: <20191013150815.GF13278@amd>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-9-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2479985975132430250=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-9-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2479985975132430250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 17:12:24, Tony Lindgren wrote:
> We're missing initializing the PRM_VOLTCTRL register for voltage
> controller. Let's add omap4_vc_init_pmic_signaling() similar to what we
> have for omap3 and enable voltage control for retention.
>=20
> This brings down droid4 power consumption with mainline kernel to somewhe=
re
> between 40 and 50mW from about 70 to 80 mW for the whole device when runn=
ing
> idle with LCD and backlight off, WLAN connected, and USB and modem modules
> unloaded.
>=20
> Mostly just rmmod of omap2430, ohci-platform and phy-mapphone-mdm6600 are
> needed to idle USB and shut down the modem. And after that measuring idle
> power consumption can be done with reading sysfs entry every ten seconds =
for
> /sys/class/power_supply/battery/power_avg. Then rmmod of phy-cpcap-usb wi=
ll
> save few more mW, but will disable the debug UART.
>=20
> Note that sometimes CM_L4PER_UART1_CLKCTRL at 0x4a009540 does not idle
> properly after unloading of phy-mapphone-mdm6600.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jPd8ACgkQMOfwapXb+vKc6QCfTInHiCOojLoYl+MSblD5nQ+O
DR4AoKLHNZ8Zwjp6K/Te03yOdXiHsdQx
=5UcY
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--


--===============2479985975132430250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2479985975132430250==--
