From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Tue, 03 Aug 2010 14:56:55 -0700
Message-ID: <87eiefnyvs.fsf@deeprootsystems.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
	<1280397545-27323-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33708 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757768Ab0HCV47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 17:56:59 -0400
Received: by pzk26 with SMTP id 26so1804590pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 14:56:58 -0700 (PDT)
In-Reply-To: <1280397545-27323-5-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Thu, 29 Jul 2010 15:28:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch adds OMAP3 DMA hwmod structures.
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>

[...]

> +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap3xxx_dma_hwmod_class,
> +	.mpu_irqs	= omap3xxx_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",
> +	.prcm = {
> +		.omap2 = {
> +			/* .clkctrl_reg = NULL, */
> +		},
> +	},

Has this been tested?  Without valid fields here the hwmod will never be
enabled.

Kevin
