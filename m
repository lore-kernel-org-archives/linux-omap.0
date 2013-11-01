From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 38/43] ARM: OMAP2+: PRM: add support for initializing
 PRCM clock modules from DT
Date: Fri, 1 Nov 2013 16:07:36 -0500
Message-ID: <52741818.2000507@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-39-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab3KAVIC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Nov 2013 17:08:02 -0400
In-Reply-To: <1382716658-6964-39-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/25/2013 10:57 AM, Tero Kristo wrote:
[...]
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 228b850..6fa74c6 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c

[...]
> +/*
> + * XXX: implementation for the regmap read/write should be moved to
> + * individual PRCM IP drivers, once those are available.
> + */
> +static int ti_clk_regmap_read(void *context, unsigned int reg,
> +			      unsigned int *val)
> +{
> +	void __iomem *mem = context;
> +	*val = __raw_readl(mem + reg);
> +	return 0;
> +}
> +
> +static int ti_clk_regmap_write(void *context, unsigned int reg,
> +			       unsigned int val)
> +{
> +	void __iomem *mem = context;
> +	__raw_writel(val, mem + reg);
> +	return 0;
> +}
> +
> +static struct regmap_config ti_clk_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.reg_read = ti_clk_regmap_read,
> +	.reg_write = ti_clk_regmap_write,
> +	.fast_io = true,
> +	.cache_type = REGCACHE_NONE,
> +	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +};

why not use regmap_mmio?


[...]

-- 
Regards,
Nishanth Menon
