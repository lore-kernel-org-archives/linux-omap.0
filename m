From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC: PATCH 4/4] AM335X: Add low level debugging support
Date: Wed, 24 Aug 2011 22:12:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC007CB7@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1313058630-32447-5-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38618 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab1HXQmN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 12:42:13 -0400
In-Reply-To: <1313058630-32447-5-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, August 11, 2011 4:01 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hilman, Kevin; paul@pwsan.com; linux-arm-
> kernel@lists.infradead.org; Mohammed, Afzal; Hiremath, Vaibhav
> Subject: [RFC: PATCH 4/4] AM335X: Add low level debugging support
> 
> From: Afzal Mohammed <afzal@ti.com>
> 
> Add support for low level debugging on AM335X EVM. Currently only
> support for UART1 console, which is used on AM335X EVM is added.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   21
> +++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
>  3 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S
> b/arch/arm/mach-omap2/include/mach/debug-macro.S
> index 309e328..a99ddbd 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -78,6 +78,8 @@ omap_uart_lsr:	.word	0
>  		beq	82f			@ configure UART2
>  		cmp	\rp, #TI81XXUART3	@ ti81Xx UART offsets different
>  		beq	83f			@ configure UART3
> +		cmp	\rp, #AM335XUART1	@ AM335X UART offsets different
> +		beq	84f			@ configure UART1
>  		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
>  		beq	95f			@ configure ZOOM_UART
> 
> @@ -106,6 +108,8 @@ omap_uart_lsr:	.word	0
>  		b	98f
>  83:		mov	\rp, #UART_OFFSET(TI81XX_UART3_BASE)
>  		b	98f
> +84:		mov	\rp, #UART_OFFSET(AM335X_UART1_BASE)
[Hiremath, Vaibhav] My bad, the above line results into build failure when you enable DEBUG_LL option,

    arch/arm/kernel/debug.S: Assembler messages:
    arch/arm/kernel/debug.S:138: Error: invalid constant (408) after fixup
    arch/arm/kernel/debug.S:157: Error: invalid constant (e09000) after fixup
    arch/arm/kernel/debug.S:173: Error: invalid constant (e09000) after fixup
    make[1]: *** [arch/arm/kernel/debug.o] Error 1
    make: *** [arch/arm/kernel] Error 2


When I submitted the patch, I only tried building it with omap2plus_defconfig and missed to enable DEBUG_LL option. 

I have fixed it with following change,

-84:            mov     \rp, #UART_OFFSET(AM335X_UART1_BASE)
+84:            ldr     \rp, =AM335X_UART1_BASE
+               and     \rp, \rp, #0x00ffffff

This will get merged in next patch version.

Thanks,
Vaibhav


> +		b	97f
>  95:		ldr	\rp, =ZOOM_UART_BASE
>  		mrc	p15, 0, \rv, c1, c0
>  		tst	\rv, #1			@ MMU enabled?
> @@ -121,6 +125,23 @@ omap_uart_lsr:	.word	0
>  		b	10b
> 
>  		/* Store both phys and virt address for the uart */
> +97:		add	\rp, \rp, #0x44000000	@ phys base
> +		mrc	p15, 0, \rv, c1, c0
> +		tst	\rv, #1			@ MMU enabled?
> +		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
> +		ldrne	\rv, =omap_uart_phys	@ MMU enabled
> +		str	\rp, [\rv, #0]
> +		sub	\rp, \rp, #0x44000000	@ phys base
> +		add	\rp, \rp, #0xf9000000	@ virt base
> +		add	\rv, \rv, #4		@ omap_uart_virt
> +		str	\rp, [\rv, #0]
> +		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
> +		add	\rv, \rv, #4		@ omap_uart_lsr
> +		str	\rp, [\rv, #0]
> +
> +		b	10b
> +
> +		/* Store both phys and virt address for the uart */
>  98:		add	\rp, \rp, #0x48000000	@ phys base
>  		mrc	p15, 0, \rv, c1, c0
>  		tst	\rv, #1			@ MMU enabled?
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-
> omap/include/plat/serial.h
> index 865b13e..d7c1216 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -59,6 +59,9 @@
>  /* AM3505/3517 UART4 */
>  #define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
> 
> +/* AM335X serial port */
> +#define AM335X_UART1_BASE	0x44E09000
> +
>  /* External port on Zoom2/3 */
>  #define ZOOM_UART_BASE		0x10000000
>  #define ZOOM_UART_VIRT		0xfa400000
> @@ -92,6 +95,7 @@
>  #define TI81XXUART1		81
>  #define TI81XXUART2		82
>  #define TI81XXUART3		83
> +#define AM335XUART1		84
>  #define ZOOM_UART		95		/* Only on zoom2/3 */
> 
>  /* This is only used by 8250.c for omap1510 */
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-
> omap/include/plat/uncompress.h
> index 8d052e7..3592ce4 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -97,6 +97,10 @@ static inline void flush(void)
>  	_DEBUG_LL_ENTRY(mach, TI81XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
>  		TI81XXUART##p)
> 
> +#define DEBUG_LL_AM335X(p, mach)					\
> +	_DEBUG_LL_ENTRY(mach, AM335X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
> +		AM335XUART##p)
> +
>  static inline void __arch_decomp_setup(unsigned long arch_id)
>  {
>  	int port = 0;
> @@ -178,6 +182,8 @@ static inline void __arch_decomp_setup(unsigned long
> arch_id)
>  		/* TI8148 base boards using UART1 */
>  		DEBUG_LL_TI81XX(1, ti8148evm);
> 
> +		/* AM335x base boards using UART1 */
> +		DEBUG_LL_AM335X(1, am335xevm);
>  	} while (0);
>  }
> 
> --
> 1.6.2.4

