From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/8] RFC: dt-bindings: add img,pvrsgx.yaml for
 Imagination GPUs
Date: Thu, 7 Nov 2019 08:35:27 -0600
Message-ID: <CAL_Jsq+ri3AXb=qhedBzQ6WufLm4aPrSqNxXiHd3_=mH3vJ8xw@mail.gmail.com>
References: <cover.1573124770.git.hns@goldelico.com> <4292cec1fd82cbd7d42742d749557adb01705574.1573124770.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4292cec1fd82cbd7d42742d749557adb01705574.1573124770.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, openpvrsgx-devgroup@letux.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, "open list:MIPS" <linux-mips@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 7, 2019 at 5:06 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> The Imagination PVR/SGX GPU is part of several SoC from
> multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
> and others.
>
> With this binding, we describe how the SGX processor is
> interfaced to the SoC (registers, interrupt etc.).
>
> Clock, Reset and power management should be handled
> by a parent node or elsewhere.

That's probably TI specific...

> ---
>
> I have used the doc2yaml script to get a first veryion
> but I am still stuggling with the yaml thing. My impression
> is that while it is human readable, it is not very human
> writable... Unfortunately I haven't found a good tutorial
> for Dummies (like me) for bindings in YAML.

Did you read .../bindings/example-schema.yaml? It explains the common
cases and what schema are doing. I recently added to it, so look at
the version in linux-next.

> The big problem is not the YAML syntax but what the schema
> should contain and how to correctly formulate ideas in this
> new language.
>
> Specific questions for this RFC:
>
> * formatting: is space/tab indentation correct?

YAML requires spaces.

> * are strings with "" correct or without?

Generally only keys or values starting with '#' need quotes. There's
other cases, but we simply don't hit them with DT. We tend to quote
$ref values, but that's not strictly needed.

> * how do I specify that there is a list of compatible strings required in a specific order?

An 'items' list defines the order.

> * but there are multiple such lists, and only one of them is to be chosen?

                                                ^^^^^^
'oneOf' is the schema keyword you are looking for.

> * how can be described in the binding that there should be certain values in
>   the parent node (ranges) to make it work?

