From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] arm: dra7: Add hwmod entry for i2c6
Date: Thu, 26 May 2016 09:25:24 +0530
Message-ID: <574673AC.2030209@ti.com>
References: <20160525125341.10044-1-rk@ti.com>
 <20160525125341.10044-2-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160525125341.10044-2-rk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 25 May 2016 06:23 PM, Ravikumar Kattekola wrote:
> dra72x device has i2c6 controller.
> Adding hwmod definition for the same.
> 
> Reference DRA72x TRM [ SPRUHP2Q ]
> 
> Signed-off-by: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index d0e7e525..b84c0f7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1127,6 +1127,20 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
>  	.dev_attr	= &i2c_dev_attr,
>  };
>  
> +/* i2c6 */
> +static struct omap_hwmod dra7xx_i2c6_hwmod = {
> +	.name		= "i2c6",
> +	.class		= &dra7xx_i2c_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> +	.main_clk	= "func_96m_fclk",
> +	.prcm = {
> +		.omap4 = {
> +		},
> +	},
> +	.dev_attr	= &i2c_dev_attr,
> +};
> +
>  /*
>   * 'mailbox' class
>   *
> @@ -3186,6 +3200,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c5 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/* l4_per2 -> i2c6 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__i2c6 = {
> +	.master		= &dra7xx_l4_per2_hwmod,
> +	.slave		= &dra7xx_i2c6_hwmod,
> +	.clk		= "l3_iclk_div",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* l4_cfg -> mailbox1 */
>  static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mailbox1 = {
>  	.master		= &dra7xx_l4_cfg_hwmod,
> @@ -3857,6 +3879,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>  	&dra7xx_l4_per1__i2c3,
>  	&dra7xx_l4_per1__i2c4,
>  	&dra7xx_l4_per1__i2c5,
> +	&dra7xx_l4_per2__i2c6,

If it is available only on dra72x, register the hwmod under
dra72x_hwmod_ocp_ifs. Also in $subject use dra72x to make things clear.

Thanks and regards,
Lokesh

>  	&dra7xx_l4_cfg__mailbox1,
>  	&dra7xx_l4_per3__mailbox2,
>  	&dra7xx_l4_per3__mailbox3,
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
