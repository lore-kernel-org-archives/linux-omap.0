From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/7] ARM: dts: omap4+: Add clocks to USB2 PHY node
Date: Mon, 28 Apr 2014 11:04:02 -0500
Message-ID: <20140428160402.GH30292@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-5-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398693687-13967-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:01:24PM +0300, Roger Quadros wrote:
> The USB2 PHY driver expects named clocks for wakeup clock
> and reference clock. Provide this information for USB2 PHY
> nodes in OMAP4 and OMAP5 SoC DTS.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/boot/dts/omap4.dtsi | 2 ++
>  arch/arm/boot/dts/omap5.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 649b5cd..f866de9 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -642,6 +642,8 @@
>  				compatible =3D "ti,omap-usb2";
>  				reg =3D <0x4a0ad080 0x58>;
>  				ctrl-module =3D <&omap_control_usb2phy>;
> +				clocks =3D <&usb_phy_cm_clk32k>;
> +				clock-names =3D "wkupclk";
>  				#phy-cells =3D <0>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index f8c9855..47b714c 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -803,6 +803,8 @@
>  				compatible =3D "ti,omap-usb2";
>  				reg =3D <0x4a084000 0x7c>;
>  				ctrl-module =3D <&omap_control_usb2phy>;
> +				clocks =3D <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
> +				clock-names =3D "wkupclk", "refclk";
>  				#phy-cells =3D <0>;
>  			};
> =20
> --=20
> 1.8.3.2
>=20

--=20
balbi

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXnvyAAoJEIaOsuA1yqREtBcQAKEX8iPhrXyngsxaOhvZMtfx
KcLv7v0VIVDUsCi76rjh/rrx6OAXPL+v0zIjNMQymNFO2Aj/wqtAk0ueGCBjv4vh
ef2OJpsOCTVyiU87yD3vmTJTjBTWiAgmWyuAKi47SaKS4SWSLoZPEIdyA8cmCi+M
SWUXaXSsDrdnMFcfycMcIQkf5e8mnSfD2mIcAyRfjZpIAfyp8HeH+cCNMKnIGtHh
y87dZ6pNz41MA4a/+CA8BbmjhphcnRSZborrLNGzDEwQ54t9B5xO7GNUtQKzPWPU
pwPdobwksrGjW0UEKiv2A9/xSK98JZrD6XxIpr92SDVq6v0Nso/o+tJjE8DP5Up9
T4jJbdH6vmzHdpfxdbSvbL5GFA2a9jfj5zETay9TaDRJMMUQJHAVRl+TsVSI5Ldo
POeT2ffugl3onA0d0+hcHcnSc1hDQg3zFLpPXc8W9rkd4mHitDlgMoIMSOBRK0Pe
HD0fGnh0E8DTVW4EQZIBobjRD1U8rWl9EvivXRA5oK6kz4LJgG90l1Rt38j/wnHs
+CUR2oJLbhiONMk5CCFpRk3jeQbSjIyK0WlPGYVsy9fapSieKIEgX7/GkzsRsXtP
GKwVfSw4g8pRGlJy+pDkEQBzoDRIVTpt/+6mj/HLc5SwfZGfM/tVmxOQhBfbTMYB
7I9wZYXy+sSCFyH7DgBA
=M8GN
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
