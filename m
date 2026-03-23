Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A333DFC75;
	Mon, 23 Mar 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295729; cv=none; b=kQiT0R2NwCBTK54FM43bUD/4qSFjtdSB/kQ3M6cIzpRYbm48rA36PwhCTDTs3tS/Or2+D0LiDhKh3yawTK+dXoiRN6A/UdP5QcDVeGVSBVi5zod3HT//lG5t3y6MupPmoSJRbGdW0z1QsdrGwRebMD43VZXHnBn3//Alzd/qbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295729; c=relaxed/simple;
	bh=2wLd3RWmA5D7Po5IWAIh0ELHZkbCcEMTNXXyE0PIUsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbeLOxa6c8PckIj78FoE1Bi0cQv4JQqpCtBH8PT7N3DATItGPyFv4NrRXsODzGl6JXl7yDky8kwBn0rnNM3X6NwzVrYxYnVVheCZbXAGsr1dXaQMf9d/94Fy83fCo+cRXVTeIn0zckaQzQHQhBBkacnLXQw4meb9TIANFP0y8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfzhTWzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfzhTWzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3774C4CEF7;
	Mon, 23 Mar 2026 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295728;
	bh=2wLd3RWmA5D7Po5IWAIh0ELHZkbCcEMTNXXyE0PIUsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfzhTWzuzozJ9Ev9Q/q6Ik/1IsJ46sPjdPts/JMi/bRgqJ1RlAxkDQ8stBvY+KuPr
	 3r8lENe0SPSckEZQYrZq3O9OT4IAGyLmbHWZldwIMC6MLmDtBc0ITXeib7om/O1wTN
	 teX3QLPg4pQrrSuLwbych281qe/dpaSWJhipzSe55t27PjYDHE7AAfWdpXs218kGnW
	 mCMIXLWmdkTySEUNo50eRIzVSJx1dwsjkO0kcbe8UgI8FjjZ9Lm8jwcfackCjqlV32
	 sjMhCmzDMWvl+2i/uyek8Y/ImDfW6jvZVrLUShHs0jBdStjP/2VIj9lTsiJpZZ7kUI
	 yhW3NHMCNYqcQ==
Date: Mon, 23 Mar 2026 19:55:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: mfd: ti,omap-usb-host: Convert to DT
 schema
Message-ID: <20260323-cloak-expectant-7432b0fdd663@spud>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
 <20260323-omap4-fix-usb-support-v1-5-b668132124ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XHqtLWMzRQ/Bsq9m"
Content-Disposition: inline
In-Reply-To: <20260323-omap4-fix-usb-support-v1-5-b668132124ac@bootlin.com>


