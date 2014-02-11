From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH] ARM: dts: OMAP5: add pmu node
Date: Tue, 11 Feb 2014 14:14:16 -0600
Message-ID: <52FA8498.5050507@mentor.com>
References: <1391014601-31663-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:34079 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbaBKUOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2014 15:14:20 -0500
In-Reply-To: <1391014601-31663-1-git-send-email-nathan_lynch@mentor.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com

On 01/29/2014 10:56 AM, Nathan Lynch wrote:
> Expose the PMU on OMAP5.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

OMAP folks, any issues with this patch?


> ---
> 
> Notes:
>     Briefly tested with perf on OMAP5 UEVM with next-20140124.
> 
>  arch/arm/boot/dts/omap5.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a72813a9663e..fbf4661436e2 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -76,6 +76,12 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <0 131 4>,
> +			     <0 132 4>;
> +	};
> +
>  	gic: interrupt-controller@48211000 {
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
> 

