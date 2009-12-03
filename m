From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 12:11:57 +0000
Message-ID: <20091203121157.GC20379@n2100.arm.linux.org.uk>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain> <20091203102700.GA30423@flint.arm.linux.org.uk> <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com> <20091203104354.GB20379@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com> <alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50335 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbZLCMMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 07:12:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Thu, Dec 03, 2009 at 04:24:35AM -0700, Paul Walmsley wrote:
> @@ -42,134 +47,19 @@ static void clk_omap1_dummy_disable(struct clk *clk)
>  {
>  }
>  
> -static const struct clkops clkops_dummy = {
> -	.enable = clk_omap1_dummy_enable,
> -	.disable = clk_omap1_dummy_disable,
> -};
...
> +/*
> + * clkops
> + */
>  
> -	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
> -	/* (on 730, bit 13 must not be cleared) */
> -	if (cpu_is_omap7xx())
> -		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
> -	else
> -		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
> +const struct clkops clkops_dspck = {
> +	.enable		= omap1_clk_enable_dsp_domain,
> +	.disable	= omap1_clk_disable_dsp_domain,
> +};
>  
> -	/* Put DSP/MPUI into reset until needed */
> -	omap_writew(0, ARM_RSTCT1);
> -	omap_writew(1, ARM_RSTCT2);
> -	omap_writew(0x400, ARM_IDLECT1);
> +const struct clkops clkops_dummy = {
> +	.enable		= clk_omap1_dummy_enable,
> +	.disable	= clk_omap1_dummy_disable,
> +};
>  
> -	/*
> -	 * According to OMAP5910 Erratum SYS_DMA_1, bit DMACK_REQ (bit 8)
> -	 * of the ARM_IDLECT2 register must be set to zero. The power-on
> -	 * default value of this bit is one.
> -	 */
> -	omap_writew(0x0000, ARM_IDLECT2);	/* Turn LCD clock off also */
> +const struct clkops clkops_uart = {
> +	.enable		= omap1_clk_enable_uart_functional,
> +	.disable	= omap1_clk_disable_uart_functional,
> +};

What is the reasoning for moving all clkops away from their associated
enable/disable functions right to the end of the file?

Isn't it better to have like stuff together, in much the same way that
it's preferred to have EXPORT_SYMBOL next to their function/data that
it's exporting?
