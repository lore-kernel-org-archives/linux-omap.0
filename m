From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Sun, 1 Oct 2017 17:25:14 +0200
Message-ID: <20171001152514.hjoa5osvadfpnkim@earth>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-9-tony@atomide.com>
 <20170830193745.ygotb3nuyfmdlaaf@earth>
 <20170830202519.GI6008@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5p4z63maywwxm6i"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170830202519.GI6008-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--q5p4z63maywwxm6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 30, 2017 at 01:25:20PM -0700, Tony Lindgren wrote:
> Thanks, updated patch below.

Thanks, I applied the DT binding part to the HSI subsystem:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git/commit/?h=
=3Dfor-next&id=3D8635d6b3afe68cdde2f646c2a3bbd8149c031e8c

-- Sebastian

> 8< --------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Wed, 30 Aug 2017 08:07:51 -0700
> Subject: [PATCH] ARM: dts: Add missing hsi node for omap4
>=20
> On omap4 we're missing the hsi node with it's related "ti,hwmods"
> property that the SoC interconnect code needs.
>=20
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
>=20
> Let's also update the binding accrodingly while at it.
>=20
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/hsi/omap-ssi.txt | 13 +++++++--
>  arch/arm/boot/dts/omap4.dtsi                       | 34 ++++++++++++++++=
++++++
>  2 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documen=
tation/devicetree/bindings/hsi/omap-ssi.txt
> --- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> +++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> @@ -1,10 +1,12 @@
>  OMAP SSI controller bindings
> =20
> -OMAP Synchronous Serial Interface (SSI) controller implements a legacy
> -variant of MIPI's High Speed Synchronous Serial Interface (HSI).
> +OMAP3's Synchronous Serial Interface (SSI) controller implements a
> +legacy variant of MIPI's High Speed Synchronous Serial Interface (HSI),
> +while the controller found inside OMAP4 is supposed to be fully compliant
> +with the HSI standard.
> =20
>  Required properties:
> -- compatible:		Should include "ti,omap3-ssi".
> +- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
>  - reg-names:		Contains the values "sys" and "gdd" (in this order).
>  - reg:			Contains a matching register specifier for each entry
>  			in reg-names.
> @@ -27,6 +29,7 @@ Each port is represented as a sub-node of the ti,omap3-=
ssi device.
>  Required Port sub-node properties:
>  - compatible:		Should be set to the following value
>  			ti,omap3-ssi-port (applicable to OMAP34xx devices)
> +			ti,omap4-hsi-port (applicable to OMAP44xx devices)
>  - reg-names:		Contains the values "tx" and "rx" (in this order).
>  - reg:			Contains a matching register specifier for each entry
>  			in reg-names.
> @@ -38,6 +41,10 @@ Required Port sub-node properties:
>  			property. If it's missing the port will not be
>  			enabled.
> =20
> +Optional properties:
> +- ti,hwmods:		Shall contain TI interconnect module name if needed
> +			by the SoC
> +
>  Example for Nokia N900:
> =20
>  ssi-controller@48058000 {
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -632,6 +632,40 @@
>  			dma-names =3D "tx", "rx";
>  		};
> =20
> +		hsi: hsi@4a058000 {
> +			compatible =3D "ti,omap4-hsi";
> +			reg =3D <0x4a058000 0x4000>,
> +			      <0x4a05c000 0x1000>;
> +			reg-names =3D "sys", "gdd";
> +			ti,hwmods =3D "hsi";
> +
> +			clocks =3D <&hsi_fck>;
> +			clock-names =3D "hsi_fck";
> +
> +			interrupts =3D <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "gdd_mpu";
> +
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges =3D <0 0x4a058000 0x4000>;
> +
> +			hsi_port1: hsi-port@2000 {
> +				compatible =3D "ti,omap4-hsi-port";
> +				reg =3D <0x2000 0x800>,
> +				      <0x2800 0x800>;
> +				reg-names =3D "tx", "rx";
> +				interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			hsi_port2: hsi-port@3000 {
> +				compatible =3D "ti,omap4-hsi-port";
> +				reg =3D <0x3000 0x800>,
> +				      <0x3800 0x800>;
> +				reg-names =3D "tx", "rx";
> +				interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
>  		mmu_dsp: mmu@4a066000 {
>  			compatible =3D "ti,omap4-iommu";
>  			reg =3D <0x4a066000 0x100>;
> --=20
> 2.14.1

--q5p4z63maywwxm6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnRCNcACgkQ2O7X88g7
+prr3A//UdLyAPwsQ9cVux6NXo8KorWoJCCpDawluiALZBIU8MR+RVjrNJMvwa1Q
TtM6jk4HYUcgFV/v9iXzcRm3iSfkPy6TmsxCgO9Fx6tvuyFqEfdfMxW8R2qrMICX
TXrCrp/sT2zH4Bgt2Qvla3SDsDNI5SOhS53tBZhXzIcL0WZjstop0tj9HNPDnpVM
h/SeUGksPRsV31q82qmzYRVoLVTnZ6TaRH9ea9LqxW/R+YpokVeW7NK9zZdZ/Ou9
970WoCqLnI6iazXb+RHtJMW0Sw8kjTe7C0UEivOCxNSuJlGHy2jWe3+bUkh+8nff
9HdSzfhQtK2hoKDwgFO9qt3uckwKKbS0CGdsKe8X5F4s6hf19BeAfuVvVFtLLAQH
5T9Jnld6PUJFVza/6JRA0uUvhVSGKxqsyt/6bEan5nr5P5SZXNrZCK/Dajx74yei
fbbRzNymgG5BAS0N0QiM1bkHc1kgkjwrOOzP595nYqVPYYhpVu8L2/X2wCokDIy4
+GMk3+P7k/ig+k1ScLiX8pk0WPw9GNGUfi37f14HBaTzV2NzvXRE4tmJnaV5/RUX
WsuvCM207VkCok+Z36ajUoBVyy5i6yz6qTVkz3EDX7sKDdUOxJxbr7P211CBXXzw
G3Isb70xZNYrtOR88W7b1ZEvZJVA0i2QI9UlXMXmHuMfoXE8EM4=
=RLdi
-----END PGP SIGNATURE-----

--q5p4z63maywwxm6i--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
