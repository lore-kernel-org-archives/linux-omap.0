From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 4/8] can: m_can: Move allocation of net device to probe
Date: Mon, 15 Jan 2018 14:52:35 +0100
Message-ID: <480602fa-db66-d5c3-056c-e61e5d0f2afa@pengutronix.de>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-5-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="akSF5ruHBbcT5gKyb02X5q7S53CezsxV5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515581725-29242-5-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akSF5ruHBbcT5gKyb02X5q7S53CezsxV5
Content-Type: multipart/mixed; boundary="fXzetqdQFUxgwEebKAG2vX8pQTe08WApW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Message-ID: <480602fa-db66-d5c3-056c-e61e5d0f2afa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 4/8] can: m_can: Move allocation of net device to probe
References: <1515581725-29242-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <1515581725-29242-5-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
In-Reply-To: <1515581725-29242-5-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>

--fXzetqdQFUxgwEebKAG2vX8pQTe08WApW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 11:55 AM, Faiz Abbas wrote:
> With the version no longer required to allocate the net device, it can
> be moved to probe and the alloc_m_can_dev() function can be simplified.=

>=20
> Therefore, move the allocation of net device to probe and change
> alloc_m_can_dev() to setup_m_can_dev().

The error handling is broken with this patch,

Have a look at the switch (priv->version) in setup_m_can_dev(), you free
the m_can_dev in case of error, but exit with -EINVAL in the beginning
of the function. setup_m_can_dev() should not free if it doesn't allocate=
=2E

The error handling in m_can_plat_probe() is broken, too. If
pm_runtime_get_sync(&pdev->dev) fails, you don't free the candev.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fXzetqdQFUxgwEebKAG2vX8pQTe08WApW--

--akSF5ruHBbcT5gKyb02X5q7S53CezsxV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcsiMACgkQHv7KIOw4
HPapVggAhxFcJN45S8L15Q5gq5GFHKDUqlHAHfH9J5f7VvfyVBRyejJVduT+UX27
vgSoGnPaqb5VENFSytlrEwVIWEu1d81m4y58wtdJo2yo0MW3A/ln0QDd+cIVP4CJ
q9Yfmc2o0/Cb2oNojxjNQWPPAHkc1S20o9TLFoStGOk+Fe2Un32bg7iLfPWAx1z6
yqsceEu8aidvt9WenHttxuS2KJHp9XyCVVwMCyDDL5vLMwl78HH2NkZR+u3uLzqy
Z0vwgTVrEGocrDwREVsuFESO9LcTSlRtVYo1kz0PdAMY+liCXwNDYGyi1zyLiNfy
ncS8Rrd2XTgHf0mTYElLWusWCHBdkg==
=eFGr
-----END PGP SIGNATURE-----

--akSF5ruHBbcT5gKyb02X5q7S53CezsxV5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
