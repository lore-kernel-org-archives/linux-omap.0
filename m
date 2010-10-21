From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/5] arm: omap: introduce 32k timer hwmod for omap2/3/4
Date: Thu, 21 Oct 2010 13:29:42 -0700
Message-ID: <87bp6ns30p.fsf@deeprootsystems.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
	<1287480136-2046-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46310 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0JUU3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 16:29:44 -0400
Received: by pvg16 with SMTP id 16so16209pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 13:29:44 -0700 (PDT)
In-Reply-To: <1287480136-2046-5-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 19 Oct 2010 12:22:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> Add 32k timer hwmod to the database.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

Looking closer at this patch, there are some other problems... 

[...]

> +static struct omap_hwmod omap2420_counter_32k_hwmod = {
> +	.name		= "counter_32k",
> +	.class		= &omap2420_counter_hwmod_class,
> +	.main_clk	= "sync_32k_ick",
> +	.prcm = {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
> +		},
> +	},

You're using the PRCM bits for GPT1, which is not the same as the 32k
counter.

So if this worked, it would be toggling GPT1, which is the kernel timer,
and that would be a rather bad thing.

[...]

> +static struct omap_hwmod omap2430_counter_32k_hwmod = {
> +	.name		= "counter_32k",
> +	.class		= &omap2430_counter_hwmod_class,
> +	.main_clk	= "sync_32k_ick",
> +	.prcm = {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
> +		},
> +	},

GPT1 again

[...]

> +static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
> +	.name		= "counter_32k",
> +	.class		= &omap3xxx_counter_hwmod_class,
> +	.main_clk	= "omap_32ksync_ick",
> +	.prcm = {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPT1_SHIFT,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
> +		},
> +	},

and again

> +	.slaves		= omap3xxx_counter_32k_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_counter_32k_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +

Kevin
