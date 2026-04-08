Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC23C1401;
	Wed,  8 Apr 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652958; cv=none; b=r+ABQAC3s7d5tWB9xfvFzXQ1gKradYfF8WyHQ8JW+qmDHkRHlIhj/ASupLq54WhuTBEK403cFJMfbMM1iTg8XUZZ8acSOby3+NMs1H5CTyIMIbpZzqotyWg7iMICsSIf1f5N0aqsR3CouiMqGtTh5AFJc1o1keK6tu9eOd6bPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652958; c=relaxed/simple;
	bh=cyv/ySeHFa5VB+WMwHzxE78bFav6m4OhHpq+s5jB/G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ostI00WnB4yOtWsjzpHrXZzY5ibbFvfDOyjtnVvDorlfXX+3LsvQ0fpxyabuUIHECqd31DYI4GsG2JAocoULu5XIFV4U6Sp25wZGPVAEtq8oVT11B8aQOgyyFFoZ24deJsMkzusrgnjqugBB5jy079pipxwx+rE/o0SgexQGSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8r9dBnk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8r9dBnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E13C19424;
	Wed,  8 Apr 2026 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652958;
	bh=cyv/ySeHFa5VB+WMwHzxE78bFav6m4OhHpq+s5jB/G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8r9dBnk6ZuYiitlDlk135aXgsrGudyyz9AcK2SdnE1Rg6v9sEf70v1mpv51VOYIT
	 UdKyzURZj0O8NXJNn72xaVT05oa/SAJiXcZ5z+PfNlkysOjdgns+VUXykVK7bHJr5e
	 PjliX2pCrcxScoL0jzQcJgPiUgqED/VmJ7mSAj6epcJEorQASrv+voqlsJ6rpjgKJN
	 VSDpjwWhRsY1uYPrQftDioH3OCv8+vi1JLu/iy0IsztGtcLrTumpPN8qftkuEz27U0
	 Jdi24WntB49gA33volQIktVRQw8B+/DhPkp1JN8rSiJKzn66q8PAd9pNGvCnHlVdxU
	 +9h4J7FYsQryQ==
Date: Wed, 8 Apr 2026 07:55:56 -0500
From: Rob Herring <robh@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/11] dt-bindings: mfd: ti,omap-usb-host: Convert to
 DT schema
Message-ID: <20260408125556.GA1879076-robh@kernel.org>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-8-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-omap4-fix-usb-support-v2-8-1c1e11b190dc@bootlin.com>

