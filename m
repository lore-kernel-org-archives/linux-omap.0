From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Tue, 8 Nov 2011 08:26:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58495 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab1KHP0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 10:26:53 -0500
In-Reply-To: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi

some comments

On Mon, 24 Oct 2011, ming.lei@canonical.com wrote:

> From: Ming Lei <ming.lei@canonical.com>
> 
> So that access to cross trigger interface can be allowed, which
> will be introduce in later patches.
> 
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 393afac..c7289a8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5276,6 +5276,30 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
>  };
>  
> +static struct omap_hwmod_class omap44xx_emu_hwmod_class = {
> +	.name	= "emu",
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
> +	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> +	{ .irq = -1 }
> +};

Are you sure these are part of the emulation IP?  We already have those 
IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.

> +/*emu hwmod*/
> +static struct omap_hwmod omap44xx_emu_hwmod = {
> +	.name		= "emu",
> +	.class		= &omap44xx_emu_hwmod_class,
> +	.clkdm_name	= "emu_sys_clkdm",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,

This doesn't look right either: EMU is a clockdomain, not an IP block.

> +			.modulemode   = MODULEMODE_HWCTRL,
> +		},
> +	},
> +	.mpu_irqs	= omap44xx_emu_irqs,
> +};
> +
>  static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  
>  	/* dmm class */



- Paul
