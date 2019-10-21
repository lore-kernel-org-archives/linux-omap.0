From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 01/10] dt-bindings: sram: Convert SRAM bindings to
 json-schema
Date: Mon, 21 Oct 2019 15:25:36 +0200
Message-ID: <20191021132536.GA2791@pi3>
References: <20191002164316.14905-1-krzk@kernel.org>
 <20191010191240.GA15006@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191010191240.GA15006@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 10, 2019 at 02:12:40PM -0500, Rob Herring wrote:
> On Wed, Oct 02, 2019 at 06:43:07PM +0200, Krzysztof Kozlowski wrote:
> > Convert generic mmio-sram bindings to DT schema format using
> > json-schema.  Require the address/size cells to be 1, not equal to root
> > node.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v2:
> > 1. Add Rob as maintainer,
> > 2. Use "contains" for compatible,
> > 3. Fix address and size cells to 1,
> > 4. Add maxitems to reg under children,
> > 5. Remove unneeded string type from label.
> > 
> > Changes since v1:
> > 1. Indent example with four spaces (more readable).
> > ---
> >  .../devicetree/bindings/sram/sram.txt         |  80 -----------
> >  .../devicetree/bindings/sram/sram.yaml        | 134 ++++++++++++++++++
> >  2 files changed, 134 insertions(+), 80 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
> >  create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml
> 
> 
> > diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> > new file mode 100644
> > index 000000000000..a1c1ec2183f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> > @@ -0,0 +1,134 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sram/sram.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic on-chip SRAM
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +
> > +description: |+
> > +  Simple IO memory regions to be managed by the genalloc API.
> > +
> > +  Each child of the sram node specifies a region of reserved memory. Each
> > +  child node should use a 'reg' property to specify a specific range of
> > +  reserved memory.
> > +
> > +  Following the generic-names recommended practice, node names should
> > +  reflect the purpose of the node. Unit address (@<address>) should be
> > +  appended to the name.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^sram(@.*)?"
> > +
> > +  compatible:
> > +    contains:
> > +      enum:
> > +        - mmio-sram
> > +        - atmel,sama5d2-securam
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges:
> > +    description:
> > +      Should translate from local addresses within the sram to bus addresses.
> > +
> > +  no-memory-wc:
> > +    description:
> > +      The flag indicating, that SRAM memory region has not to be remapped
> > +      as write combining. WC is used by default.
> > +    type: boolean
> > +
> > +patternProperties:
> > +  "^([a-z]*-)?sram@[a-f0-9]$":
> > +    type: object
> > +    description:
> > +      Each child of the sram node specifies a region of reserved memory.
> > +    properties:
> > +      reg:
> > +        description:
> > +          IO mem address range, relative to the SRAM range.
> > +        maxItems: 1
> > +
> > +      compatible:
> > +        $ref: /schemas/types.yaml#/definitions/string
> 
> No need to define the type again. We can say 'maxItems: 1' if we really 
> want to force it to 1 entry.

I'll fix it and integrate Samsung compatibles here.

> 
> > +        description:
> > +          Should contain a vendor specific string in the form
> > +          <vendor>,[<device>-]<usage>
> > +
> > +      pool:
> > +        description:
> > +          Indicates that the particular reserved SRAM area is addressable
> > +          and in use by another device or devices.
> > +        type: boolean
> > +
> > +      export:
> > +        description:
> > +          Indicates that the reserved SRAM area may be accessed outside
> > +          of the kernel, e.g. by bootloader or userspace.
> > +        type: boolean
> > +
> > +      protect-exec:
> > +        description: |
> > +          Same as 'pool' above but with the additional constraint that code
> > +          will be run from the region and that the memory is maintained as
> > +          read-only, executable during code execution. NOTE: This region must
> > +          be page aligned on start and end in order to properly allow
> > +          manipulation of the page attributes.
> > +        type: boolean
> > +
> > +      label:
> > +        description:
> > +          The name for the reserved partition, if omitted, the label is taken
> > +          from the node name excluding the unit address.
> > +
> > +      clocks:
> 
> Shouldn't this be up one level? Looks like this is the only case 
> (Marvell and i.MX are the only ones I see with clocks).

Yes, that's a mistake in original bindings.

> 
> > +        description:
> > +          A list of phandle and clock specifier pair that controls the
> > +          single SRAM clock.
> 
> maxItems: 1

Yes.

> 
> > +
> > +    required:
> > +      - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> 
> Does 'additionalProperties' work here and/or in the child node? I guess 
> not if we keep some node names.

It seems that it works.

> 
> > +
> > +examples:
> > +  - |
> > +    sram: sram@5c000000 {
> > +        compatible = "mmio-sram";
> > +        reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges = <0 0x5c000000 0x40000>;
> > +
> > +        smp-sram@100 {
> > +            compatible = "socvendor,smp-sram";
> > +            reg = <0x100 0x50>;
> > +        };
> > +
> > +        device-sram@1000 {
> > +            reg = <0x1000 0x1000>;
> > +            pool;
> > +        };
> > +
> > +        exported@20000 {
> 
> This one doesn't match the pattern. That's fine I guess for dts files, 
> but examples should be good examples.

Sure.

Best regards,
Krzysztof

> 
> > +            reg = <0x20000 0x20000>;
> > +            export;
> > +        };
> > +    };
> > -- 
> > 2.17.1
> > 
