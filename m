From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: dwc3: gadget: warning on v4.3-rc1
Date: Mon, 21 Sep 2015 09:41:50 -0500
Message-ID: <20150921144150.GB9144@saruman.tx.rr.com>
References: <55FFBA83.7010003@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55FFBA83.7010003-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 11:06:27AM +0300, Roger Quadros wrote:
> Hi Felipe,
>=20
> I see the following warning when g_zero is loaded
> and USB cable is plugged to host on dra7-evm's USB1 port.
>=20
> It happens only once and no longer appears on re-loading gadget
> or plugging/unplugging cable.

already fixed, -rc2 should have the fix.

thanks

--=20
balbi

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWABcuAAoJEIaOsuA1yqRE8IsQAJ7/HLbHKUMA0OOz/KtzF48z
hEl3FcWGB4h6L7sTesmBeNZBGJ+heJUSVLXRIfhhU4PUC7cmehm3z8auwKH6z9ic
2CGNC67ebn06BBQr2QsOkz8G19wO9jW2JHvnYTSOq2Ktc32RaLOoD5EUF0qKusgA
NmZ1ax98Ezhp2iCKxtj3Cawty8VBRD0pJWwpTZNC19kzBfXegEr5iOaLsQQYRbPJ
2mrn3CsW6FF0bfcs/YSQqdtpv/x2KR59CXU0A32tZarikdT8kASxqUf7YoooGnpw
m9R6QYeYkItacswHIAZyDyyi3dBK1SOBCw5zj70RfNE/Abs+B57MXddDozD4WWez
+Ydk5NnQXcYSkNHoSn1d0at02oVzws+vdeMFV4H8aDYCOzgtCFAGsrR70tQErWvA
Ox7gczBjbMy0JCud+KmwbptB0j2r9XlkIyw5R6zk3QKjknkKVAbTbpwzmpWv+Sm2
+ktdY71iIi/lBpp9unpd0x5B1udFFAw+MiiBHXe3Ujqj+e6lbUGKwbWO7SuW9UQD
jT/NY7KDxwIqvVyP1N4K6/7ihUBsmEjaT+BlQPbFiJIxx35Aa1fXTa8w+Sf0cTSv
wnd31oDjiW2f/gt4n+c+9gg//HxZe8ewl2xpEQ9kt4LVIdIeyvJr9irh76DLEeC1
k9Kxv7saybsnuFtSpEGd
=MZ7D
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
