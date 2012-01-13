From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller
 bindings for INTC
Date: Fri, 13 Jan 2012 06:14:17 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A43FC@DBDE01.ent.ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2AMGOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 01:14:32 -0500
In-Reply-To: <1324388398-2683-5-git-send-email-b-cousson@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Dec 20, 2011 at 19:09:57, Cousson, Benoit wrote:
> Update the DTS with the proper information required by the
> INTC bindings.
> 
> - Add the number of interrupt lines
> - Add the reg and the compatible entries.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/omap3.dtsi |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..6866dc7 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -54,10 +54,12 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> -		intc: interrupt-controller@1 {
> -			compatible = "ti,omap3-intc";
> +		intc: interrupt-controller@48200000 {
> +			compatible = "ti,omap2-intc";
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> +			ti,intc-size = <96>;
Can we configure/change this field in platform specific .dts file?
OR
Is there condition based configuration possible in DT?

To be specific,

I am adding support for AM335x EVM (using all your DT support patches),
The device is considered as OMAP3 variant and when it comes to INTC support,
I need to configure it to value "128", rest everything is same 
(including base add).

Can I do something like

File - am335x-evm.dts

/include/ "omap3.dtsi"

....
Again change the specific fields of " intc: interrupt-controller"?
....

How can this be handled?

Thanks,
Vaibhav
> +			reg = <0x48200000 0x1000>;
>  		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

