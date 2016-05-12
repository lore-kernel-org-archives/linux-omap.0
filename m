From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] Documentation: mfd: LP873X: Add information for
 the mfd and regulator drivers
Date: Thu, 12 May 2016 14:21:40 +0100
Message-ID: <20160512132140.GC1433@dell.open.watershed.co.uk>
References: <1462853079-10708-1-git-send-email-j-keerthy@ti.com>
 <1462853079-10708-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462853079-10708-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 10 May 2016, Keerthy wrote:

> Add information for the mfd and regulator drivers.
>=20
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/lp873x.txt | 55 ++++++++++++++=
++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Docum=
entation/devicetree/bindings/mfd/lp873x.txt
> new file mode 100644
> index 0000000..3ef5ea0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -0,0 +1,55 @@
> +TI LP3943 MFD driver
> +
> +Required properties:
> +  - compatible: "ti,lp8732", "ti,lp8733"
> +  - reg: I2C slave address.
> +
> +For the lp873x regulator properties please refer to:
> +Documentation/devicetree/bindings/regulator/lp873x.txt

This is a Linuxism.  Use ../bindings/.. instead.

> +Example:
> +
> +lp8733: lp8733@60 {

lp8733 is not a device 'type'.  What does it do?

Looks like a 'pmic' to me.

> +	compatible =3D "ti,lp8733";
> +	reg =3D <0x60>;
> +
> +	regulators {
> +		lp8733_buck0: buck0 {
> +			regulator-name =3D "lp8733-buck0";
> +			regulator-min-microvolt =3D <800000>;
> +			regulator-max-microvolt =3D <1400000>;
> +			regulator-min-microamp =3D <1500000>;
> +			regulator-max-microamp =3D <4000000>;
> +			regulator-ramp-delay =3D <10000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		lp8733_buck1: buck1 {
> +			regulator-name =3D "lp8733-buck1";
> +			regulator-min-microvolt =3D <800000>;
> +			regulator-max-microvolt =3D <1400000>;
> +			regulator-min-microamp =3D <1500000>;
> +			regulator-max-microamp =3D <4000000>;
> +			regulator-ramp-delay =3D <10000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		lp8733_ldo0: ldo0 {
> +			regulator-name =3D "lp8733-ldo0";
> +			regulator-min-microvolt =3D <800000>;
> +			regulator-max-microvolt =3D <3000000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		lp8733_ldo1: ldo1 {
> +			regulator-name =3D "lp8733-ldo1";
> +			regulator-min-microvolt =3D <800000>;
> +			regulator-max-microvolt =3D <3000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +	};
> +};

I'm failing to see how this is an MFD?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
