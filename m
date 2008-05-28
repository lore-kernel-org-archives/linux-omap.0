From: <roman.tereshonkov@nokia.com>
Subject: RE: [PATCH] Add SDTI device for the OMAP3 and unify addressdefinitions.
Date: Wed, 28 May 2008 18:52:40 +0300
Message-ID: <89258465635CB949A9E2CFDFEC8E10900E199F@vaebe103.NOE.Nokia.com>
References: <1211977042-3278-1-git-send-email-roman.tereshonkov@nokia.com> <20080528152244.GV8845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18793 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYE1Pwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 11:52:53 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080528152244.GV8845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org


You are right. OMAP1 device.c has been forgotten. I will fix that.

Roman
 

-----Original Message-----
From: ext Tony Lindgren [mailto:tony@atomide.com] 
Sent: 28 May, 2008 18:23
To: Tereshonkov Roman (Nokia-D/Helsinki)
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH] Add SDTI device for the OMAP3 and unify
addressdefinitions.

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [080528 05:17]:
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c |   23 ++++++++++++++++++++++-
>  drivers/misc/sti/sti.c        |    2 +-
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c
b/arch/arm/mach-omap2/devices.c
> index d02e9e5..d8fb3f8 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -92,7 +92,9 @@ static inline void omap_init_mbox(void) { }
>  
>  #if defined(CONFIG_OMAP_STI)
>  
> -#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
> +#if defined(CONFIG_ARCH_OMAP2)
> +
> +#define OMAP2_STI_BASE		0x48068000
>  #define OMAP2_STI_CHANNEL_BASE	0x54000000
>  #define OMAP2_STI_IRQ		4
>  
> @@ -112,6 +114,25 @@ static struct resource sti_resources[] = {
>  		.flags		= IORESOURCE_IRQ,
>  	}
>  };
> +#elif defined(CONFIG_ARCH_OMAP3)
> +
> +#define OMAP3_SDTI_BASE		0x54500000
> +#define OMAP3_SDTI_CHANNEL_BASE	0x54600000
> +
> +static struct resource sti_resources[] = {
> +	{
> +		.start		= OMAP3_SDTI_BASE,
> +		.end		= OMAP3_SDTI_BASE + 0xFFF,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= OMAP3_SDTI_CHANNEL_BASE,
> +		.end		= OMAP3_SDTI_CHANNEL_BASE + SZ_1M - 1,
> +		.flags		= IORESOURCE_MEM,
> +	}
> +};
> +
> +#endif
>  
>  static struct platform_device sti_device = {
>  	.name		= "sti",
> diff --git a/drivers/misc/sti/sti.c b/drivers/misc/sti/sti.c
> index e828860..880c34b 100644
> --- a/drivers/misc/sti/sti.c
> +++ b/drivers/misc/sti/sti.c
> @@ -356,7 +356,7 @@ static int __devinit sti_probe(struct
platform_device *pdev)
>  	if (unlikely(ret != 0))
>  		goto err;
>  
> -	sti_base = res->start;
> +	sti_base = io_p2v(res->start);
>  
>  	/*
>  	 * OMAP 16xx keeps channels in a relatively sane location,

Hmm, so does this still work for 16xx and 24xx? To me it looks like
mach-omap1/devices.c mach-omap2/devices.c are both passing a
virtual address?

So maybe change mach-omap1/devices.c to pass physical address for both
STI_BASE and CHANNEL_BASE, and then change mach-omap2/devices.c to pass
physical address for OMAP2_STI_BASE. Looks like OMAP2_STI_CHANNEL_BASE
is already a physical address as it needs to be ioremapped.

To add to the confusion, 

Regards,

Tony
