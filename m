Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96A33AD8B;
	Fri,  9 Oct 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560340; cv=none; b=uVJ30owGeZBtjKSWlLfDEocigQT3HHEEu2+XoWbTgg9yiADiW4C09Yp0tUCwmFvr3Jnw46S2LoTDJOtzqwVA4eNc5WnGO/WjQIRRHTT6cxcGEPIWE1Id7k+WigPB5bD4KwsEhgwUJpG4QBQpAG/D/n2lqcqDZHdKHFjliJYXML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560340; c=relaxed/simple;
	bh=fnMnrukx9Glf3GXBIbnRudycMsbdTuWzE0WiXwuRgL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+PVKX++E3Yl1HTetsnMM+Kxu1/xnDCny57M77onnwMEi+fuLF0N4R8pIzT5Sn/lSvkT+jz8AvvCJMvbPlcRbhfgVrlHOXJ2rXzec57b9XyNvPBFrGGuOrYlWDa2Ad/kedMcMj46bV8iu3TCi3W5CAqyiDukgm0quC4NJEGfOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHxTJXV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHxTJXV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CF51F000FF;
	Fri,  9 Oct 2026 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560338;
	bh=EyYI5Bvz0oSkR9/M8GqMlgc8PLg+HxYsg2cxJ36I6hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHxTJXV6LhebRwBQbr22QEuSv0ftXtEBZTHx7yK2dU6dmmmuTqyK6ekFQ5h5LNt2a
	 RBbB1gfPVKOUXlbEfz2C3rS3ASpMlEAI12bj+t8bMEQJf9j2X10yakpRvzRX+MfAD1
	 y7hgB3v8Za7bhdwET4SglQiBrS5Way11BTqokd2NUXyuy2PjCjzSBrjq0KOx+TostC
	 I32B2gN3+1zQv5QeuZcf9KTjWJUKhtwzO3AegZZ2hdLO6pYYPZPaiwyoOYyIziggSi
	 vQyDKZttOZwOrDPRDocNEOwtedEpaSpDLnZWaJfY4dLn8fJb/FhTLUbJnMX5KxigqN
	 jH8GnLydkadBQ==
Date: Fri, 9 Oct 2026 10:38:57 -0500
From: Rob Herring <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009153857.GA1690986-robh@kernel.org>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009105601.301891-2-quchaosheng000406@163.com>

On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
> 
> Convert the TPD12S015 HDMI level shifter binding to DT schema.
> 
> The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> and ESD protection circuitry. Document the two ports it exposes between
> the HDMI transmitter and the connector.
> 
> The tpd12s016 is software compatible with the tpd12s015 and is listed as
> a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
> a board using the tpd12s016 must list both compatibles.
> 
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> deleted file mode 100644
> index 26e6d32e3f20..000000000000
> --- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -TPD12S015 HDMI level shifter and ESD protection chip
> -====================================================
> -
> -Required properties:
> -- compatible: "ti,tpd12s015"
> -
> -Optional properties:
> -- gpios: CT CP HPD, LS OE and HPD gpios
> -
> -Required nodes:
> -- Video port 0 for HDMI input
> -- Video port 1 for HDMI output
> -
> -Example
> --------
> -
> -tpd12s015: encoder@1 {
> -	compatible = "ti,tpd12s015";
> -
> -	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
> -		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
> -		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -
> -			tpd12s015_in: endpoint@0 {
> -				remote-endpoint = <&hdmi_out>;
> -			};
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			tpd12s015_out: endpoint@0 {
> -				remote-endpoint = <&hdmi_connector_in>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 000000000000..1927da3bd736
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPD12S015 HDMI level shifter and ESD protection chip
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> +
> +description: |

Don't need '|'.

> +  The TPD12S015 is an HDMI companion chip that combines a level shifter and
> +  ESD protection circuitry. It sits between an HDMI transmitter and the HDMI
> +  connector, and provides control over the level shifter enable and the
> +  hot-plug detect signals.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tpd12s015
> +      - items:
> +          - const: ti,tpd12s016
> +          - const: ti,tpd12s015
> +
> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first controls
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3

Use this form instead:

items:
  - description: ...
  - description: ...
  - description: ...
 
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false

No extra properties, so use:

$ref: /schemas/graph.yaml#/properties/port

(and no need for unevaluatedProperties)

> +        description: HDMI input from the transmitter.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: HDMI output to the connector.

Same here.

Rob
