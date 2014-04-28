From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/7] phy: omap-usb2: Add clock names to Documentation
 binding
Date: Mon, 28 Apr 2014 11:04:15 -0500
Message-ID: <20140428160415.GI30292@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-6-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398693687-13967-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:01:25PM +0300, Roger Quadros wrote:
> Add "wkupclk" and "refclk" information to DT binding information.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documenta=
tion/devicetree/bindings/phy/ti-phy.txt
> index 788fb0f..9ce458f 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -32,6 +32,11 @@ Required properties:
>   - reg : Address and length of the register set for the device.
>   - #phy-cells: determine the number of cells that should be given in the
>     phandle while referencing this phy.
> + - clocks: a list of phandles and clock-specifier pairs, one for each en=
try in
> +   clock-names.
> + - clock-names: should include:
> +   * "wkupclk" - wakeup clock.
> +   * "refclk" - reference clock (optional).
> =20
>  Optional properties:
>   - ctrl-module : phandle of the control module used by PHY driver to pow=
er on
> @@ -44,6 +49,8 @@ usb2phy@4a0ad080 {
>  	reg =3D <0x4a0ad080 0x58>;
>  	ctrl-module =3D <&omap_control_usb>;
>  	#phy-cells =3D <0>;
> +	clocks =3D <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
> +	clock-names =3D "wkupclk", "refclk";
>  };
> =20
>  TI PIPE3 PHY
> --=20
> 1.8.3.2
>=20

--=20
balbi

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXnv/AAoJEIaOsuA1yqRErc0P/1b3z1cVKKMeecSLLmtIezg5
bJWFyYtKm/OEoyKtplN9L4LGQ1vNX1Z+nnBwuznU9WASRILvQLZZUNigyviD0XZQ
JABRtLLbUsFZjQKznFpLcSs/wZKuWI1rwPOkXiPdib8xY8sejkwjQwGYG84m9XuG
py4p6Zr9MB01H9hDkVPVRfURmN+KnDluz7I6jATEE06ojJCCpfRG21TjhLkoWm4U
L9pDMd9lACoFM3NblT82sQbDinF0rDojztYFUZJbIc728Gw5XrIuDIRTH63HwK2K
dllvplhdFtkvHPa5Nk8Oxn6+YPtupSeGGNShovYAa8jGoaORKu/57SEd+K1velm2
UKK6jrvcnuvFM0p7wLU3sc/h7qt8fLVPKQnJzKxIgVOvPDZnlQ69v//ezVQwn12h
yD54+Hg49+e2Nzl5QFy0SqIyTO9orCD4laALgkisJYmpzCH9aZAYTOY/LZnpjuJY
8P+1u/v/oTn1Lw5PjLVaSBvtcRZFkzCZImbo7Oknu85I8kjIva/i17VkfxMIRE6j
oEz8ZMQcXQcikf2jgwxdwMhoU7AdDyBpAJjYQFlLddxvgD7TL3dQG/AMCFtSHj43
zaoXgVG2GGmRMUnq3iEbktE3cUmFLzAd+xhnbWm17rWIroGCugXtSYz31S6pRFIg
GAQJMD9UvReCcCmmFeEd
=MQOo
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
