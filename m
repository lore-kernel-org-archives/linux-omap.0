From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Clear the SDRC_POWER.PWRENA bit before putting the SDRAM
 into  self-refresh before suspend
Date: Fri, 7 Aug 2009 06:03:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908070555200.7977@utopia.booyaka.com>
References: <af3ea28a0907071444m7c9ef14i8eaf15b45b14db9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60933 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbZHGMDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 08:03:18 -0400
In-Reply-To: <af3ea28a0907071444m7c9ef14i8eaf15b45b14db9d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hello Janboe,

On Tue, 7 Jul 2009, ye janboe wrote:

> I saw you clear clear the SDRC PWRENA bit during SDRC frequency change
> but not during suspend.
> 
> Please review if it is necessary to clear PWRENA bit during suspend.

I hope we don't need this after:

http://patchwork.kernel.org/patch/37284/

Of course, the bootloader might still set it :-(

- Paul

> 
> Thanks
> 
> Janboe Ye
> 
> rom 287db2e188391be0ac95128131724e0e035e945a Mon Sep 17 00:00:00 2001
> From: janboe <janboe.ye@gmail.com>
> Date: Tue, 7 Jul 2009 16:30:26 -0500
> Subject: [PATCH] Clear the SDRC_POWER.PWRENA bit before putting the
> SDRAM into self-refresh and then suspend
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>
> ---
>  arch/arm/mach-omap2/sleep34xx.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index e5e2553..2bc0c3b 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -70,6 +70,7 @@ loop:
>         ldr     r4, sdrc_power          @ read the SDRC_POWER register
>         ldr     r5, [r4]                @ read the contents of SDRC_POWER
>         orr     r5, r5, #0x40           @ enable self refresh on idle req
> +       bic     r5, r5, #0x4            @ clear PWDENA
>         str     r5, [r4]                @ write back to SDRC_POWER register
> 
>         cmp     r1, #0x0
> -- 
> 1.6.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
