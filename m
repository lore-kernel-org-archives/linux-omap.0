From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Thu, 13 Mar 2014 17:46:23 +0000
Message-ID: <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
 <1394701109-6721-5-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55748 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754397AbaCMRqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 13:46:36 -0400
Content-Disposition: inline
In-Reply-To: <1394701109-6721-5-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Mar 13, 2014 at 08:58:29AM +0000, Sathya Prakash M R wrote:
> Add device node for DSS module for AM4372. Both the
> AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
> The lcd timings are added in respective dts files.
> Adds display pinctrl and enables required gpio.
> Also set the right parent clock to the DSS clock.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
>  arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
>  4 files changed, 180 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index ea55a4e..b72a7df 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -684,6 +684,34 @@
>  			num-cs = <4>;
>                          status = "disabled";
>                  };
> +
> +		dss: dss@4832A000 {
> +			compatible = "ti,omap3-dss", "simple-bus";

This doesn't look right to me. I'm not sure it makes sense for
"simple-bus" to be in the compatible list.

Are the child nodes usable in isolation, or are they dependent on the
"ti,omap3-dss" node? What exactly does the "ti,omap3-dss" node
represent?

Thanks,
Mark.

> +			reg = <0x4832A000 0x200>;
> +			ti,hwmods = "dss_core";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			dispc@4832A400 {
> +				compatible = "ti,omap3-dispc";
> +				reg = <0x4832A400 0x400>;
> +				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +				ti,hwmods = "dss_dispc";
> +			};
> +
> +			dpi: encoder@0 {
> +				compatible = "ti,omap3-dpi";
> +			};
> +
> +			rfbi: rfbi@4832A800 {
> +				compatible = "ti,omap3-rfbi";
> +			reg = <0x4832A800 0x100>;
> +				ti,hwmods = "dss_rfbi";
> +			};
> +
> +		};
> +
>  	};
