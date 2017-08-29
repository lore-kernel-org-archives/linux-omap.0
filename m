From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Tue, 29 Aug 2017 11:18:26 +0200
Message-ID: <20170829091825.aye2ulcurnhs24uw@earth>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-9-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n4tm2jdowwc2si3m"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170828211918.11573-9-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--n4tm2jdowwc2si3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 28, 2017 at 02:19:09PM -0700, Tony Lindgren wrote:
> On omap4 we're missing the hsi node with it's related "ti,hwmods"
> property that the SoC interconnect code needs.
>=20
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
>=20
> Let's also update the binding accrodingly while at it.
>=20
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/hsi/omap-ssi.txt | 6 +++++-
>  arch/arm/boot/dts/omap4.dtsi                       | 9 +++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documen=
tation/devicetree/bindings/hsi/omap-ssi.txt
> --- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> +++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> @@ -4,7 +4,7 @@ OMAP Synchronous Serial Interface (SSI) controller implem=
ents a legacy
>  variant of MIPI's High Speed Synchronous Serial Interface (HSI).
> =20
>  Required properties:
> -- compatible:		Should include "ti,omap3-ssi".
> +- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
>  - reg-names:		Contains the values "sys" and "gdd" (in this order).
>  - reg:			Contains a matching register specifier for each entry
>  			in reg-names.
> @@ -38,6 +38,10 @@ Required Port sub-node properties:
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
> @@ -632,6 +632,15 @@
>  			dma-names =3D "tx", "rx";
>  		};
> =20
> +		hsi: hsi@4a058000 {
> +			compatible =3D "ti,omap4-hsi";
> +			reg =3D <0x4a058000 0x4000>;
> +			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods =3D "hsi";
> +		};
> +

This does not follow the binding, which expects one subnode per
port and splits memory areas + interrupts accordingly. Fortunately
HSI is properly documented in the public OMAP4 TRM (in opposit to
SSI, which is missing completly in OMAP3 TRM). I think the node
should look like this:

hsi: hsi@4a058000 {
    compatible =3D "ti,omap4-hsi";
    ti,hwmods =3D "hsi";

    reg =3D <0x4a058000 0x5000>,
          <0x4a058000 0x1000>;
    reg-names =3D "sys", "gdd";

    clocks =3D <&hsi_fck>;
    clock-names =3D "hsi_fck";

    interrupts =3D <71>;
    interrupt-names =3D "gdd_mpu";

    #address-cells =3D <1>;
    #size-cells =3D <1>;
    ranges;

    hsi_port1: hsi-port@4a05a000 {
        compatible =3D "ti,omap4-hsi-port";

        reg =3D <0x4a05a000 0x800>,
              <0x4a05a800 0x800>;
        reg-names =3D "tx", "rx";

        interrupt-parent =3D <&intc>;
        interrupts =3D <67>;
    };

    hsi_port2: hsi-port@4a05b000 {
        compatible =3D "ti,omap4-hsi-port";

        reg =3D <0x4a05b000 0x800>,
              <0x4a05b800 0x800>;
        reg-names =3D "tx", "rx";

        interrupt-parent =3D <&intc>;
        interrupts =3D <68>;
    };
};

-- Sebastian

>  		mmu_dsp: mmu@4a066000 {
>  			compatible =3D "ti,omap4-iommu";
>  			reg =3D <0x4a066000 0x100>;
> --=20
> 2.14.1

--n4tm2jdowwc2si3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlMV4ACgkQ2O7X88g7
+pr/bQ/7Byta77NrYr1g1S4dBrAkXUiHVA6EGTJArtXJZbOmWzekhKtY0u8Lq1Yb
v6drdo5BRsdCo8ZxQS17cn0lyALRJEFMBkyf9zHVyk0l9pEf4wda1uVPUeWjcb1f
uZuyoSSPbp+Jl0e5qwFGn8O+nKuev9p82cLu4u+XZeyvWo/FOFf37JNJf1TnHRac
5Xcx3friDcaI8vNzO7YDz56lFE55ih8DB0i9dVferby1Cr/XSj3yIC8yYawh/on3
YyKM0ypqjpXS5/SiCT/rZ5zVsX+SYhT9hlrEZhCwo2qBdOrID1gE9MePFhOi65yD
pR5Cm9AdGEv7zN0UjJszesW9jM2uHo4kkf5WakSfid9tnMZf8X0Xds0fqhGxVbbt
nfzShV6znAa8P0ehJY0W6/WL58E83VdyUPRU52o/CCNh4J0fEojJjqECmBXgiAnr
k27PrEZXKtSF7n679OyrqgRv0g5TuBw8te4lfutOVG3L2aIhA1pGwwaHlew76+dr
QJaNyHkY73yR5M8fxkT6MGZfhqx1zT04FvqVRtXk53a6AdTMY2wpsv8IIFc2kb22
1Za3+wSFMmc9dANRR02bIKhj1R8cesRO067n6lULINcra3lIlFY+gwGY5z8w8Wd7
TRdb0VLE7I3oYuojXxkDpJRlxnq9dtvkPoZZdlWg6g+YmaGUbEc=
=32SW
-----END PGP SIGNATURE-----

--n4tm2jdowwc2si3m--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
