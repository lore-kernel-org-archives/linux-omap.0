From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap3: cm-t35: remove MACH_CM_T3730
Date: Mon, 17 Feb 2014 14:33:03 +0200
Message-ID: <5302017F.40900@compulab.co.il>
References: <1392571560.28866.16.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392571560.28866.16.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 02/16/14 19:26, Paul Bolle wrote:
> The Kconfig symbol MACH_CM_T3730 was added in v3.1. It has never been
> used. Setting it has no effect. There are no calls for
> machine_is_cm_t3730(). This symbol can safely be removed.

Indeed...

Is it such a burden to keep it just until we switch OMAP3 to DT?
Because, it makes a bit harder to hack on the kernel.
Well, not too much as it can be reverted, but still one needs
to remember to do this...
I'd like to keep it just until we remove the board files, please.

> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Tested only with "git grep".
> 
>  arch/arm/mach-omap2/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 66da3f5..7d4934e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -292,7 +292,6 @@ config MACH_CM_T35
>  	bool "CompuLab CM-T35/CM-T3730 modules"
>  	depends on ARCH_OMAP3
>  	default y
> -	select MACH_CM_T3730
>  	select OMAP_PACKAGE_CUS
>  
>  config MACH_CM_T3517
> @@ -301,9 +300,6 @@ config MACH_CM_T3517
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> -config MACH_CM_T3730
> -       bool
> -
>  config MACH_SBC3530
>  	bool "OMAP3 SBC STALKER board"
>  	depends on ARCH_OMAP3
> 

-- 
Regards,
Igor.
