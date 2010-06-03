From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/6] OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
Date: Thu, 03 Jun 2010 12:10:04 -0700
Message-ID: <87vda0orub.fsf@deeprootsystems.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
	<1274532966-19916-2-git-send-email-charu@ti.com>
	<1274532966-19916-3-git-send-email-charu@ti.com>
	<1274532966-19916-4-git-send-email-charu@ti.com>
	<1274532966-19916-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51004 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0FCTKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 15:10:08 -0400
Received: by pwj2 with SMTP id 2so226880pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 12:10:08 -0700 (PDT)
In-Reply-To: <1274532966-19916-5-git-send-email-charu@ti.com> (Charulatha V.'s message of "Sat\, 22 May 2010 18\:26\:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, wim@iguana.be, rnayak@ti.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> Add hwmod structures for Watchdog module on OMAP2430
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   56 ++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
>

[...]

> +/* WDTIMER2 */
> +static struct omap_hwmod_ocp_if *omap2430_wd_timer2_slaves[] = {
> +	&omap2430_l4_wkup__wd_timer2,
> +};
> +
> +static struct omap_hwmod omap2430_wd_timer2_hwmod = {
> +	.name		= "wd_timer2",
> +	.class		= &omap2430_wd_timer_hwmod_class,
> +	.main_clk	= "mpu_wdt_fck",
> +	.prcm		= {
> +		.omap2 = {

missing .module_offs

> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_WDT2_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2430_wd_timer2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2430_wd_timer2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +

Kevin