--XHqtLWMzRQ/Bsq9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 04:02:46PM +0100, Thomas Richard wrote:
> Convert OMAP HS USB Host binding to DT schema. The 'ti,hwmods' property is
> not mandatory anymore as it is no longer required when the omap-usb-host
> node is a child of a new interconnect target (ti,sysc).
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  .../devicetree/bindings/mfd/omap-usb-host.txt      | 103 ----------------
>  .../devicetree/bindings/mfd/ti,omap-usb-host.yaml  | 131 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 132 insertions(+), 103 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Do=
cumentation/devicetree/bindings/mfd/omap-usb-host.txt
> deleted file mode 100644
> index a0d8c30c2631e534cae50dfc7183cd04e744f31f..0000000000000000000000000=
000000000000000
> --- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -OMAP HS USB Host
> -
> -Required properties:
> -
> -- compatible: should be "ti,usbhs-host"
> -- reg: should contain one register range i.e. start and length
> -- ti,hwmods: must contain "usb_host_hs"
> -
> -Optional properties:
> -
> -- num-ports: number of USB ports. Usually this is automatically detected
> -  from the IP's revision register but can be overridden by specifying
> -  this property. A maximum of 3 ports are supported at the moment.
> -
> -- portN-mode: String specifying the port mode for port N, where N can be
> -  from 1 to 3. If the port mode is not specified, that port is treated
> -  as unused. When specified, it must be one of the following.
> -	"ehci-phy",
> -        "ehci-tll",
> -        "ehci-hsic",
> -        "ohci-phy-6pin-datse0",
> -        "ohci-phy-6pin-dpdm",
> -        "ohci-phy-3pin-datse0",
> -        "ohci-phy-4pin-dpdm",
> -        "ohci-tll-6pin-datse0",
> -        "ohci-tll-6pin-dpdm",
> -        "ohci-tll-3pin-datse0",
> -        "ohci-tll-4pin-dpdm",
> -        "ohci-tll-2pin-datse0",
> -        "ohci-tll-2pin-dpdm",
> -
> -- single-ulpi-bypass: Must be present if the controller contains a single
> -  ULPI bypass control bit. e.g. OMAP3 silicon <=3D ES2.1
> -
> -- clocks: a list of phandles and clock-specifier pairs, one for each ent=
ry in
> -  clock-names.
> -
> -- clock-names: should include:
> -  For OMAP3
> -  * "usbhost_120m_fck" - 120MHz Functional clock.
> -
> -  For OMAP4+
> -  * "refclk_60m_int" - 60MHz internal reference clock for UTMI clock mux
> -  * "refclk_60m_ext_p1" - 60MHz external ref. clock for Port 1's UTMI cl=
ock mux.
> -  * "refclk_60m_ext_p2" - 60MHz external ref. clock for Port 2's UTMI cl=
ock mux
> -  * "utmi_p1_gfclk" - Port 1 UTMI clock mux.
> -  * "utmi_p2_gfclk" - Port 2 UTMI clock mux.
> -  * "usb_host_hs_utmi_p1_clk" - Port 1 UTMI clock gate.
> -  * "usb_host_hs_utmi_p2_clk" - Port 2 UTMI clock gate.
> -  * "usb_host_hs_utmi_p3_clk" - Port 3 UTMI clock gate.
> -  * "usb_host_hs_hsic480m_p1_clk" - Port 1 480MHz HSIC clock gate.
> -  * "usb_host_hs_hsic480m_p2_clk" - Port 2 480MHz HSIC clock gate.
> -  * "usb_host_hs_hsic480m_p3_clk" - Port 3 480MHz HSIC clock gate.
> -  * "usb_host_hs_hsic60m_p1_clk" - Port 1 60MHz HSIC clock gate.
> -  * "usb_host_hs_hsic60m_p2_clk" - Port 2 60MHz HSIC clock gate.
> -  * "usb_host_hs_hsic60m_p3_clk" - Port 3 60MHz HSIC clock gate.
> -
> -Required properties if child node exists:
> -
> -- #address-cells: Must be 1
> -- #size-cells: Must be 1
> -- ranges: must be present
> -
> -Properties for children:
> -
> -The OMAP HS USB Host subsystem contains EHCI and OHCI controllers.
> -See Documentation/devicetree/bindings/usb/generic-ehci.yaml and
> -Documentation/devicetree/bindings/usb/generic-ohci.yaml.
> -
> -Example for OMAP4:
> -
> -usbhshost: usbhshost@4a064000 {
> -	compatible =3D "ti,usbhs-host";
> -	reg =3D <0x4a064000 0x800>;
> -	ti,hwmods =3D "usb_host_hs";
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -	ranges;
> -
> -	usbhsohci: ohci@4a064800 {
> -		compatible =3D "ti,ohci-omap3";
> -		reg =3D <0x4a064800 0x400>;
> -		interrupt-parent =3D <&gic>;
> -		interrupts =3D <0 76 0x4>;
> -	};
> -
> -	usbhsehci: ehci@4a064c00 {
> -		compatible =3D "ti,ehci-omap";
> -		reg =3D <0x4a064c00 0x400>;
> -		interrupt-parent =3D <&gic>;
> -		interrupts =3D <0 77 0x4>;
> -	};
> -};
> -
> -&usbhshost {
> -	port1-mode =3D "ehci-phy";
> -	port2-mode =3D "ehci-tll";
> -	port3-mode =3D "ehci-phy";
> -};
> -
> -&usbhsehci {
> -	phys =3D <&hsusb1_phy 0 &hsusb3_phy>;
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml =
b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7831ad891229aee650d83adcd=
82405c9dde472a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,omap-usb-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP HS USB Host
> +
> +maintainers:
> +  - Thomas Richard <thomas.richard@bootlin.com>
> +
> +description: |
> +  description
> +
> +properties:
> +  compatible:
> +    const: ti,usbhs-host
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,hwmods:
> +    const: usb_host_hs
> +
> +  num-ports:
> +    description:
> +      number of USB ports. Usually this is automatically detected from t=
he IP's
> +      revision register but can be overridden by specifying this propert=
y. A
> +      maximum of 3 ports are supported at the moment.
> +    maximum: 3
> +
> +  single-ulpi-bypass:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Must be present if the controller contains a single ULPI bypass co=
ntrol
> +      bit. e.g. OMAP3 silicon <=3D ES2.1ULPI bypass control bit.
> +      e.g. OMAP3 silicon <=3D ES2.1.
> +
> +  clocks:
> +    description: clock-specifier
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: usbhost_120m_fck
> +      - items:
> +          - const: refclk_60m_int
> +          - const: refclk_60m_ext_p1
> +          - const: refclk_60m_ext_p2

Looks like half the clocks are missing?

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^port[0-3]-mode$":
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      String specifying the port mode for port N, where N can be from 1 =
to 3.
> +      the port mode is not specified, that port is treated as unused. Wh=
en
> +      specified, it must be one of the following.
> +    enum:
> +      - ehci-phy
> +      - ehci-tll
> +      - ehci-hsic
> +      - ohci-phy-6pin-datse0
> +      - ohci-phy-6pin-dpdm
> +      - ohci-phy-3pin-datse0
> +      - ohci-phy-4pin-dpdm
> +      - ohci-tll-6pin-datse0
> +      - ohci-tll-6pin-dpdm
> +      - ohci-tll-3pin-datse0
> +      - ohci-tll-4pin-dpdm
> +      - ohci-tll-2pin-datse0
> +      - ohci-tll-2pin-dpdm
> +
> +  "^usb@":
> +    type: object

Can this include a ref to whatever binding describes these devices?
Looks like there's two, one for ochi and echi, at 400 and 800?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      patternProperties:
> +        "^usb@": true
> +    then:
> +      required:
> +        - ranges
> +        - "#address-cells"
> +        - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        usbhshost: usbhshost@4a064000 {
> +            compatible =3D "ti,usbhs-host";
> +            reg =3D <0x4a064000 0x800>;
> +            ti,hwmods =3D "usb_host_hs";
> +            port1-mode =3D "ehci-phy";
> +            port2-mode =3D "ehci-tll";
> +            port3-mode =3D "ehci-phy";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            ranges;
> +
> +            usbhsohci: usb@4a064800 {
> +                compatible =3D "ti,ohci-omap3";
> +                reg =3D <0x4a064800 0x400>;
> +                interrupt-parent =3D <&gic>;
> +                interrupts =3D <0 76 0x4>;
> +            };
> +
> +            usbhsehci: usb@4a064c00 {
> +                compatible =3D "ti,ehci-omap";
> +                reg =3D <0x4a064c00 0x400>;
> +                interrupt-parent =3D <&gic>;
> +                interrupts =3D <0 77 0x4>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d10988cbc62b77515aa1a1fee1c7d3e594869fa..28da3ac5896681bcdab29c23c=
98eff3612dc181d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19397,6 +19397,7 @@ W:	http://linux.omap.com/
>  Q:	http://patchwork.kernel.org/project/linux-omap/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.g=
it
>  F:	Documentation/devicetree/bindings/arm/ti/omap.yaml
> +F:	Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
>  F:	arch/arm/configs/omap2plus_defconfig
>  F:	arch/arm/mach-omap2/
>  F:	drivers/bus/omap*.[ch]
>=20
> --=20
> 2.53.0
>=20

--XHqtLWMzRQ/Bsq9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGaqwAKCRB4tDGHoIJi
0lIEAP9ggNQEiJtrVYcCFqYYkBh0OJM6/782qbrK3h4yg7GwgwD/ai8rNOha+0Ab
9d/xxzfw3TFljisT1MWSCnTS3TNu4Ao=
=tdLG
-----END PGP SIGNATURE-----

--XHqtLWMzRQ/Bsq9m--
