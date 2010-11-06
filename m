From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
Date: Sat, 06 Nov 2010 13:18:46 -0400
Message-ID: <4CD58DF6.6040600@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com> <1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53719 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0KFRSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Nov 2010 13:18:06 -0400
In-Reply-To: <1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

I don't know why, but this patch has nothing to do with my original one.
Can you stick to the original code?
Of course, if you have valid comments or need to add extra data, you 
can, but in this case, I do not see any needed change.

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> From: Benoit Cousson<b-cousson@ti.com>
>
> hwmod data for omap4 mailbox.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   63 ++++++++++++++++++++++++++++
>   1 files changed, 63 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 0d5c6eb..f7525e3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1043,6 +1043,66 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/* mailbox */

The original comment is missing.

> +
> +static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=&omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
> +	.name = "mailbox",
> +	.sysc =&omap44xx_mailbox_sysc,
> +};
> +
> +static struct omap_hwmod omap44xx_mailbox_hwmod;
> +
> +static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
> +	{
> +		.pa_start	= OMAP44XX_MAILBOX_BASE,

If that physical address is not used elsewhere, and it should be the 
case, there is no need to create a define for it. That's why the 
physical address was directly used here.
There is no added value to create a define for that.

> +		.pa_end		= OMAP44XX_MAILBOX_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +};
> +
> +/* l4_cfg ->  mailbox */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
> +	.master		=&omap44xx_l4_cfg_hwmod,
> +	.slave		=&omap44xx_mailbox_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mailbox_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mailbox_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mailbox slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mailbox_slaves[] = {
> +	&omap44xx_l4_cfg__mailbox,
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
> +	{ .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
> +};
> +
> +static struct omap_hwmod omap44xx_mailbox_hwmod = {
> +	.name		= "mailbox",
> +	.class		=&omap44xx_mailbox_hwmod_class,
> +	.prcm		= {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
> +		},
> +	},
> +	.mpu_irqs	= omap44xx_mailbox_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),

The order is different than the previous one.

Benoit

> +	.slaves		= omap44xx_mailbox_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -1077,6 +1137,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_uart2_hwmod,
>   	&omap44xx_uart3_hwmod,
>   	&omap44xx_uart4_hwmod,
> +
> +	/* mailbox */
> +	&omap44xx_mailbox_hwmod,
>   	NULL,
>   };
>