You can't. Schemas match on a node and work down from there. So you
can do it, but it's more complicated. You'd need a custom 'select'
select that matches on the parent node having the child node you are
looking for (assuming the parent is something generic like
'simple-bus' which you can't match on). However, based on the example,
I'd say checking 'ranges' is outside the scope of schema checks.
'ranges' doesn't have to be a certain value any more than every case
of 'reg' (except maybe i2c devices with fixed addresses). It's up to
the .dts author how exactly to do address translation.

I would like to have more ranges/reg checks such as bounds checks and
overlapping addresses, but I think we'd do those with code, not
schema.

> I was not able to run
>
>         make dt_binding_check dtbs_check
>
> due to some missing dependencies (which I did not want to
> invest time to research them) on my build host, so I could
> not get automated help from those.

Dependencies are documented in Documentation/devicetree/writing-schema.rst.

> ---
>  .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
>
> diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
> new file mode 100644
> index 000000000000..b1b021601c47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: None

Obviously not valid.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/gpu/img,pvrsgx.yaml#

This should have been correct with the script, but you need to drop 'bindings'.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination PVR/SGX GPU
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +description: |+
> +  This binding describes the Imagination SGX5 series of 3D accelerators which
> +  are found in several different SoC like TI OMAP, Sitara, Ingenic JZ4780,
> +  Allwinner A83, and Intel Poulsbo and CedarView.
> +
> +  Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently covered by
> +  this binding.
> +
> +  The SGX node is usually a child node of some DT node belonging to the SoC
> +  which handles clocks, reset and general address space mapping of the SGX
> +  register area.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - item:

'item/items'

> +        # BeagleBoard ABC, OpenPandora 600MHz
> +        - const: "ti,omap3-sgx530-121", "img,sgx530-121", "img,sgx530", "img,sgx5"

Not valid YAML nor json-schema. Each value needs to be list item with 'const:'

Plenty of examples in bindings/arm/ with board/soc bindings.

> +        # BeagleBoard XM, GTA04, OpenPandora 1GHz
> +        - const: "ti,omap3-sgx530-125", "img,sgx530-125", "img,sgx530", "img,sgx5"

This needs to be a new 'items' list under 'oneOf'.

> +        # BeagleBone Black
> +        - const: "ti,am335x-sgx530-125", "img,sgx530-125", "img,sgx530", "img,sgx5"
> +        # Pandaboard (ES)
> +        - const: "ti,omap4-sgx540-120", "img,sgx540-120", "img,sgx540", "img,sgx5"
> +        - const "ti,omap4-sgx544-112", "img,sgx544-112", "img,sgx544", "img,sgx5"
> +        # OMAP5 UEVM, Pyra Handheld
> +        "ti,omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5"
> +        "ti,dra7-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5"

Just gave up on trying to write a schema here?

> +        # CI20
> +        "ingenic,jz4780-sgx540-120", "img,sgx540-120", "img,sgx540", "img,sgx5";
> +
> +  reg:
> +    items:
> +      - description: physical base address and length of the register area

For single entries, just 'maxItems: 1' is enough. Unless you have
something special about this device, you don't need a description
here.

> +
> +  interrupts:
> +     items:
> +      - description: interrupt from SGX subsystem to core processor
> +
> +  clocks:
> +     items:
> +      - description: optional clocks
> +
> +  required:
> +    - compatible
> +    - reg
> +    - interrupts
> +
> +examples: |
> +  gpu@fe00 {
> +       compatible = "ti,omap-omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5";
> +       reg = <0xfe00 0x200>;
> +       interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +  };
> +
> +
> +historical: |

This should be dropped. It's just for reference as you write the schema.

> +  Imagination PVR/SGX GPU
> +
> +  Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently covered by this binding.
> +
> +  Required properties:
> +  - compatible:        Should be one of
> +               "ti,omap3-sgx530-121", "img,sgx530-121", "img,sgx530", "img,sgx5"; - BeagleBoard ABC, OpenPandora 600MHz
> +               "ti,omap3-sgx530-125", "img,sgx530-125", "img,sgx530", "img,sgx5"; - BeagleBoard XM, GTA04, OpenPandora 1GHz
> +               "ti,am3517-sgx530-125", "img,sgx530-125", "img,sgx530", "img,sgx5";
> +               "ti,am335x-sgx530-125", "img,sgx530-125", "img,sgx530", "img,sgx5"; - BeagleBone Black
> +               "ti,omap4-sgx540-120", "img,sgx540-120", "img,sgx540", "img,sgx5"; - Pandaboard (ES)
> +               "ti,omap4-sgx544-112", "img,sgx544-112", "img,sgx544", "img,sgx5";
> +               "ti,omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5"; - OMAP5 UEVM, Pyra Handheld
> +               "ti,dra7-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5";
> +               "ti,am3517-sgx530-?", "img,sgx530-?", "img,sgx530", "img,sgx5";
> +               "ti,am43xx-sgx530-?", "img,sgx530-?", "img,sgx530", "img,sgx5";
> +               "ti,ti81xx-sgx530-?", "img,sgx530-?", "img,sgx530", "img,sgx5";
> +               "img,jz4780-sgx540-?", "img,sgx540-?", "img,sgx540", "img,sgx5"; - CI20
> +               "allwinner,sun8i-a83t-sgx544-?", "img,sgx544-116", "img,sgx544", "img,sgx5"; - Banana-Pi-M3 (Allwinner A83T)
> +               "intel,poulsbo-gma500-sgx535", "img,sgx535-116", "img,sgx535", "img,sgx5"; - Atom Z5xx
> +               "intel,medfield-gma-sgx540", "img,sgx540-116", "img,sgx540", "img,sgx5"; - Atom Z24xx
> +               "intel,cedarview-gma3600-sgx545", "img,sgx545-116", "img,sgx545", "img,sgx5"; - Atom N2600, D2500
> +
> +               The "ti,omap..." entries are needed temporarily to handle SoC
> +               specific builds of the kernel module.
> +
> +               In the long run, only the "img,sgx..." entry should suffice
> +               to match a generic driver for all architectures and driver
> +               code can dynamically find out on which SoC it is running.
> +
> +
> +  - reg:               Physical base address and length of the register area.
> +  - interrupts:        The interrupt numbers.
> +
> +  / {
> +       ocp {
> +               sgx_module: target-module@56000000 {
> +                       compatible = "ti,sysc-omap4", "ti,sysc";
> +                       reg = <0x5600fe00 0x4>,
> +                             <0x5600fe10 0x4>;
> +                       reg-names = "rev", "sysc";
> +                       ti,sysc-midle = <SYSC_IDLE_FORCE>,
> +                                       <SYSC_IDLE_NO>,
> +                                       <SYSC_IDLE_SMART>;
> +                       ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +                                       <SYSC_IDLE_NO>,
> +                                       <SYSC_IDLE_SMART>;
> +                       clocks = <&gpu_clkctrl OMAP5_GPU_CLKCTRL 0>;
> +                       clock-names = "fck";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0x56000000 0x2000000>;
> +
> +                       gpu@fe00 {
> +                               compatible = "ti,omap-omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5";
> +                               reg = <0xfe00 0x200>;
> +                               interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +               };
> +       };
> +  };
> --
> 2.23.0
>
