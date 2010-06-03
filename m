From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/11] OMAP: GPIO: add GPIO hwmods structures for OMAP242X
Date: Thu, 03 Jun 2010 11:31:56 -0700
Message-ID: <87iq60rmqr.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<1274194260-16401-2-git-send-email-charu@ti.com>
	<1274194260-16401-3-git-send-email-charu@ti.com>
	<1274194260-16401-4-git-send-email-charu@ti.com>
	<1274194260-16401-5-git-send-email-charu@ti.com>
	<1274194260-16401-6-git-send-email-charu@ti.com>
	<1274194260-16401-7-git-send-email-charu@ti.com>
	<1274194260-16401-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46619 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab0FCSb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:31:59 -0400
Received: by pwj2 with SMTP id 2so211903pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:31:59 -0700 (PDT)
In-Reply-To: <1274194260-16401-8-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 18 May 2010 20\:20\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> +static struct omap_hwmod omap2420_gpio1_hwmod = {
> +	.name		= "gpio1_hwmod",
> +	.mpu_irqs	= gpio1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(gpio1_mpu_irqs),
> +	.main_clk	= "gpios_fck",
> +	.prcm		= {
> +		.omap2 = {

also needs .module_offs populated.

> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_gpio1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio1_slaves),
> +	.class		= &gpio_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +

Kevin
