From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: add img,pvrsgx.yaml for Imagination
 GPUs
Date: Thu, 5 Dec 2019 11:01:13 -0600
Message-ID: <20191205170113.GA853@bogus>
References: <cover.1574595627.git.hns@goldelico.com>
 <c93eff41b4a85ec01fa01819af8a380b7465e01c.1574595627.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c93eff41b4a85ec01fa01819af8a380b7465e01c.1574595627.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 24, 2019 at 12:40:21PM +0100, H. Nikolaus Schaller wrote:
> The Imagination PVR/SGX GPU is part of several SoC from
> multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
> and others.
> 
> With this binding, we describe how the SGX processor is
> interfaced to the SoC (registers, interrupt etc.).
> 
> In most cases, Clock, Reset and power management is handled
> by a parent node or elsewhere.
> 
> Tested by make dt_binding_check dtbs_check
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
> new file mode 100644
> index 000000000000..fe206a53cbe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/img,pvrsgx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination PVR/SGX GPU
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +
> +description: |+
> +  This binding describes the Imagination SGX5 series of 3D accelerators which
> +  are found in several different SoC like TI OMAP, Sitara, Ingenic JZ4780,
> +  Allwinner A83, and Intel Poulsbo and CedarView and more.
> +
> +  For an almost complete list see: https://en.wikipedia.org/wiki/PowerVR#Implementations
> +  
> +  Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently covered by
> +  this binding but the extension of the pattern is straightforward.
> +  
> +  The SGX node is usually a child node of some DT node belonging to the SoC
> +  which handles clocks, reset and general address space mapping of the SGX
> +  register area.
> +
> +properties:
> +  compatible:
> +    enum:
> +    # BeagleBoard ABC, OpenPandora 600MHz

I'd expect compatibles to be per SoC, not per board.

> +      - ti,omap3-sgx530-121, img,sgx530-121, img,sgx530, img,sgx5

4 compatibles is probably a bit much. Are there not any version or 
feature registers that some of this could be detected? If there are, I'd 
assume the middle 2 strings could be dropped. If not, drop the last one 
and just match on the 3rd string. It's not a long list.

> +    # BeagleBoard XM, GTA04, OpenPandora 1GHz
> +      - ti,omap3-sgx530-125, img,sgx530-125, img,sgx530, img,sgx5
> +    # BeagleBone Black
> +      - ti,am3352-sgx530-125, img,sgx530-125, img,sgx530, img,sgx5
> +    # Pandaboard, Pandaboard ES
> +      - ti,omap4-sgx540-120, img,sgx540-120, img,sgx540, img,sgx5
> +      - ti,omap4-sgx544-112, img,sgx544-112, img,sgx544, img,sgx5
> +    # OMAP5 UEVM, Pyra Handheld
> +      - ti,omap5-sgx544-116, img,sgx544-116, img,sgx544, img,sgx5
> +      - ti,dra7-sgx544-116, img,sgx544-116, img,sgx544, img,sgx5
> +    # CI20
> +      - ingenic,jz4780-sgx540-120, img,sgx540-120, img,sgx540, img,sgx5
> +    # the following entries are not validated with real hardware
> +    # more TI
> +      - ti,am3517-sgx530-125, img,sgx530-125, img,sgx530, img,sgx5
> +      - ti,am4-sgx530-125, img,sgx530-125, img,sgx530, img,sgx5
> +      - ti,ti81xx-sgx530-125, img,sgx530-125, img,sgx530, img,sgx5
> +    # Banana-Pi-M3 (Allwinner A83T)
> +      - allwinner,sun8i-a83t-sgx544-116, img,sgx544-116, img,sgx544, img,sgx5
> +    # Atom Z5xx
> +      - intel,poulsbo-gma500-sgx535, img,sgx535-116, img,sgx535, img,sgx5
> +    # Atom Z24xx
> +      - intel,medfield-gma-sgx540, img,sgx540-116, img,sgx540, img,sgx5
> +    # Atom N2600, D2500
> +      - intel,cedarview-gma3600-sgx545, img,sgx545-116, img,sgx545, img,sgx5
> +
> +  reg:
> +    maxItems: 1
> +    description: physical base address and length of the register area

No need to give a generic description of a standard property.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt line from SGX subsystem to core processor

Same here.

> +
> +  clocks:
> +    description: optional clocks

Need to define how many and what they are. Or drop until you know.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Add:

additionalProperties: false

> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu@fe00 {
> +      compatible = "ti,omap-omap5-sgx544-116", "img,sgx544-116", "img,sgx544", "img,sgx5";
> +      reg = <0xfe00 0x200>;
> +      interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +...
> -- 
> 2.23.0
> 
