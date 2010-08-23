From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
Date: Mon, 23 Aug 2010 15:18:35 -0700
Message-ID: <87mxsdvupw.fsf@deeprootsystems.com>
References: <1281364586-26323-1-git-send-email-rnayak@ti.com>
	<1281364586-26323-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58455 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0HWWSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 18:18:38 -0400
Received: by pxi10 with SMTP id 10so2444558pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 15:18:38 -0700 (PDT)
In-Reply-To: <1281364586-26323-2-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Mon, 9 Aug 2010 20:06:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Rajendra Nayak <rnayak@ti.com> writes:

> From: Paul Walmsley <paul@pwsan.com>
>
> Add hwmod structures for I2C controllers on OMAP2420/2430.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  134 ++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  140 +++++++++++++++++++++++++++-
>  2 files changed, 270 insertions(+), 4 deletions(-)
>

[...]

> +static struct omap_hwmod omap2420_i2c1_hwmod = {
> +	.name		= "i2c1",
> +	.mpu_irqs	= i2c1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> +	.sdma_chs	= i2c1_sdma_chs,
> +	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
> +	.main_clk	= "i2c1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP2420_EN_I2C1_SHIFT,
> +		},
> +	},

This needs to be validated on OMAP2.

I think the enable will fail without the .idlest* fields filled out.

Kevin


> +
