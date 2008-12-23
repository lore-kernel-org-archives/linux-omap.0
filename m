From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: fix recent build breakage
Date: Tue, 23 Dec 2008 14:29:48 +0200
Message-ID: <20081223122947.GB1887@atomide.com>
References: <alpine.DEB.2.00.0812222326580.3233@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59523 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYLWM3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 07:29:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812222326580.3233@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [081223 08:28]:
> 
> Fix recent build breakage.  Boot-tested on N800.
>     
>   CC      arch/arm/mach-omap2/devices.o
> arch/arm/mach-omap2/devices.c:110: error: 'OMAP34XX_MAILBOX_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/devices.c:115: error: 'INT_34XX_MAIL_U0_MPU' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
>     

Pushing to l-o today.

Tony


> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 937fb18..d7e848e 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -112,7 +112,7 @@ static struct resource omap3_mbox_resources[] = {
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	{
> -		.start		= INT_34XX_MAIL_U0_MPU,
> +		.start		= INT_24XX_MAIL_U0_MPU,
>  		.flags		= IORESOURCE_IRQ,
>  	},
>  };
> diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
> index 2f82e28..27a1e45 100644
> --- a/arch/arm/plat-omap/include/mach/omap34xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap34xx.h
> @@ -56,6 +56,9 @@
>  #define OMAP34XX_SR1_BASE	0x480C9000
>  #define OMAP34XX_SR2_BASE	0x480CB000
>  
> +#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
> +#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
> +
>  
>  #if defined(CONFIG_ARCH_OMAP3430)
>  
> @@ -63,8 +66,6 @@
>  #define OMAP2_CM_BASE			OMAP3430_CM_BASE
>  #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
>  #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
> -#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
> -#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
>  
>  #endif
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
