From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9 v3] usb: musb: HWMOD database structures addition
 for OMAP4
Date: Wed, 22 Sep 2010 22:54:41 +0200
Message-ID: <4C9A6D11.5090905@ti.com>
References: <1285201735-26393-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201735-26393-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 9/23/2010 2:28 AM, Kalliguddi, Hema wrote:
> From: Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
>
> OMAP4 hwmod data stuctures are populated with base address, L3 and L4

typo: structures

> interface clocks, IRQs,and sysconfig register details.

missing space after comma.

>
> Signed-off-by: Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley<paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 +++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -47,6 +47,7 @@ static struct omap_hwmod omap44xx_l4_per
>   static struct omap_hwmod omap44xx_l4_wkup_hwmod;
>   static struct omap_hwmod omap44xx_mpu_hwmod;
>   static struct omap_hwmod omap44xx_mpu_private_hwmod;
> +static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>
>   /*
>    * Interconnects omap_hwmod structures
> @@ -223,10 +224,20 @@ static struct omap_hwmod_ocp_if omap44xx
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> +/* usb_otg_hs ->  l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
> +	.master		=&omap44xx_usb_otg_hs_hwmod,
> +	.slave		=&omap44xx_l3_main_2_hwmod,
> +	.clk		= "l3_div_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>   /* l3_main_2 slave ports */
>   static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
>   	&omap44xx_l3_main_1__l3_main_2,
>   	&omap44xx_l4_cfg__l3_main_2,
> +	&omap44xx_usb_otg_hs__l3_main_2,
> +
>   };
>
>   static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
> @@ -452,6 +463,93 @@ static struct omap_hwmod omap44xx_mpu_hw
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/*
> + * 'usb_otg_hs' class
> + * high-speed on-the-go universal serial bus (usb_otg_hs) controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
> +	.rev_offs	= 0x0400,
> +	.sysc_offs	= 0x0404,
> +	.syss_offs	= 0x0408,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
> +			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +			  SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> +	.sysc_fields	=&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
> +	.name = "usb_otg_hs",
> +	.sysc =&omap44xx_usb_otg_hs_sysc,
> +};
> +
> +/* usb_otg_hs */
> +static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] = {
> +	{ .name = "mc", .irq = 92 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "dma", .irq = 93 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +/* usb_otg_hs master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_masters[] = {
> +	&omap44xx_usb_otg_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
> +	{
> +		.pa_start	= 0x4a0ab000,
> +		.pa_end		= 0x4a0ab003,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_cfg ->  usb_otg_hs */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs = {
> +	.master		=&omap44xx_l4_cfg_hwmod,
> +	.slave		=&omap44xx_usb_otg_hs_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_usb_otg_hs_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* usb_otg_hs slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_slaves[] = {
> +	&omap44xx_l4_cfg__usb_otg_hs,
> +};
> +
> +static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
> +	{ .role = "xclk", .clk = "otg_60m_gfclk_ck" },
> +};
> +
> +static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
> +	.name		= "usb_otg_hs",
> +	.class		=&omap44xx_usb_otg_hs_hwmod_class,
> +	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_irqs),
> +	.main_clk	= "usb_otg_hs_ick",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
> +		},
> +	},
> +	.opt_clks	= usb_otg_hs_opt_clks,
> +	.opt_clks_cnt = ARRAY_SIZE(usb_otg_hs_opt_clks),
> +	.slaves		= omap44xx_usb_otg_hs_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
> +	.masters	= omap44xx_usb_otg_hs_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
> +
> +	/*
> +	 * As per OMAP USBOTG specification, need to configure the USBOTG
> +	 * to smart idle/standby or no idle/standby during data transfer and
> +	 * force idle/standby when not in use to support retention and offmode.
> +	 */

That comment is good, but you'd better move it to the changelog, because 
I will not be able to maintain it easily when I will re-generate the 
OMAP4 hwmod data for next ES.

Benoit

> +	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -472,6 +570,7 @@ static __initdata struct omap_hwmod *oma
>
>   	/* mpu class */
>   	&omap44xx_mpu_hwmod,
> +	&omap44xx_usb_otg_hs_hwmod,
>   	NULL,
>   };
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
