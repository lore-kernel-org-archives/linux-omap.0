From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: dt binding - add resources, example
Date: Tue, 6 Nov 2012 15:02:45 +0200
Message-ID: <20121106130245.GK11931@arwen.pp.htv.fi>
References: <cover.1351870620.git.afzal@ti.com>
 <392aceb635682614b8509b4090943f806b3236f2.1351870620.git.afzal@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <392aceb635682614b8509b4090943f806b3236f2.1351870620.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2012 at 10:02:47PM +0530, Afzal Mohammed wrote:
> OMAP2+ family of devices are now obtaining resources via DT, earlier
> it was obtained from hwmod. Update binding document accrodingly, while
> at it add example.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  .../devicetree/bindings/usb/am33xx-usb.txt          | 21 +++++++++++++++=
++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Docum=
entation/devicetree/bindings/usb/am33xx-usb.txt
> index a922505..6b7e3bd 100644
> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> @@ -1,5 +1,7 @@
>  AM33XX MUSB GLUE
>   - compatible : Should be "ti,musb-am33xx"
> + - reg : offset and length of register sets, first usbss, then for musb =
instances
> + - interrupts : usbss, musb instance interrupts in order
>   - ti,hwmods : must be "usb_otg_hs"
>   - multipoint : Should be "1" indicating the musb controller supports
>     multipoint. This is a MUSB configuration-specific setting.
> @@ -12,3 +14,22 @@ AM33XX MUSB GLUE
>     represents PERIPHERAL.
>   - power : Should be "250". This signifies the controller can supply upto
>     500mA when operating in host mode.
> +
> +Example:
> +
> +usb_otg_hs@47400000  {

this should be usb@47400000.

> +	compatible =3D "ti,musb-am33xx";
> +	reg =3D <0x47400000 0x1000	/* usbss */
> +	       0x47401000 0x800		/* musb instance 0 */
> +	       0x47401800 0x800>;	/* musb instance 1 */
> +	interrupts =3D <17		/* usbss */
> +		      18		/* musb instance 0 */
> +		      19>;		/* musb instance 1 */
> +	multipoint =3D <1>;
> +	num-eps =3D <16>;
> +	ram-bits =3D <12>;
> +	port0-mode =3D <3>;
> +	port1-mode =3D <3>;
> +	power =3D <250>;
> +	ti,hwmods =3D "usb_otg_hs";
> +};
> --=20
> 1.7.12
>=20

--=20
balbi

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmQp1AAoJEIaOsuA1yqRE/5kQALWyGwXCFZ8/kVNUM8u+IAby
HcnhQmrpsnBLwaghfcY12we0+pF1pAcIxPAJ87MnVsEGOjoWkuKToAeS5guGCrp7
UApouhAiDKeLA+f2z2R81Lr+a0/iM9GEX1Dw5LtLMqsLdx/PUEwV0M8yqe885qp8
/6gSu6e+Sxugr+pK2fOUInE0EiQx0m90awvHirtb6ri8XLKI3XHdi379Vld7nn8n
iS4VkrYN83H4Eo/w6uHWiD7OKOXnMKGRGQsmCuwBG+0T61oqZk5CGaegP+7XzwGh
9xcYscnX7qoDmyBxs32RQpfTCJcn/SM6lnu4duMKSmad/OAo79x7oRY07ljc1ox5
uNcBqkHapUzOJGvESXzVCc/tZUBUQZWiRM9A6H1xMkxiHzK7IPhRzrJB7K7mQFJr
H8sTSYtuG5ZKn52DCJ7zxKRPxNEa3et+SJYAuIefbJoDKt3HSEawxoBUwa2RpcEV
vWOH5Eesub3Iar8RVMI+Odx0xO1FiO0dDxRa5d0Lk0xKMpNdCJRQuCglB63LtYUQ
ZxQWaUKgj9xWpBhsXN6sqAyoIKmSkl2jiHy2PJ0AvsnnPbAYrj/lob92hlRblbrD
9dwnzXelRlW2A+LiFkJFhrlORiArLkBBj7wmOYyKJaZu0vMhVnDIZnL410Fmt+ri
RCnxPlJ5qlW7jUr/CXMF
=rNBG
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--
