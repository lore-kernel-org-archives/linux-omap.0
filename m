From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 3/8] ARM: OMAP5: Thermal: Add slope and offset values
Date: Tue, 28 Mar 2017 21:33:04 -0700
Message-ID: <20170329043302.GA1596@localhost.localdomain>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 09, 2017 at 01:35:57PM +0530, Keerthy wrote:
> Currently the slope and offset values for calculating the
> hot spot temperature of a particular thermal zone is part
> of driver data. Pass them here instead and obtain the values
> while of node parsing.


The patch is fine.. but

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 222155c..eaff2a5 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -1127,6 +1127,15 @@
>  
>  &cpu_thermal {
>  	polling-delay = <500>; /* milliseconds */
> +	coefficients = <65 (-1791)>;

I suppose you tried this change with this patch:
https://patchwork.kernel.org/patch/9619577/
?

Otherwise, I do not see how your coeff would work, right?

>  };
>  
>  /include/ "omap54xx-clocks.dtsi"
> +
> +&gpu_thermal {
> +	coefficients = <117 (-2992)>;
> +};
> +
> +&core_thermal {
> +	coefficients = <0 2000>;
> +};
> -- 
> 1.9.1
> 
