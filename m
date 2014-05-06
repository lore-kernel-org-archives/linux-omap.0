From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP5: Redo THUMB mode switch on secondary CPU
Date: Mon, 5 May 2014 17:32:58 -0700
Message-ID: <20140506003257.GM25949@atomide.com>
References: <1398826427-17200-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398826427-17200-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM SUB-ARCHITECT..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [140429 19:54]:
> Here's a redo of the patch [1] that effectively does the same
> thing but is the right way to do things by using ENDPROC instead.
> The firmware correctly switches to THUMB before entry.
> 
> The patch applies ontop of the earlier patch [1].
> 
> [1] https://lkml.org/lkml/2014/4/22/1044
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> 
> Tony, the earlier patch went into your fixes, and can remain. This patch is just a simple redo of the same and can go in for v3.16, no problem. Thanks.

OK thanks, applying into omap-for-v3.16/fixes-not-urgent.

Tony
 
>  arch/arm/mach-omap2/omap-headsmp.S |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
> index 1809dce..bf36f26 100644
> --- a/arch/arm/mach-omap2/omap-headsmp.S
> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> @@ -31,10 +31,6 @@
>   * register AuxCoreBoot0.
>   */
>  ENTRY(omap5_secondary_startup)
> -.arm
> -THUMB( adr     r9, BSYM(wait)  )       @ CPU may be entered in ARM mode.
> -THUMB( bx      r9              )       @ If this is a Thumb-2 kernel,
> -THUMB( .thumb                  )       @ switch to Thumb now.
>  wait:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
>  	ldr	r0, [r2]
>  	mov	r0, r0, lsr #5
> @@ -43,7 +39,7 @@ wait:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
>  	cmp	r0, r4
>  	bne	wait
>  	b	secondary_startup
> -END(omap5_secondary_startup)
> +ENDPROC(omap5_secondary_startup)
>  /*
>   * OMAP4 specific entry point for secondary CPU to jump from ROM
>   * code.  This routine also provides a holding flag into which
> -- 
> 1.7.9.5
> 
