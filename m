From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Fri, 16 Jan 2009 17:43:58 +0200
Message-ID: <20090116154357.GE32481@frodo>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com> <20090116082711.17571.38818.stgit@oreo.research.nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55207 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbZAPPoH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 10:44:07 -0500
Content-Disposition: inline
In-Reply-To: <20090116082711.17571.38818.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi Hiroshi,

On Fri, Jan 16, 2009 at 10:27:11AM +0200, Hiroshi DOYU wrote:
>  static inline void omap_init_mbox(void)
>  {
> +	if (cpu_is_omap2420()) {
> +		mbox_device.num_resources = ARRAY_SIZE(omap2_mbox_resources);
> +		mbox_device.resource = omap2_mbox_resources;
> +	} else if (cpu_is_omap3430()) {
> +		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
> +		mbox_device.resource = omap3_mbox_resources;
> +	} else {

how about a pr_info() or pr_err() here ?? Something like:
pr_err("%s: platform not supported yet\n", __func__);

> +		return;
> +	}
>  	platform_device_register(&mbox_device);
>  }
>  #else
>  static inline void omap_init_mbox(void) { }
> -#endif
> +#endif /* CONFIG_OMAP_MBOX_FWK */
>  
>  #if defined(CONFIG_OMAP_STI)
>  
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 0609e2d..3176bb7 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -30,7 +30,7 @@
>  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
>  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
>  
> -static unsigned long mbox_base;
> +static void __iomem *mbox_base;
>  
>  struct omap_mbox2_fifo {
>  	unsigned long msg;
> @@ -52,14 +52,14 @@ static struct clk *mbox_ick_handle;
>  static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
>  				  omap_mbox_type_t irq);
>  
> -static inline unsigned int mbox_read_reg(unsigned int reg)
> +static inline unsigned int mbox_read_reg(size_t ofs)
>  {
> -	return __raw_readl(mbox_base + reg);
> +	return __raw_readl(mbox_base + ofs);
>  }
>  
> -static inline void mbox_write_reg(unsigned int val, unsigned int reg)
> +static inline void mbox_write_reg(u32 val, size_t ofs)
>  {
> -	__raw_writel(val, mbox_base + reg);
> +	__raw_writel(val, mbox_base + ofs);
>  }
>  
>  /* Mailbox H/W preparations */
> @@ -208,7 +208,7 @@ struct omap_mbox mbox_dsp_info = {
>  };
>  EXPORT_SYMBOL(mbox_dsp_info);
>  
> -/* IVA */
> +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */

would be nice to have something like if (cpu_has_iva()) { ... } and move
this check to a later location e.g. on probe(), but this wouldn't prevent
this patch from going in now. Just a suggestion for later improvements.

>  static struct omap_mbox2_priv omap2_mbox_iva_priv = {
>  	.tx_fifo = {
>  		.msg		= MAILBOX_MESSAGE(2),
> @@ -229,17 +229,12 @@ static struct omap_mbox mbox_iva_info = {
>  	.ops	= &omap2_mbox_ops,
>  	.priv	= &omap2_mbox_iva_priv,
>  };
> +#endif

[snip]

> -	/* IVA IRQ */
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
> -	if (unlikely(!res)) {
> -		dev_err(&pdev->dev, "invalid irq resource\n");
> -		return -ENODEV;
> +	if (ret)
> +		goto err_dsp;
> +
> +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
> +	if (cpu_is_omap2420()) {
> +		/* IVA IRQ */
> +		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);

platform_get_irq(pdev, 0) would look more standard, I think.

-- 
balbi
