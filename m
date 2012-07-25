From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 2/4] mfd: omap: control: core system
	control driver
Date: Wed, 25 Jul 2012 14:07:15 +0300
Message-ID: <20120725110714.GF16794@arwen.pp.htv.fi>
References: <500FD2EC.7060208@dev.rtsoft.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <500FD2EC.7060208@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 25, 2012 at 03:05:16PM +0400, Konstantin Baydarov wrote:
> This patch introduces a MFD core device driver for
> OMAP system control module.
>=20
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.
>=20
> Device driver is probed with postcore_initcall.
> Control module register CONTROL_STATUS that is needed
> by omap_type() is early mapped by postcore_initcall_sync.
>=20
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

I believe this and the next 3 were authored by Eduardo. Also missing his
=46rom tag.

--=20
balbi

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD9NiAAoJEIaOsuA1yqREqEIQAKCZNQcd5Ml8dSKdj9kWOI9P
i59gEl8sLjosR1xlVtP8yPH9kvqMAIqHLo2Vt+/ZIgDz0r/ydVRHxfj8ZxaWvxM2
WDGdPLDox67X8W/VNQ3K17EkuwVHVfh+1CHz+XpFZXPAFAMbeIR0AH7+KHiLQ6+g
u+GnJWsITJB6+0TrbIT1/Ti7FnJ4MLqurwKRgnci/k1GDA4boBOvmQUml6rrWbCn
DgublAE7ka4+6cK/1yrbEQK4vrWFLNm74aDgMV9v8CPIntY3iwuv+ceFSEtmKWY+
kRl+J+RkjMqaiWn+rNFsQA2iLXGsUtAp8JtJX+cDCg25mzL//drfJSbYK1rM/S7M
t+Sw1oEJsviMnAJyyctc6emgwXlJmy8wngsrHPCsq/B5buZSdsNtZtDeMA563TL5
1n9Obp1zydsAvCeOOjV/8e45f53JD2jLwOX+mbMl8WLX35QuufO+veYTzhr7q05U
lig00BDfkghlYL7IFAY1Px9nV88EvvlIwGCF1dhT+lcTGHUzDkQ2ZsdWV0lNn9lI
SVs5iXE+UXOYBBmREtD4qz1RAb/Vr4i5BpU29LK+rESbqylUHzHCu3nvoL0WM9Pc
6sSfvjqKaVXvev4Lrzu8og+DQthwDD2p4/28GGkNfxMHcFA2gGA6e/SD1xvMvJy9
PlNCWbM6p9fSqa30KJHD
=QgAo
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
