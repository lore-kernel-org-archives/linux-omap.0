From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 8/9] Adding new board header file for OMAP3 Beagle Board
Date: Fri, 18 Apr 2008 01:13:06 +0300
Message-ID: <20080417221306.GB4492@kedavra.cpe.vivax.com.br>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8A86@dbde01.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59795 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbYDQWLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 18:11:21 -0400
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8A86@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org

On Wed, Apr 16, 2008 at 06:08:50PM +0530, Syed Mohammed, Khasim wrote:
> 
> New board header file for OMAP3 Beagle Board.

Ugh, forget the last comment :-p

> 
> Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> ---
>  include/asm-arm/arch-omap/board-omap3beagle.h |   53 ++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/hardware.h          |    4 +
>  2 files changed, 57 insertions(+)
> 
> Index: my_branch/include/asm-arm/arch-omap/board-omap3beagle.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ my_branch/include/asm-arm/arch-omap/board-omap3beagle.h	2008-04-16 14:47:14.000000000 +0530
> @@ -0,0 +1,53 @@
> +/*
> + * linux/include/asm-arm/arch-omap/board-omap3beagle.h
> + *
> + * Hardware definitions for TI OMAP3 BEAGLE.
> + *
> + * Initial creation by Syed Mohammed Khasim <khasim@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> +#define __ASM_ARCH_OMAP3_BEAGLE_H
> +
> +#ifdef CONFIG_TWL4030_CORE
> +
> +#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
> +
> +/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> +#define	IH_TWL4030_BASE		IH_BOARD_BASE
> +#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
> +#define IH_TWL4030_PWRBASE	(IH_TWL4030_END)
> +#define IH_TWL4030_PWRBASE_END	(IH_TWL4030_PWRBASE+8)
> +
> +#ifdef CONFIG_TWL4030_GPIO
> +/* TWL4030 GPIO Interrupts */
> +#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> +#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
> +#define NR_IRQS			(IH_TWL4030_GPIO_END)
> +#else
> +#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
> +#endif /* CONFIG_I2C_TWL4030_GPIO */
> +
> +#endif /* End of support for TWL4030 */
> +#endif /*  __ASM_ARCH_OMAP3_BEAGLE_H */
> +
> 
> Index: my_branch/include/asm-arm/arch-omap/hardware.h
> ===================================================================
> --- my_branch.orig/include/asm-arm/arch-omap/hardware.h	2008-04-16 14:44:09.000000000 +0530
> +++ my_branch/include/asm-arm/arch-omap/hardware.h	2008-04-16 14:47:14.000000000 +0530
> @@ -339,6 +339,10 @@
>  #include "board-omap3evm.h"
>  #endif
>  
> +#ifdef CONFIG_MACH_OMAP3_BEAGLE
> +#include "board-omap3beagle.h"
> +#endif
> +
>  #ifdef CONFIG_MACH_OMAP_APOLLON
>  #include "board-apollon.h"
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
