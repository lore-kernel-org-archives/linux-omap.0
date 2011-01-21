From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 4/4] TI816X: Add low level debug support
Date: Fri, 21 Jan 2011 15:51:07 -0800
Message-ID: <87zkqtddec.fsf@ti.com>
References: <1294677487-18878-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51417 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059Ab1AUXvL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 18:51:11 -0500
Received: by ywj3 with SMTP id 3so785832ywj.0
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 15:51:10 -0800 (PST)
In-Reply-To: <1294677487-18878-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Mon, 10 Jan 2011 22:08:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds support for low level debugging on TI816X boards. Currently the
> support for UART3 console on TI816X EVM is added.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

You can add the UART base addresses in this patch since this is the only
place they are needed/used.

Kevin

> ---
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++++++++++++
>  arch/arm/plat-omap/include/plat/serial.h       |    3 +++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    7 +++++++
>  3 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
> index 6a4d413..e1b0f17 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -69,6 +69,12 @@ omap_uart_lsr:	.word	0
>  		beq	34f			@ configure OMAP3UART4
>  		cmp	\rp, #OMAP4UART4	@ only on 44xx
>  		beq	44f			@ configure OMAP4UART4
> +		cmp	\rp, #TI816XUART1	@ ti816x UART offsets different
> +		beq	81f			@ configure UART1
> +		cmp	\rp, #TI816XUART2	@ ti816x UART offsets different
> +		beq	82f			@ configure UART2
> +		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
> +		beq	83f			@ configure UART3
>  		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
>  		beq	95f			@ configure ZOOM_UART
>  
> @@ -91,6 +97,12 @@ omap_uart_lsr:	.word	0
>  		b	98f
>  44:		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
>  		b	98f
> +81:		mov	\rp, #UART_OFFSET(TI816X_UART1_BASE)
> +		b	98f
> +82:		mov	\rp, #UART_OFFSET(TI816X_UART2_BASE)
> +		b	98f
> +83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
> +		b	98f
>  95:		ldr	\rp, =ZOOM_UART_BASE
>  		mrc	p15, 0, \rv, c1, c0
>  		tst	\rv, #1			@ MMU enabled?
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index 3c3c319..4102bf4 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -86,6 +86,9 @@
>  #define OMAP4UART2		OMAP2UART2
>  #define OMAP4UART3		43
>  #define OMAP4UART4		44
> +#define TI816XUART1		81
> +#define TI816XUART2		82
> +#define TI816XUART3		83
>  #define ZOOM_UART		95		/* Only on zoom2/3 */
>  
>  /* This is only used by 8250.c for omap1510 */
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index ad98b85..30b891c 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -93,6 +93,10 @@ static inline void flush(void)
>  #define DEBUG_LL_ZOOM(mach)						\
>  	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
>  
> +#define DEBUG_LL_TI816X(p, mach)					\
> +	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
> +		TI816XUART##p)
> +
>  static inline void __arch_decomp_setup(unsigned long arch_id)
>  {
>  	int port = 0;
> @@ -166,6 +170,9 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		DEBUG_LL_ZOOM(omap_zoom2);
>  		DEBUG_LL_ZOOM(omap_zoom3);
>  
> +		/* TI8168 base boards using UART3 */
> +		DEBUG_LL_TI816X(3, ti8168evm);
> +
>  	} while (0);
>  }
