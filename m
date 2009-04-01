From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix HW SAVEANDRESTORE shift define
Date: Wed, 1 Apr 2009 13:05:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904011305180.9879@utopia.booyaka.com>
References: <> <1238568174-28291-1-git-send-email-kalle.jokiniemi@digia.com> <1238568174-28291-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52457 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763594AbZDATFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 15:05:41 -0400
In-Reply-To: <1238568174-28291-2-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Wed, 1 Apr 2009, Kalle Jokiniemi wrote:

> The OMAP3430ES2_SAVEANDRESTORE_SHIFT macro is used
> by powerdomain code in
> "1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT" manner, but
> the definition was also (1 << 4), meaning we actually
> modified bit 16. So the definition needs to be 4.

Thanks Kalle, 

Acked-by: Paul Walmsley <paul@pwsan.com>

> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index d73eee8..d792c29 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -409,7 +409,7 @@
>  /* PM_PREPWSTST_CAM specific bits */
>  
>  /* PM_PWSTCTRL_USBHOST specific bits */
> -#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
> +#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
>  
>  /* RM_RSTST_PER specific bits */
>  
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
