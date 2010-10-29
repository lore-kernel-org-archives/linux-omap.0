From: "Srinath R" <srinath@mistralsolutions.com>
Subject: RE: [Patch v3] OMAP: AM3517/05: Add craneboard support
Date: Fri, 29 Oct 2010 10:32:14 +0530
Message-ID: <000001cb7726$77a7cf60$66f76e20$@com>
References: <[PATCH] OMAP: AM3517/05: Add craneboard support> <1288272552-22303-1-git-send-email-srinath@mistralsolutions.com> <B85A65D85D7EB246BE421B3FB0FBB593023475E6FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35195 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0J2E5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 00:57:36 -0400
Received: by ywk9 with SMTP id 9so1763000ywk.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Oct 2010 21:57:35 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023475E6FE@dbde02.ent.ti.com>
Content-Language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Premi, Sanjeev'" <premi@ti.com>, linux-omap@vger.kernel.org
Cc: "'Kridner, Jason'" <jdk@ti.com>, tony@atomide.com, khilman@deeprootsystems.com, "'Menon, Nishanth'" <nm@ti.com>, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com



-----Original Message-----
From: Premi, Sanjeev [mailto:premi@ti.com] 
Sent: Thursday, October 28, 2010 7:47 PM
To: srinath@mistralsolutions.com; linux-omap@vger.kernel.org
Cc: Kridner, Jason; tony@atomide.com; khilman@deeprootsystems.com; Menon,
Nishanth; nagendra@mistralsolutions.com; umeshk@mistralsolutions.com
Subject: RE: [Patch v3] OMAP: AM3517/05: Add craneboard support

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> srinath@mistralsolutions.com
> Sent: Thursday, October 28, 2010 6:59 PM
> To: linux-omap@vger.kernel.org
> Cc: Kridner, Jason; tony@atomide.com; 
> khilman@deeprootsystems.com; Menon, Nishanth; 
> nagendra@mistralsolutions.com; umeshk@mistralsolutions.com; Srinath
> Subject: [Patch v3] OMAP: AM3517/05: Add craneboard support
> 

[snip]

> +MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")

Compared against AM3715, I see these missing:
	.phys_io	= 0x48000000,
	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,

Are these not required?

[Srintah] According to commit ID de01f1735c9a8c00b3625507c7327a1f0b347b7b,
io_pg_offst and phys_io members are 
no more required in struct machine_desc

> +	.boot_params	= 0x80000100,
> +	.map_io		= omap3_map_io,
> +	.reserve        = omap_reserve,
              ^^^^^^^^
Check for mix of space & tabs here.

[Srintah] Sure, I will update and re-submit patch 

~sanjeev

> +	.init_irq	= am3517_crane_init_irq,
> +	.init_machine	= am3517_crane_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h 
> b/arch/arm/plat-omap/include/plat/uncompress.h
> index 9036e37..229fbf2 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -145,6 +145,7 @@ static inline void 
> __arch_decomp_setup(unsigned long arch_id)
>  		/* omap3 based boards using UART3 */
>  		DEBUG_LL_OMAP3(3, cm_t35);
>  		DEBUG_LL_OMAP3(3, cm_t3517);
> +		DEBUG_LL_OMAP3(3, craneboard);
>  		DEBUG_LL_OMAP3(3, igep0020);
>  		DEBUG_LL_OMAP3(3, igep0030);
>  		DEBUG_LL_OMAP3(3, nokia_rx51);
> -- 
> 1.7.1.226.g770c5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =

