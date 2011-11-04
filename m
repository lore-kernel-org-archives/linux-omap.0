From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Fri, 04 Nov 2011 16:23:24 -0700
Message-ID: <87sjm31ngz.fsf@ti.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320185752-568-3-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Tue, 1 Nov 2011 17:15:50 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ohad Ben-Cohen <ohad@wizery.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, lm <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> Add mmu hwmod data for ipu and dsp.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

[...]

> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
> +	.name		= "ipu_mmu",
> +	.class		= &omap44xx_mmu_hwmod_class,
> +	.mpu_irqs	= omap44xx_ipu_mmu_irqs,
> +	.rst_lines	= omap44xx_ipu_mmu_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_resets),
> +	.main_clk	= "ipu_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
> +		},
> +	},
> +	.dev_attr	= &ipu_mmu_dev_attr,
> +	.slaves		= omap44xx_ipu_mmu_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_slaves),
> +	.flags		= HWMOD_INIT_NO_RESET,

Why is this needed?

[...]

> +static struct omap_hwmod omap44xx_dsp_mmu_hwmod = {
> +	.name		= "dsp_mmu",
> +	.class		= &omap44xx_mmu_hwmod_class,
> +	.mpu_irqs	= omap44xx_dsp_mmu_irqs,
> +	.rst_lines	= omap44xx_dsp_mmu_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_mmu_resets),
> +	.main_clk	= "dsp_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
> +		},
> +	},
> +	.dev_attr	= &dsp_mmu_dev_attr,
> +	.slaves		= omap44xx_dsp_mmu_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_mmu_slaves),
> +	.flags		= HWMOD_INIT_NO_RESET,

And this?

Kevin
