From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 3/5] can: m_can: Move allocation of net device to probe
Date: Tue, 16 Jan 2018 14:03:04 +0100
Message-ID: <caa11848-3c69-1229-e4b8-09e51cebe739@pengutronix.de>
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
 <1516102634-6771-4-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o1aPLotbbMXjHPp2RnqVJj2cKZ75drpM8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516102634-6771-4-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o1aPLotbbMXjHPp2RnqVJj2cKZ75drpM8
Content-Type: multipart/mixed; boundary="zXE1HVfUEdOMgWGlHp6qV7D56LI6xAhSz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Message-ID: <caa11848-3c69-1229-e4b8-09e51cebe739-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 3/5] can: m_can: Move allocation of net device to probe
References: <1516102634-6771-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <1516102634-6771-4-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
In-Reply-To: <1516102634-6771-4-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>

--zXE1HVfUEdOMgWGlHp6qV7D56LI6xAhSz
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 12:37 PM, Faiz Abbas wrote:
> With the version no longer required to allocate the net device, it can
> be moved to probe and the alloc_m_can_dev() function can be simplified.=

>=20
> Therefore, move the allocation of net device to probe and change
> alloc_m_can_dev() to setup_m_can_dev().
>=20
> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/net/can/m_can/m_can.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 893edbb..ebb74de 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1207,25 +1207,20 @@ static bool m_can_niso_supported(const struct m=
_can_priv *priv)
>  	return !niso_timeout;
>  }
> =20
> -static struct net_device *alloc_m_can_dev(struct platform_device *pdev=
,
> -					  void __iomem *addr, u32 tx_fifo_size)
> +static int setup_m_can_dev(struct platform_device *pdev, struct net_de=
vice *dev,
> +			   void __iomem *addr)

Renamed to m_can_dev_setup() for consistent namespace.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--zXE1HVfUEdOMgWGlHp6qV7D56LI6xAhSz--

--o1aPLotbbMXjHPp2RnqVJj2cKZ75drpM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpd+AgACgkQHv7KIOw4
HPaqDAf/bOYg93siMGmH8x6OFZncBB3PXfr0LyBUF45Nz/IbYHE7WCQhEwgsDNi3
Ionl8CtPmnWjEnfCrDdcXHZVMoGocT5ASV3RJPK+k0qOxWdnOrltbGODhd06HMxf
HttRQ0DxtBXFbo2gZLkyA6LpFcH5Smr9Ks5MQWuOQawAJguZvmNck9rQexdeVppf
2WYzbc1+mSVGKYWvLgTaG1t7/JFxlyhPwb6fRf9gZmsNkaYiH4qOeMSDufFI3GhC
whdW2GDmqVja2Z81blPeId7/T5lITPdRAPStrnOLY9vnsFAnP4SnD11CAOeHzspo
MNyesZr5VUis4FQw/2+onntuAG3R5A==
=uwMT
-----END PGP SIGNATURE-----

--o1aPLotbbMXjHPp2RnqVJj2cKZ75drpM8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
