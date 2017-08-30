From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Wed, 30 Aug 2017 21:37:45 +0200
Message-ID: <20170830193745.ygotb3nuyfmdlaaf@earth>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-9-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="enuq3hee5crnh5vl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170830151953.30856-9-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--enuq3hee5crnh5vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 08:19:44AM -0700, Tony Lindgren wrote:
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
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/hsi/omap-ssi.txt |  7 ++++-
>  arch/arm/boot/dts/omap4.dtsi                       | 34 ++++++++++++++++=
++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documen=
tation/devicetree/bindings/hsi/omap-ssi.txt
> --- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> +++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> @@ -4,7 +4,7 @@ OMAP Synchronous Serial Interface (SSI) controller implem=
ents a legacy
>  variant of MIPI's High Speed Synchronous Serial Interface (HSI).

Maybe change the leading text:

OMAP3's Synchronous Serial Interface (SSI) controller implements a
legacy variant of MIPI's High Speed Synchronous Serial Interface (HSI),
while the controller found inside OMAP4 is supposed to be fully compliant
with the HSI standard.

>  Required properties:
> -- compatible:		Should include "ti,omap3-ssi".
> +- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
>  - reg-names:		Contains the values "sys" and "gdd" (in this order).
>  - reg:			Contains a matching register specifier for each entry
>  			in reg-names.
> @@ -27,6 +27,7 @@ Each port is represented as a sub-node of the ti,omap3-=
ssi device.
>  Required Port sub-node properties:
>  - compatible:		Should be set to the following value
>  			ti,omap3-ssi-port (applicable to OMAP34xx devices)
> +			ti,omap4-ssi-port (applicable to OMAP44xx devices)
                     ^^^

this should be hsi.

>  - reg-names:		Contains the values "tx" and "rx" (in this order).
>  - reg:			Contains a matching register specifier for each entry
>  			in reg-names.
> @@ -38,6 +39,10 @@ Required Port sub-node properties:
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

otherwise:

Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--enuq3hee5crnh5vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmnFAYACgkQ2O7X88g7
+pqT0A//cMpDdl5OfbOm4lucZF0W30DJYzo7cOQzJ+VPfrHefQ4/okSvUeXiUNjw
yayqU5IKZZdd0JhY1Sshslj4bYCdLhsRKtGGX//5z22yUwBbFLDZgYUUVO4fEOE+
YFJu4LeGWCeaqcZLic5Npb8ticfEOYiA2mMUcWJpq8x8put/36V+qTiRA2o2oTl+
o7exZb3mn1hzNwmCa07brDHIS7ymVA9uKGN8LwBIqQflwpP5Ps33VDpbNrMDctRU
wB9g3FlhJUshtDJwKwoqfHoL3cw+1gFwLBVCtT9E7T1SaMNIN5zKiCCBwClvsnoI
Ge4KV7aaBZqCCTG5v7IxwItUKsUFkqi1IL2z5ffbdUDhJ937cJKuAugZI4NsveH6
dQsijSeMUic6sBnmsIIqq33dgw8t60vXlqcf3dCxaX08bW5qTshD5HLULA8aYCTT
sulsOuMvtcnL1DgFWXqN2LVghVwAn4UEQMoaNDX2frYzVOiiN+ky2BBR1LZiyAOI
0DzvvKuz8l5/v7/CBNj+5WiDx2gYdE3k4Q2IebFjZUbXhnoo8fL0/9iSllzCQuyB
Wzr/NycjykXx9jv+PDJrMQqYvwGj++S1ed2bkDSvOLcdrIcrgjOM4XksdvbhEmnx
NmZlzlnaD5XsvbWzQEp6FdkErLQsmruRo1RV5LkPUOIKQV8eQh8=
=2pC/
-----END PGP SIGNATURE-----

--enuq3hee5crnh5vl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
