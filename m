From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: counter: new bindings for TI eQEP
Date: Wed, 21 Aug 2019 15:31:27 -0500
Message-ID: <20190821203127.GA29308@bogus>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-3-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807194023.15318-3-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 07, 2019 at 02:40:20PM -0500, David Lechner wrote:
> This documents device tree binding for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> - convert to .yaml format
> - rename clock to "sysclkout"
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> new file mode 100644
> index 000000000000..8f8b2e87e5c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/ti-eqep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
> +
> +maintainers:
> +  - David Lechner <david@lechnology.com>
> +
> +properties:
> +  compatible:
> +    const: "ti,am3352-eqep"

No need for quotes

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: The eQEP event interrupt

Don't really have to have a description when there is only 1 entry.

> +    maxItems: 1
> +
> +  clocks:
> +    description: The clock that determines the SYSCLKOUT rate for the eQEP
> +                 peripheral.

Same here. 2 spaces in from description is the normal indentation.

> +    maxItems: 1
> +
> +  clock-names:
> +    const: sysclkout
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    eqep0: eqep@180 {

counter@...

> +        compatible = "ti,am3352-eqep";
> +        reg = <0x180 0x80>;
> +        clocks = <&l4ls_gclk>;
> +        clock-names = "sysclkout";
> +        interrupts = <79>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
