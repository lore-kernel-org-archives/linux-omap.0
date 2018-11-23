From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Fri, 23 Nov 2018 08:24:17 -0800
Message-ID: <20181123162417.GZ53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542886753-17625-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> From: Suman Anna <s-anna@ti.com>
> +Example:
> +========
> +1.	/* AM33xx PRU-ICSS */
> +	pruss_soc_bus: pruss_soc_bus@4a326004 {
> +		compatible = "ti,am3356-pruss-soc-bus";
> +		ti,hwmods = "pruss";
> +		reg = <0x4a326004 0x4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

The top level interconnect target module driver should be just ti-sysc
as documented in Documentation/devicetree/bindings/bus/ti-sysc.txt.
AFAIK there is nothing PRU specific there. So let's not add yet
another custom interconnect target module handling code to deal with.

I also posted a patch a while back for using reset-simple with
ti-sysc as "[PATCHv2] reset: ti-rstctrl: use the reset-simple driver".

> +			pruss_cfg: cfg@4a326000 {
> +				compatible = "syscon";
> +				reg = <0x4a326000 0x2000>;
> +			};
> +
> +			pruss_iep: iep@4a32e000 {
> +				compatible = "syscon";
> +				reg = <0x4a32e000 0x31c>;
> +			};
> +
> +			pruss_mii_rt: mii_rt@4a332000 {
> +				compatible = "syscon";
> +				reg = <0x4a332000 0x58>;
> +			};

Hmm what are these syscon register actually doing? Sseems like
they should be just handled by a phy driver nowadays?

Other than that the binding looks OK to me. Good to finally
see some activity in getting the PRU support merged :)

Regards,

Tony
