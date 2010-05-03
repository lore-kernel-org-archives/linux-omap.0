From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 5/8] omap: mailbox: reorganize omap2 platform_device
Date: Mon, 3 May 2010 11:10:48 -0700
Message-ID: <20100503181048.GW29604@atomide.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
 <1272844967-25441-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57548 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab0ECSKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:10:51 -0400
Content-Disposition: inline
In-Reply-To: <1272844967-25441-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

* Felipe Contreras <felipe.contreras@gmail.com> [100502 16:58]:
> Makes more sense to register in the mach file, plus it will allow more
> functionality later on.
> 
> Also, this probably enables multi-omap for real.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

<snip>
 
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c

You still probably want to optimize kernel size and memory
consumption for production kernels built for one omap:

#ifdef CONFIG_ARCH_OMAP2
  
> +static struct resource omap2_mbox_resources[] = {
> +	{
> +		.start		= OMAP24XX_MAILBOX_BASE,
> +		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= INT_24XX_MAIL_U0_MPU,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start		= INT_24XX_MAIL_U3_MPU,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};

#else
#define omap2_mbox_resources	NULL
#endif

And then do the same for omap3 and omap4.

BTW, looks like this could all be also set __initdata?

> @@ -443,7 +479,46 @@ static struct platform_driver omap2_mbox_driver = {
>  
>  static int __init omap2_mbox_init(void)
>  {
> +	int err;
> +	struct platform_device *pdev;
> +	struct resource *res;
> +	unsigned num;
> +
> +	if (cpu_is_omap3430()) {
> +		res = omap3_mbox_resources;
> +		num = ARRAY_SIZE(omap3_mbox_resources);
> +	}
> +	else if (cpu_is_omap2420()) {
> +		res = omap2_mbox_resources;
> +		num = ARRAY_SIZE(omap2_mbox_resources);
> +	}
> +	else if (cpu_is_omap44xx()) {
> +		res = omap4_mbox_resources;
> +		num = ARRAY_SIZE(omap4_mbox_resources);
> +	}
> +	else {
> +		pr_err("%s: platform not supported\n", __func__);
> +		return -ENODEV;
> +	}

Note that these tests will fail when building for one omap only
unless you have the #else statement for eacch omapX_mbox_resources[].

Regards,

Tony
