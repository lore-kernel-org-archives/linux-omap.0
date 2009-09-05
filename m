From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox
 register base address for OMAP4 mailbox
Date: Sat, 05 Sep 2009 12:35:52 +0300 (EEST)
Message-ID: <20090905.123552.186330891.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38258 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZIEJgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 05:36:10 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

Hi Subramaniam,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox register base address for OMAP4 mailbox
Date: Fri, 4 Sep 2009 13:47:43 +0200

> From 80e74ada510bace7208d59c0f912f9b1077efb45 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Wed, 2 Sep 2009 17:58:57 +0530
> Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox register base address
>  for OMAP4 mailbox
> 
> This patch adds resource information of mailbox driver for
> OMAP4 mailbox module. Register base address also added
> 
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c              |   20 +++++++++++++++++++-
>  arch/arm/plat-omap/include/mach/omap44xx.h |    2 ++
>  2 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 894cc35..711ed6a 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -136,8 +136,11 @@ static inline void omap_init_camera(void)
>  
>  #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
>  
> +#ifdef CONFIG_ARCH_OMAP4
> +#define MBOX_REG_SIZE   0x130
> +#else
>  #define MBOX_REG_SIZE	0x120
> -
> +#endif

I'm not sure if it is still valid or not to support multiple OMAP
architecture(OMAP1/2/3/4?) with a single vmlinux binary, but the above
modification will break this feature.

If it is still valid, I think that the above should be modified, for
example, with using embedded constant values, like other device
resources and the rousources should be ifded'ed with architecture #:

#ifdef CONFIG_ARCH_OMAP2
  static struct resource omap2_mbox_resources[] = {
  	{
  		.start		= OMAP24XX_MAILBOX_BASE,
		.end            = OMAP24XX_MAILBOX_BASE + OMAP2_MBOX_REG_SIZE - 1,
#endif

#ifdef CONFIG_ARCH_OMAP3
 @@ -166,6 +169,18 @@ static struct resource omap3_mbox_resources[] = {
  	},
  };
#endif

#ifdef CONFIG_ARCH_OMAP4

#define OMAP4_MBOX_REG_SIZE   0x130

static struct resource omap4_mbox_resources[] = {
	{
		.start          = OMAP44XX_MAILBOX_BASE,
		.end            = OMAP44XX_MAILBOX_BASE + OMAP4_MBOX_REG_SIZE - 1,
		.flags          = IORESOURCE_MEM,
	},
	{
		.start          = INT_44XX_MAIL_U0_MPU,
		.flags          = IORESOURCE_IRQ,
	},
};
#endif

> +
>  static struct platform_device mbox_device = {
>  	.name		= "omap2-mailbox",
>  	.id		= -1,
> @@ -179,6 +194,9 @@ static inline void omap_init_mbox(void)
>  	} else if (cpu_is_omap3430()) {
>  		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
>  		mbox_device.resource = omap3_mbox_resources;
> +	} else if (cpu_is_omap44xx()) {
> +		mbox_device.num_resources = ARRAY_SIZE(omap4_mbox_resources);
> +		mbox_device.resource = omap4_mbox_resources;
>  	} else {
>  		pr_err("%s: platform not supported\n", __func__);
>  		return;
> diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
> index 52f2f85..6a545d3 100644
> --- a/arch/arm/plat-omap/include/mach/omap44xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap44xx.h
> @@ -44,5 +44,7 @@
>  #define OMAP44XX_WKUPGEN_BASE		0x48281000
>  #define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
>  
> +#define OMAP44xx_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)

>From naming consistency, can the above be, "OMAP44XX_MAILBOX_BASE" ?

> +
>  #endif /* __ASM_ARCH_OMAP44XX_H */
>  
> -- 
> 1.5.3.2
