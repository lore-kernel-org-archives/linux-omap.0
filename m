Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13F29D269;
	Thu, 22 Jan 2026 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124791; cv=none; b=HDX1CcRN4ebXbeN0pVVfzHWtqc01XBc9rQ4XbzjDdKXN9bKKuViYBxN6NCtPDBF0265AuKlKfpaWHB++2Mksq1QcIJOcC7fvIeYvR3H1KSfLsxANabvFIqzSwVa8Xx9xQoAZ4Rtuf1F5V+s1Bcj2KI/yNIx/Rd10BGE0Wm9inm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124791; c=relaxed/simple;
	bh=pBgcuHfBsqcGYcCM6kh6/0Vu9yimUU85rjqw19OCR0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruyeJ4rmNz+24j3AQhJUijb0Lyh3Dt6f5B27eWSbnSOJOjuKtSyq5AI/r0KOsWxgSD/HIiNhUNfLOsBrUWRHjbEAj/ehP37ifG04uKEgKSmDmetVosBbLY1g19qRzTLrod/ugLzpXZuJAmvHPLFjbKKIw2D0GjysExUvgMobvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1uGCuTD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1uGCuTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2D6C116C6;
	Thu, 22 Jan 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769124790;
	bh=pBgcuHfBsqcGYcCM6kh6/0Vu9yimUU85rjqw19OCR0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1uGCuTDNyTkmsGdbFmg459/LcvE7BzbhHNL2MCOqmEefZokLc1gUITpg/wk+yrGz
	 0lZGpoYWUvaz8cfDtQv47PwNRH+Wzb6TU5oVBxDlpZ+29relYZFR2ag8+hRuPL18eO
	 DcpgzHfgpbEE6JGRaCDiPa19vnzfBMqRmfu52wjo8ZNauXRVSiswRe3O0o1R3geHUY
	 74PSqonp8FXGvk16LNAZ4pQYOIS0eFqdzjn6FyEwhh410LJYUYZa8DEVu+WrtmQRmy
	 S7MjJg6dsGGc6WVKeT4Ev+URk3l3mpzXKqLbls2bIUZUbxRw6EZ4taWlWC77gHsD2f
	 N7JO82/xWpFTw==
Date: Thu, 22 Jan 2026 17:33:09 -0600
From: Rob Herring <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: ti,phy-usb3: convert to DT
 schema
Message-ID: <20260122233309.GA3730160-robh@kernel.org>
References: <20260122-ti-phy-v3-0-751619729433@gmail.com>
 <20260122-ti-phy-v3-2-751619729433@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-ti-phy-v3-2-751619729433@gmail.com>

On Thu, Jan 22, 2026 at 05:52:58PM +0000, Charan Pedumuru wrote:
> Convert TI PIPE3 PHY binding to DT schema.
> Changes during conversion:
> - Define a new pattern 'pcie-phy' to match nodes defined in DT.
> - Drop obsolete "id" property from the schema.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 135 +++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
> new file mode 100644
> index 000000000000..605f12f0f79a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/ti,phy-usb3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI PIPE3 PHY Module
> +
> +maintainers:
> +  - Roger Quadros <rogerq@ti.com>
> +
> +description:
> +  The TI PIPE3 PHY is a high-speed SerDes (Serializer/Deserializer)
> +  transceiver integrated in OMAP5, DRA7xx/AM57xx, and similar SoCs.
> +  It supports multiple protocols (USB3, SATA, PCIe) using the PIPE3
> +  interface standard, which defines a common physical layer for
> +  high-speed serial interfaces.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(pcie-phy|usb3-phy|phy)@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - ti,omap-usb3
> +      - ti,phy-pipe3-pcie
> +      - ti,phy-pipe3-sata
> +      - ti,phy-usb3
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: phy_rx
> +      - const: phy_tx
> +      - const: pll_ctrl
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 7
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 7
> +    items:
> +      enum: [wkupclk, sysclk, refclk, dpll_ref,
> +             dpll_ref_m2, phy-div, div-clk]
> +
> +  syscon-phy-power:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: Phandle to the system control module
> +        - description: Register offset controlling PHY power

This allows N entries of 2 cells each. You need either:

items:
  - items:
      - description: ...
      - description: ...

(the hyphen is important!)

Or:

maxItems: 1
items:
  items:
    - description: ...
    - description: ...

> +
> +  syscon-pllreset:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: Phandle to the system control module
> +        - description: Register offset of CTRL_CORE_SMA_SW_0
> +
> +  syscon-pcs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: Phandle to the system control module
> +        - description: Register offset for PCS delay programming
> +
> +  ctrl-module:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle of control module for PHY power on.
> +    deprecated: true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,phy-pipe3-sata
> +    then:
> +      properties:
> +        syscon-pllreset: true
> +    else:
> +      properties:
> +        syscon-pllreset: false
> +
> +required:
> +  - reg
> +  - compatible
> +  - reg-names
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    /* TI PIPE3 USB3 PHY */
> +    usb3-phy@4a084400 {
> +        compatible = "ti,phy-usb3";
> +        reg = <0x4a084400 0x80>,
> +              <0x4a084800 0x64>,
> +              <0x4a084c00 0x40>;
> +        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> +        #phy-cells = <0>;
> +        clocks = <&usb_phy_cm_clk32k>,
> +                 <&sys_clkin>,
> +                 <&usb_otg_ss_refclk960m>;
> +        clock-names = "wkupclk", "sysclk", "refclk";
> +        ctrl-module = <&omap_control_usb>;
> +    };
> +
> +  - |
> +    /* TI PIPE3 SATA PHY */
> +    phy@4a096000 {
> +        compatible = "ti,phy-pipe3-sata";
> +        reg = <0x4A096000 0x80>,  /* phy_rx */
> +              <0x4A096400 0x64>,  /* phy_tx */
> +              <0x4A096800 0x40>;  /* pll_ctrl */

Use lowercase hex.

> +        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> +        clocks = <&sys_clkin1>, <&sata_ref_clk>;
> +        clock-names = "sysclk", "refclk";
> +        syscon-pllreset = <&scm_conf 0x3fc>;
> +        #phy-cells = <0>;
> +    };
> +...
> 
> -- 
> 2.52.0
> 
