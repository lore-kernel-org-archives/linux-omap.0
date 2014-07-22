From: Suman Anna <s-anna@ti.com>
Subject: Re: [v3 PATCH 2/6] dt: TI: Describe the ti reset DT entries
Date: Tue, 22 Jul 2014 13:51:06 -0500
Message-ID: <53CEB29A.4060109@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com> <1405615531-15649-2-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbaGVSvb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2014 14:51:31 -0400
In-Reply-To: <1405615531-15649-2-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

Hi Dan,

On 07/17/2014 11:45 AM, Murphy, Dan wrote:
> Describe the TI reset DT entries for TI SoC's.

The document definitely needs some cleanup. Here are comments from a
quick glance. In any case, I think this binding will change as you
address Tony's comments.

> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - Changed Headline no other changes
> 
>  .../devicetree/bindings/reset/ti,reset.txt         |  103 ++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/ti,reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti,reset.txt b/Documentation/devicetree/bindings/reset/ti,reset.txt
> new file mode 100644
> index 0000000..9d5c29c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/ti,reset.txt
> @@ -0,0 +1,103 @@
> +Texas Instruments Reset Controller
> +======================================
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Specifying the reset entries for the IP module
> +==============================================
> +Parent module:
> +This is the module node that contains the reset registers and bits.
> +
> +example:
> +			prcm_resets: resets {
> +				compatible = "ti,dra7-resets";
> +				#reset-cells = <1>;
> +			};
> +
> +Required parent properties:
> +- compatible : Should be one of,
> +		"ti,omap4-prm" for OMAP4 PRM instances
> +		"ti,omap5-prm" for OMAP5 PRM instances
> +		"ti,dra7-prm" for DRA7xx PRM instances
> +		"ti,am4-prcm" for AM43xx PRCM instances
> +		"ti,am3-prcm" for AM33xx PRCM instances

I am not sure if this belongs to the reset driver bindings, as the PRM
and CM nodes are defined at the SoC level. This document should only be
describing the reset nodes bindings.

Also, please list all the required node properties first, before you can
give an example.

> +
> +Required child reset property:
> +- compatible : Should be
> +		"resets" for All TI SoCs

There is no "compatible" child property. This should have been the name
of the node, right? Also, please list all the properties required under
this node like #address-cells, #reset-cells etc.

> +
> +example:
> +		prm: prm@4ae06000 {
> +			compatible = "ti,omap5-prm";
> +			reg = <0x4ae06000 0x3000>;
> +
> +			prm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

This is wrong. You haven't corrected this from v2. The reg field is used
to give the offsets for control register and status register, and does
not use any size fields.

> +				#reset-cells = <1>;
> +			};
> +		};
> +
> +
> +Reset node declaration
> +==============================================
> +The reset node is declared in a parent child relationship.  The main parent
> +is the PRCM module which contains the base address.  The first child within
> +the reset parent declares the target modules reset name.  This is followed by
> +the control and status offsets.

This is not clear. This is the case with each child node, which is
describing a particular reset domain, and then the individual resets
themselves are defined as child nodes of this reset domain child node.

> +
> +Within the first reset child node is a secondary child node which declares the
> +reset signal of interest.  Under this node the control and status bits
> +are declared.  These bits declare the bit mask for the target reset.
> +
> +
> +Required properties:
> +reg - This is the register offset from the PRCM parent.
> +	This must be declared as:
> +
> +	reg = <control register offset>,
> +		  <status register offset>;
> +
> +control-bit - This is the bit within the register which controls the reset
> +	of the target module.  This is declared as a bit mask for the register.
> +status-bit - This is the bit within the register which contains the status of
> +	the reset of the target module.
> +	This is declared as a bit mask for the register.
> +
> +example:
> +&prm_resets {
> +	dsp_rstctrl {
> +		reg = <0x1c00>,
> +			  <0x1c04>;

I guess both these entries can be defined in one line.

> +
> +		dsp_reset: dsp_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +};
> +
> +
> +
> +Client Node Declaration
> +==============================================
> +This is the consumer of the parent node to declare what resets this
> +particular module is interested in.
> +
> +example:
> +	src: src@55082000 {
> +		    resets = <&reset_src phandle>;
> +			reset-names = "<reset_name>";
> +	};
> +
> +Required Properties:
> +reset_src - This is the parent DT entry for the reset controller
> +phandle - This is the phandle of the specific reset to be used by the clien
> +	driver.
> +reset-names - This is the reset name of module that the device driver
> +	needs to be able to reset.  This value must correspond to a value within
> +	the reset controller array.

The reset-names is optional as per the reset.txt, so it is not clear if
this is mandatory for this binding.

regards
Suman

> +
> +example:
> +resets = <&prm_resets &dsp_mmu_reset>;
> +reset-names = "dsp_mmu_reset";
> 

