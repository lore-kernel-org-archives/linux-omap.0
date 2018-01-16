From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 3/5] can: m_can: Move allocation of net device to probe
Date: Tue, 16 Jan 2018 15:00:25 +0100
Message-ID: <1dcb2038-cc6d-44e5-fe51-e43041b1fe5f@pengutronix.de>
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
 <1516102634-6771-4-git-send-email-faiz_abbas@ti.com>
 <caa11848-3c69-1229-e4b8-09e51cebe739@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n61MLG9MW0N4Qg60qaYOVa0GuRCAnzRkg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <caa11848-3c69-1229-e4b8-09e51cebe739-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n61MLG9MW0N4Qg60qaYOVa0GuRCAnzRkg
Content-Type: multipart/mixed; boundary="eKhm3KutavnApDCimxe8BCvzsjJ3n29ig";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Message-ID: <1dcb2038-cc6d-44e5-fe51-e43041b1fe5f-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 3/5] can: m_can: Move allocation of net device to probe
References: <1516102634-6771-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <1516102634-6771-4-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <caa11848-3c69-1229-e4b8-09e51cebe739-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
In-Reply-To: <caa11848-3c69-1229-e4b8-09e51cebe739-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--eKhm3KutavnApDCimxe8BCvzsjJ3n29ig
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 02:03 PM, Marc Kleine-Budde wrote:
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_c=
an.c
>> index 893edbb..ebb74de 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -1207,25 +1207,20 @@ static bool m_can_niso_supported(const struct =
m_can_priv *priv)
>>  	return !niso_timeout;
>>  }
>> =20
>> -static struct net_device *alloc_m_can_dev(struct platform_device *pde=
v,
>> -					  void __iomem *addr, u32 tx_fifo_size)
>> +static int setup_m_can_dev(struct platform_device *pdev, struct net_d=
evice *dev,
>> +			   void __iomem *addr)
>=20
> Renamed to m_can_dev_setup() for consistent namespace.

And removed free_m_can_dev(), by calling free_candev() directly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eKhm3KutavnApDCimxe8BCvzsjJ3n29ig--

--n61MLG9MW0N4Qg60qaYOVa0GuRCAnzRkg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpeBXkACgkQHv7KIOw4
HPZJuwf/Z1tL2ijIV92dXMyr5IJMB6yPrb7ZbmcDxR2QBi1blKG/M8aDm9kvsHQs
a53i7popXcyD4K9sH5FxL91L1AcGdGdAx0t04XpZizCK4FsWrNt1mGPB4Ir7YftZ
ynJOZmCFEWUpvyJeB2S9r/EattQK3w/QbYHKYGl3KyV/uFt1fFDskptJDcGc1YA9
dgWjWCbaQgeLzbADwnaUD8tPNBEcsBeAnrHI4E+J6c0n5jC42fIvwR+MArer5qrx
ZbUN26xdf027Vd26cM7Q9Hz0lMxfydKCgnTW5q0tTLJ6IqZBv9uuBiz7C9/ALqIl
fBhRT2XjFC/tH/uPi8hZs1ra4xUrZA==
=d7NX
-----END PGP SIGNATURE-----

--n61MLG9MW0N4Qg60qaYOVa0GuRCAnzRkg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
