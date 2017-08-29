From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 11:00:34 +0200
Message-ID: <20170829090034.ytepjfv2jkkd2b3z@earth>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5o7p4sjxzmzodys"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170828211918.11573-15-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--e5o7p4sjxzmzodys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 28, 2017 at 02:19:15PM -0700, Tony Lindgren wrote:
> On omap4 we're missing the PowerVR SGX GPU node with it's related
> "ti,hwmods" property that the SoC interconnect code needs.
>=20
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---

I think OMAP3 & OMAP5 should also be documented and getting a
node in this series?

-- Sebastian

>  .../devicetree/bindings/gpu/ti-powervr-sgx.txt     | 34 ++++++++++++++++=
++++++
>  arch/arm/boot/dts/omap4.dtsi                       |  7 +++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/ti-powervr-sgx.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt b/D=
ocumentation/devicetree/bindings/gpu/ti-powervr-sgx.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt
> @@ -0,0 +1,34 @@
> +Texas Instruments PowevVR SGX binding
> +
> +SGX can be used for graphics acceleration on Texas Instruments SoCs.
> +
> +Note that the SGX binding is currently only used by the SoC interconnect
> +code to idle the module on init and no open source driver is available
> +for SGX. Please update this documentation if that changes.
> +
> +Required properties:
> +
> +compatible: Shall be one of the following:
> +	    "ti,omap4-gpu"
> +
> +reg: Shall contain the device instance IO range
> +
> +interrupts: Shall contain the device instance interrupt
> +
> +
> +Optional properties:
> +
> +reg-names: Shall contain the IO range names if multiple IO
> +	   ranges are used by the SoC
> +
> +ti,hwmods: Shall contain the TI interconnect module name if needed
> +	   by the SoC
> +
> +
> +Example:
> +	gpu: gpu@56000000 {
> +		compatible =3D "ti,omap4-gpu";
> +		reg =3D <0x56000000 0x10000>;
> +		interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,hwmods =3D "gpu";
> +	};
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -1086,6 +1086,13 @@
>  			status =3D "disabled";
>  		};
> =20
> +		gpu: gpu@56000000 {
> +			compatible =3D "ti,omap4-gpu";
> +			reg =3D <0x56000000 0x10000>;
> +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods =3D "gpu";
> +		};
> +
>  		dss: dss@58000000 {
>  			compatible =3D "ti,omap4-dss";
>  			reg =3D <0x58000000 0x80>;
> --=20
> 2.14.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--e5o7p4sjxzmzodys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlLS8ACgkQ2O7X88g7
+pqfzg/+Py4k+ett0OxCKw9ytlXgOQd8juuvEXbhvMeKlSZNT/9iEpEIBb4i6Ybl
1MQZI7PsoCtQE9jg5cxSEdJIWa8sw7Mpa4J9+hkux72yeLNEas3AwK7W8FkoCD8S
sDZZ9AvgLHmYHS0P//oVjQ2GdV+UjnzyS3E5+re8PIKcrmXOxP+dXgVi3YAZn3fG
433zHLzww9J8Wlyv5IKwn5GpyDm3pGFD1Fvd2qMZDqE0PHO1UNQoeGWCgX4j2PSq
pywL1q47dhXmmY/rVCGQG1TjEHFwAKRDxDF73gm2POsZ1O2kLcZLUFrGNTI8gzuU
z7LOJ+0zIOdblEwUMvf4mDEPutXtzVqaHSWYtngbSy/l5d+8PwXkIr8822P9v+I3
V1Q5o1CHbFdu5tp2fUzsApdySSCyGwOUEVw6DhfxVEuWXxH0FezL+G2KFRQ7wz7e
XhV8lAltNM6GlcLyod2H0h19jxAvFE0vTBM+gWhnMZQ8XSzckE1qAfAMNFh6QcBr
oAufZcxjKcV/6T+npjIRpg26OA1dc9RIKRVxrTJ0U0170CI49xhKfJXKPfA8ufcm
8uHAO44Mp3ORMy0wGAyTTZRjZRoaoOQ3A4gR9jU7DVrsuWbzKpjQfV3Cv7qtyHVB
pv6AjXlET6Ei0AlpP1gybROJSCcAgZKh/RcHUol6/n2nBpOQZmQ=
=7KaN
-----END PGP SIGNATURE-----

--e5o7p4sjxzmzodys--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
