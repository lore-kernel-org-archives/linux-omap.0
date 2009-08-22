From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Sat, 22 Aug 2009 12:53:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C141@dbde02.ent.ti.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225AbZHVHXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 03:23:33 -0400
In-Reply-To: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Vikram,
Thanks for this clean-up series !!
Couple of comments.

<snip snip>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Friday, August 21, 2009 11:25 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk
> Cc: Pandita, Vikram
> Subject: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
> 
of arch/arm/plat-omap/include/mach/debug-
> macro.S
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/Kconfig                    |   50 ++++++++++++++++++--
> -----
>  arch/arm/plat-omap/include/mach/common.h      |    7 +++
>  arch/arm/plat-omap/include/mach/debug-macro.S |   40 ++++----------------
>  arch/arm/plat-omap/include/mach/uncompress.h  |   12 +----
>  4 files changed, 54 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ab9f9ef..2fefb64 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -162,21 +162,43 @@ config OMAP_DM_TIMER
>  	help
>  	 Select this option if you want to use OMAP Dual-Mode timers.
> 
> 
> +	  Specify the Physical address of Low level debug UART
> +	  Specify 0x0 in case you do not want DEBUG_LL functions to iterfere
> with your board uarts
> +
> +	  OMAP1:
> +	  -------------------
> +	  UART1 -> 0xfffb0000 (default)
> +	  UART2 -> 0xfffb0800
> +	  UART3 -> 0xfffb9800 (sx1, palmtt)
> +
> +	  OMAP2:
> +	  -------------------
> +	  UART1 -> 0x4806a000 (default)
> +	  UART2 -> 0x4806c000
> +	  UART3 -> 0x4806e000 (N8X0)
> +
> +	  OMAP3/4:
> +	  -------------------
> +	  UART1		-> 0x4806a000 (default: except following)
> +	  UART2		-> 0x4806c000
> +	  UART3		-> 0x49020000 (rx51, beagle, pendora, ldp, overo)

OMAP4 UART3 base address is 0x48020000

> +	  UART4		-> 0x4806e000
> +	  UART_EXT 	-> 0x10000000 (zoom2: Debug uart is on external debug
> board)
> 

> -
> -#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -		moveq	\rx, #0x48000000	@ physical base address
> -		movne	\rx, #0xd8000000	@ virtual base
> -		orr	\rx, \rx, #0x0006a000
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART2
> -		add	\rx, \rx, #0x00002000	@ UART 2
> -#endif
> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
> -		add	\rx, \rx, #0x00fb0000	@ UART 3
This was already wrong for OMAP4
> -		add	\rx, \rx, #0x00006000
> -#endif
> +					/* omap1 */
> +		ldr	\rx, =CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR @ physical base
> address
> +		subne	\rx, #CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR,
> #OMAP1_IO_OFFSET @ virtual base
> +#else
> +					/* omap2/omap3/omap4 */
> +		ldr	\rx, =CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR @ physical base
> address
> +		orrne	\rx, \rx, #OMAP2_IO_OFFSET	 @ virtual base
>  #endif
>  		.endm
> 
> diff --git a/arch/arm/plat-omap/include/mach/uncompress.h b/arch/arm/plat-
> omap/include/mach/uncompress.h
> index 0814c5f..0e21eb3 100644
> --- a/arch/arm/plat-omap/include/mach/uncompress.h
> +++ b/arch/arm/plat-omap/include/mach/uncompress.h
> @@ -38,14 +38,8 @@ static void putc(int c)
>  	return;
>  #endif
> 
> -#ifdef CONFIG_ARCH_OMAP
> -#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
> -	uart = (volatile u8 *)(OMAP_UART3_BASE);
> -#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
> -	uart = (volatile u8 *)(OMAP_UART2_BASE);
> -#else
> -	uart = (volatile u8 *)(OMAP_UART1_BASE);
> -#endif
> +#if defined(CONFIG_DEBUG_LL)
> +	uart = (volatile u8 *)(CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR);
> 
>  #ifdef CONFIG_ARCH_OMAP1
>  	/* Determine which serial port to use */
> @@ -62,7 +56,6 @@ static void putc(int c)
>  		return;
>  	} while (0);
>  #endif /* CONFIG_ARCH_OMAP1 */
> -#endif
> 

Regards,
Santosh
