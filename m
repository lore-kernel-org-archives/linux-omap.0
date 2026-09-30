Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E492E8B83;
	Wed, 30 Sep 2026 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746231; cv=none; b=Wnm6o1WOXqRVp9tASQX02kOrCr6DkPBAxcDOE91bHRgLNme++KQ7UxZIPXAvbucooDx4DhtSntbc/n56Ta3g6WKMMRSIuoM+ZgYh/ae42Stt4L9Hjuh1q7/h74oCxrbAK4WmbPRicoAi+Tbb/9Iu7FJo1IZv6nYQfjj0MLGJhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746231; c=relaxed/simple;
	bh=aAIJo6SDmYNK5YNMvXjeLNu+ET1+P6HzBtQ0gfLZN4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDkA4wR5nrOamhWvwHOjMzwvw5dqEe/XUkNdzjJVmBwGVL0+H/msqZSlK01OinfRtmTmVtSUezJR1mZD51f15OeOedk5tm5b+erkudeSrSKb2r9xSloLohahLBKdU3zobtDgKdxpZcEUPL5e45lGgU1H962k5QzQYa2zqco5TT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KmSZYoM3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KmSZYoM3"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D758C24;
	Wed, 30 Sep 2026 07:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790746115;
	bh=aAIJo6SDmYNK5YNMvXjeLNu+ET1+P6HzBtQ0gfLZN4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmSZYoM3Chsg4wB9FSC2ESz6nW1if3JAAUznP8aMWHLRohZXZa258fJczEoYJYm1s
	 6MhlDWuGoW5OrnnLoCCw6Vq1OIUXWcgDJ0Jyn1rDYEVBmzKwNAnrcx9Nb6XWmOKxgb
	 PCvQ3qf9BU8jgCMPoByBSwXTBL011EtmeSgYrm2o=
Date: Wed, 30 Sep 2026 08:30:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com,
	simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: display: ti: Convert ti, tpd12s015 to
 DT schema
Message-ID: <20260930053025.GB931211@killaraus.ideasonboard.com>
References: <20260730092245.52034-1-egbostina@gmail.com>
 <20260730092245.52034-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730092245.52034-2-egbostina@gmail.com>

On Thu, Jul 30, 2026 at 12:22:44PM +0300, Eduard Bostina wrote:
> Convert the Texas Instruments TPD12S015 HDMI level shifter and
> ESD protection chip bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Added the 'ti,tpd12s016' compatible string, which is used in
>   am57xx device trees.
> - The 'gpios' property now allows up to 5 items, as the
>   omap5-igep0050 device tree routes additional control pins
>   beyond the standard 3 documented in the old text file.

Isn't this an issue in the omap5-igep0050 DT sources, rather than in the
binding ?

> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> deleted file mode 100644
> index 26e6d32e3..000000000
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
> index 000000000..bda4bbab7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TPD12S015 HDMI level shifter and ESD protection
> +
> +maintainers:
> +  - Eduard Bostina <egbostina@gmail.com>
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
> +    minItems: 3
> +    maxItems: 5
> +    description: CT CP HPD, LS OE, HPD, and optional supplementary control gpios
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for HDMI input
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for HDMI output
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    encoder {
> +        compatible = "ti,tpd12s015";
> +
> +        gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>, /* 60, CT CP HPD */
> +                <&gpio2 9 GPIO_ACTIVE_HIGH>,  /* 41, LS OE */
> +                <&gpio2 31 GPIO_ACTIVE_HIGH>; /* 63, HPD */
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                tpd12s015_in: endpoint {
> +                    remote-endpoint = <&hdmi_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                tpd12s015_out: endpoint {
> +                    remote-endpoint = <&hdmi_connector_in>;
> +                };
> +            };
> +        };
> +    };

-- 
Regards,

Laurent Pinchart
