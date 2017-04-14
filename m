From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7: Add power hold and power controller
 properties to palmas
Date: Fri, 14 Apr 2017 07:21:42 -0700
Message-ID: <20170414142142.GT5339@atomide.com>
References: <1492059081-20124-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492059081-20124-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170412 21:55]:
> Add power hold and power controller properties to palmas node.
> This is needed to shutdown pmic correctly on boards with
> powerhold set.

Is this OK to wait for v4.12 or is this needed as a fix for
the -rc series?

Regards,

Tony

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 4bc4b57..31a9e06 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -204,6 +204,8 @@
>  	tps659038: tps659038@58 {
>  		compatible = "ti,tps659038";
>  		reg = <0x58>;
> +		ti,palmas-override-powerhold;
> +		ti,system-power-controller;
>  
>  		tps659038_pmic {
>  			compatible = "ti,tps659038-pmic";
> -- 
> 1.9.1
> 
