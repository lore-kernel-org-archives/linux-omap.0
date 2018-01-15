From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 0/8] Add MCAN Support for Dra76 platform
Date: Mon, 15 Jan 2018 15:44:54 +0100
Message-ID: <fa6ed3c7-980f-fc65-e7d0-e085c201a8f9@pengutronix.de>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BScf6tjhFppgQSnMwIpwgAHu4d7xFcptN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BScf6tjhFppgQSnMwIpwgAHu4d7xFcptN
Content-Type: multipart/mixed; boundary="ZIcM16ZCezMnDgMkMOPFCVPWJkdyktE6p";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Message-ID: <fa6ed3c7-980f-fc65-e7d0-e085c201a8f9-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 0/8] Add MCAN Support for Dra76 platform
References: <1515581725-29242-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>

--ZIcM16ZCezMnDgMkMOPFCVPWJkdyktE6p
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 11:55 AM, Faiz Abbas wrote:
> This patch series adds support for M_CAN on the TI Dra76
> platform. Device tree patches will be sent separately.
> A bunch of patches were sent before by
> Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>. I have clubbed the
> series together and rebased to the latest kernel.

I've added patches 1-3 to linux-can-next/testing. But stopped at 4, due
to the problems with the error handling. You can include 1-3 in your
next posting if you like, otherwise I'll takes the ones I've already
applied.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ZIcM16ZCezMnDgMkMOPFCVPWJkdyktE6p--

--BScf6tjhFppgQSnMwIpwgAHu4d7xFcptN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcvmYACgkQHv7KIOw4
HPZUAQf9FJLjMUT/SVkH10O3O8DStSa3JRUSNJaIzNgxV/qbcOZYD4BQrPq015D7
UXXHIF8dHpDYYlrX7TVQSc5diCY+WQ8RwSS1JBEJyijsh/h5Bww4/2xnai0yz3CF
EFhbU8Y/4xUwd6YzwknetoccspRYJXomCld59Woneo1C3looaZs0DtiVaulPTfRN
vZXUzAyf106BhsdMBWGWJACOpWQVIpaWNGuDbLZ08U+b5c3xynZCuHWWHfw9G849
1ruQyqfgdZ8vvr3usj9UJvsIjjRyuiddJBnBTfIdmgDh8xzall3EhIUVwuYTztNK
MxXmlnn3uUxN+gNTQ859nuAT9Kc1jw==
=sXFh
-----END PGP SIGNATURE-----

--BScf6tjhFppgQSnMwIpwgAHu4d7xFcptN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