On Mon, Mar 30, 2026 at 03:44:05PM +0200, Thomas Richard wrote:
> Convert OMAP HS USB Host binding to DT schema. The 'ti,hwmods' property is
> not mandatory anymore as it is no longer required when the omap-usb-host
> node is a child of a new interconnect target (ti,sysc).
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  .../devicetree/bindings/mfd/omap-usb-host.txt      | 103 -------------
>  .../devicetree/bindings/mfd/ti,omap-usb-host.yaml  | 161 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 162 insertions(+), 103 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> deleted file mode 100644
> index a0d8c30c2631..000000000000
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
> -  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
> -
> -- clocks: a list of phandles and clock-specifier pairs, one for each entry in
> -  clock-names.
> -
> -- clock-names: should include:
> -  For OMAP3
> -  * "usbhost_120m_fck" - 120MHz Functional clock.
> -
> -  For OMAP4+
> -  * "refclk_60m_int" - 60MHz internal reference clock for UTMI clock mux
> -  * "refclk_60m_ext_p1" - 60MHz external ref. clock for Port 1's UTMI clock mux.
> -  * "refclk_60m_ext_p2" - 60MHz external ref. clock for Port 2's UTMI clock mux
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
> -	compatible = "ti,usbhs-host";
> -	reg = <0x4a064000 0x800>;
> -	ti,hwmods = "usb_host_hs";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -
> -	usbhsohci: ohci@4a064800 {
> -		compatible = "ti,ohci-omap3";
> -		reg = <0x4a064800 0x400>;
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 76 0x4>;
> -	};
> -
> -	usbhsehci: ehci@4a064c00 {
> -		compatible = "ti,ehci-omap";
> -		reg = <0x4a064c00 0x400>;
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 77 0x4>;
> -	};
> -};
> -
> -&usbhshost {
> -	port1-mode = "ehci-phy";
> -	port2-mode = "ehci-tll";
> -	port3-mode = "ehci-phy";
> -};
> -
> -&usbhsehci {
> -	phys = <&hsusb1_phy 0 &hsusb3_phy>;
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> new file mode 100644
> index 000000000000..3b5b041f0321
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> @@ -0,0 +1,161 @@
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
> +      number of USB ports. Usually this is automatically detected from the IP's
> +      revision register but can be overridden by specifying this property. A
> +      maximum of 3 ports are supported at the moment.
> +    maximum: 3
> +
> +  single-ulpi-bypass:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Must be present if the controller contains a single ULPI bypass control
> +      bit. e.g. OMAP3 silicon <= ES2.1ULPI bypass control bit.
> +      e.g. OMAP3 silicon <= ES2.1.
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
> +      - items:
> +          - const: refclk_60m_int
> +          - const: refclk_60m_ext_p1
> +          - const: refclk_60m_ext_p2
> +          - const: usb_host_hs_utmi_p1_clk
> +          - const: usb_host_hs_hsic480m_p1_clk
> +          - const: usb_host_hs_hsic60m_p1_clk
> +      - items:
> +          - const: refclk_60m_int
> +          - const: refclk_60m_ext_p1
> +          - const: refclk_60m_ext_p2
> +          - const: usb_host_hs_utmi_p1_clk
> +          - const: usb_host_hs_hsic480m_p1_clk
> +          - const: usb_host_hs_hsic60m_p1_clk
> +          - const: usb_host_hs_utmi_p2_clk
> +          - const: usb_host_hs_hsic480m_p2_clk
> +          - const: usb_host_hs_hsic60m_p2_clk
> +      - items:
> +          - const: refclk_60m_int
> +          - const: refclk_60m_ext_p1
> +          - const: refclk_60m_ext_p2
> +          - const: usb_host_hs_utmi_p1_clk
> +          - const: usb_host_hs_hsic480m_p1_clk
> +          - const: usb_host_hs_hsic60m_p1_clk
> +          - const: usb_host_hs_utmi_p2_clk
> +          - const: usb_host_hs_hsic480m_p2_clk
> +          - const: usb_host_hs_hsic60m_p2_clk
> +          - const: usb_host_hs_utmi_p3_clk
> +          - const: usb_host_hs_hsic480m_p3_clk
> +          - const: usb_host_hs_hsic60m_p3_clk

All but the first one can be combined to this last entry plus 
'minItems: 3'.

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
> +      String specifying the port mode for port N, where N can be from 1 to 3.
> +      the port mode is not specified, that port is treated as unused. When
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
> +    oneOf:
> +      - $ref: /schemas/usb/generic-ohci.yaml#
> +      - $ref: /schemas/usb/generic-ehci.yaml#

This causes the schemas to be applied twice and oneOf causes confusing 
warnings. Instead just do this:

type: object
properties:
  compatible:
    contains:
      enum:
        - ti,ehci-omap
        - ti,ohci-omap3

required:
  - compatible

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      patternProperties:
> +        "^usb@": true

This will always be true. Unfortunately there's no way to do required 
pattern properties in json-schema.

Is it valid to have no usb nodes? I wouldn't think so, so just make 
these properties always required.

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
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        usbhshost: usbhshost@4a064000 {
> +            compatible = "ti,usbhs-host";
> +            reg = <0x4a064000 0x800>;
> +            ti,hwmods = "usb_host_hs";
> +            port1-mode = "ehci-phy";
> +            port2-mode = "ehci-tll";
> +            port3-mode = "ehci-phy";
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            usbhsohci: usb@4a064800 {
> +                compatible = "ti,ohci-omap3";
> +                reg = <0x4a064800 0x400>;
> +                interrupt-parent = <&gic>;
> +                interrupts = <0 76 0x4>;
> +            };
> +
> +            usbhsehci: usb@4a064c00 {
> +                compatible = "ti,ehci-omap";
> +                reg = <0x4a064c00 0x400>;
> +                interrupt-parent = <&gic>;
> +                interrupts = <0 77 0x4>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15052c0f5377..d1dadba8ed0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19406,6 +19406,7 @@ W:	http://linux.omap.com/
>  Q:	http://patchwork.kernel.org/project/linux-omap/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>  F:	Documentation/devicetree/bindings/arm/ti/omap.yaml
> +F:	Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
>  F:	Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
>  F:	arch/arm/configs/omap2plus_defconfig
>  F:	arch/arm/mach-omap2/
> 
> -- 
> 2.53.0
> 
