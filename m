From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.28-rc6 1/1] Fix OMAP/README docummentation
Date: Thu, 4 Dec 2008 15:51:35 -0800
Message-ID: <20081204235134.GK7054@atomide.com>
References: <1228300638.26377.124.camel@groo.research.nokia.com> <1228300803-19127-1-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50595 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYLDXvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 18:51:37 -0500
Content-Disposition: inline
In-Reply-To: <1228300803-19127-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-omap@vger.kernel.org

* Carlos Chinea <carlos.chinea@nokia.com> [081203 02:44]:
> 
>         - Remove section 4 because it has wrong and misleading information

Thanks, pushing today.

Tony

> 
> Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
> ---
>  Documentation/arm/OMAP/README |   39 ---------------------------------------
>  1 files changed, 0 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
> index f8ffb68..038d863 100644
> --- a/Documentation/arm/OMAP/README
> +++ b/Documentation/arm/OMAP/README
> @@ -370,45 +370,6 @@ other users. It then can be included into the public OMAP kernel tree.
>  processor peripherals or board devices. Improve and maintain the code for your 
>  new processor or board.
>  
> -
> -4. General guidelines to write clean and OMAP Linux compatible code
> --------------------------------------------------------------------
> -
> -- For register access use the __REG8/16/32() macros. At the moment, see first
> -example in include/asm-arm/arch-omap/hardware.h.
> -
> -Allegedly __REG() makes at least some versions of GCC emit tighter code
> -than the more direct wrappers. Presumably by making it easier to use certain 
> -addressing modes. 
> -
> -Make sure that the registers names are clearly marked as being registers
> -(and not addresses of registers). This has to be done by adding a '_REG'
> -suffix. E.g.
> -
> -#define OMAP_ID_REG  (__REG32(0xfffed400))
> -#define DPLL_CTL_REG (__REG16(0xfffecf00))
> -
> -__raw_read[bwl] and __raw_write[bwl] are deprecated. They will converted to
> -__REG8/16/32() syntax, soon. Don't use anything else like own pointer
> -definitions or in[bwl]/out[bwl] etc., too.
> -
> -- Make read-modify-write register access preemption save. Use spin_lock() and 
> -spin_unlock() where necessary. If an IRQ handler can access the registers, 
> -use spin_lock_irqsave(), too. 
> -
> -- Functions declared as __init shouldn't have any references after the kernel 
> -initialization phase is complete. Usually they should be static as well.
> -
> -- Don't use return statements at end of void functions.
> -
> -- Use consistent indentation style. Don't use space indentations. Use tab 
> -indentations.
> -
> -- In general use Linux formatting style. See Documentation/CodingStyle for more
> -information. If you use GNU emacs, see also chapter 8 of that document how to
> -add a linux-c-mode to emacs.
> -
> -
>  ------------------------------------------------------------------
>  Last modified 15. March 2006
>  The OMAP Linux Kernel Team
> -- 
> 1.5.3.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
