From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/11] OMAP: GPIO: add GPIO hwmods structures for OMAP3
Date: Thu, 03 Jun 2010 11:30:53 -0700
Message-ID: <87mxvcrmsi.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<1274194260-16401-2-git-send-email-charu@ti.com>
	<1274194260-16401-3-git-send-email-charu@ti.com>
	<1274194260-16401-4-git-send-email-charu@ti.com>
	<1274194260-16401-5-git-send-email-charu@ti.com>
	<1274194260-16401-6-git-send-email-charu@ti.com>
	<1274194260-16401-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58934 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0FCSa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:30:56 -0400
Received: by pvg16 with SMTP id 16so197649pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:30:55 -0700 (PDT)
In-Reply-To: <1274194260-16401-7-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 18 May 2010 20\:20\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> Add hwmod structures for GPIO module on OMAP3
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

[...]

> +/* GPIO1 */
> +
> +static struct omap_hwmod_irq_info gpio1_mpu_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK1 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
> +	{ .role = "gpio1_dbclk", .clk = "gpio1_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
> +	&omap3xxx_l4_wkup__gpio1,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio1_hwmod = {
> +	.name		= "gpio1_hwmod",
> +	.mpu_irqs	= gpio1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(gpio1_mpu_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio1_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
> +	.prcm		= {
> +		.omap2 = {

With the _wait_for_ready() cleanups/fixes introduced by Benoit (and
now in 2.6.35) you need to populate the .module_offs field here too.

I guess it will be WKUP_MOD for this one and OMAP3430_PER_MOD for the
rest.

Kevin
