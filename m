From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Mon, 24 Aug 2009 17:14:22 +0300
Message-ID: <20090824141422.GI5165@atomide.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com> <4A8FA4E7.9020206@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49226 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbZHXOOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:14:31 -0400
Content-Disposition: inline
In-Reply-To: <4A8FA4E7.9020206@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Kevin Hilman <khilman@deeprootsystems.com> [090822 16:31]:
> Vikram Pandita wrote:
>> This patch cleans up the DEBUG_LL infrastructure for omap boards.
>
> Thanks Vikram, this is indeed in need of some cleanup.  But I have some
> comments about the approach taken.
>
> This approach still doesn't solve one of the fundamental problems with
> the current implementation.  It prevents using a single kernel across
> multiple boards.  If we could drop the compile-time decision in favor of
> a runtime one based on machine-type, we could use a single base
> defconfig that would be able to be tested on all omap3 boards for example.
>
> For the zImage UART output (uncompress.h) there is a global variable
> __machine_arch_type which could be used to check the board type and set
> variable for UART base and shift.  We do this on DaVinci.

I agree we should do this.


> For debug output (debug-macro.S) those macros should be changed to use
> variables for UART base and shift also.  While you're in changing the
> board files, you could also add something like this to each:
>
> #ifdef CONFIG_SERIAL_8250_CONSOLE
> static int __init board_console_init(void)
> {
> 	return add_preferred_console("ttyS", <UART#>, "115200");
> }
> console_initcall(board_console_init);
> #endif
>
> This also allows the board to boot using a default UART even without
> having the console= on the cmdline.
>
> There is one catch to doing this at runtime instead of compile time.
> The variables for the UART base and shift have to be set very early in
> the boot, otherwise any errors from the early ARM asm boot (head.S) will
> be missed.
>
> For starters, they could be assingned in the board map_io hook, but we'd
> still miss the debug prints if there were any errors parsing the
> machine_type and processor_type early in the boot (head.S)
>
> I'd be ok with this limitation for a first pass because it's still
> better than what we currently have in l-o, but I'd like to hear if
> others had some ideas for how we might do dynamic decisions on UART
> based on board-type very early in the boot.

Yup, good comments.

Tony

>
> Kevin
>
>> The three stages of log printing infrastructure is using their own #defines
>> The patch integrates the three stages to use the same variable.
>>
>> Three stages are:
>> Stage 1: Prints - Uncompressing Linux......
>> 	File getting used: arch/arm/plat-omap/include/mach/uncompress.h
>> Stage 2: Prints - <5>Linux version 2.6.31
>> 	File getting used: arch/arm/plat-omap/include/mach/debug-macro.S
>> Stage 3: Kernel ttyS console takes over
>>
>> On enabling the DEBUG_LL menuconfig item
>> [Kernel Hacking -> Kernel low-level debugging functions]
>>
>> the following entry gets auto selected
>> [Systerm Type -> TI OMAP Implementations -> Low-level Debug console UART]
>>
>> This is the physical address of the UART getting used for the board.
>> The physical address of debug uart is provided as a menuconfig option now.
>>
>> Issue with current system:
>> (a) Zoom2 board has a detachable debug board having the TL16CP754 Quad uart chip.
>> If the debug board is not attached, _NO_ debug uart is available.
>> OMAP internal uarts are not used for traces on zoom2 board.
>> Current framework does not account for boards that may not have a debug uart
>> at all. The Stage 1 always accesses one of the uarts. Thats fixed now.
>>
>> (b) this patch does a cleanup of arch/arm/plat-omap/include/mach/debug-macro.S
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>  arch/arm/plat-omap/Kconfig                    |   50 ++++++++++++++++++-------
>>  arch/arm/plat-omap/include/mach/common.h      |    7 +++
>>  arch/arm/plat-omap/include/mach/debug-macro.S |   40 ++++----------------
>>  arch/arm/plat-omap/include/mach/uncompress.h  |   12 +----
>>  4 files changed, 54 insertions(+), 55 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>> index ab9f9ef..2fefb64 100644
>> --- a/arch/arm/plat-omap/Kconfig
>> +++ b/arch/arm/plat-omap/Kconfig
>> @@ -162,21 +162,43 @@ config OMAP_DM_TIMER
>>  	help
>>  	 Select this option if you want to use OMAP Dual-Mode timers.
>>  -choice
>> -	prompt "Low-level debug console UART"
>> -	depends on ARCH_OMAP
>> -	default OMAP_LL_DEBUG_UART1
>> -
>> -config OMAP_LL_DEBUG_UART1
>> -	bool "UART1"
>> -
>> -config OMAP_LL_DEBUG_UART2
>> -	bool "UART2"
>>  -config OMAP_LL_DEBUG_UART3
>> -	bool "UART3"
>> -
>> -endchoice
>> +config OMAP_DEBUG_LL_UART_PHY_ADDR
>> +	hex "Low-level debug console UART Physical Address"
>> +	depends on ARCH_OMAP && DEBUG_LL
>> +
>> +	default "0xfffb0800" if ARCH_OMAP1 && (MACH_OMAP_PALMTT || MACH_SX1)
>> +	default "0xfffb0000" if ARCH_OMAP1
>> +	default "0x4806e000" if ARCH_OMAP2 && MACH_NOKIA_N8X0
>> +	default "0x4806a000" if ARCH_OMAP2
>> +	default "0x49020000" if ARCH_OMAP3 && (MACH_NOKIA_RX51 || MACH_OMAP_BEAGLE)
>> +	default "0x49020000" if ARCH_OMAP3 && (MACH_OMAP3_PANDORA || MACH_OMAP_LDP || MACH_OVERO)
>> +	default "0x10000000" if ARCH_OMAP3 && MACH_OMAP_ZOOM2
>> +	default "0x4806a000" if ARCH_OMAP3
>> +	default "0x4806a000" if ARCH_OMAP4
>> +	help
>> +	  Specify the Physical address of Low level debug UART
>> +	  Specify 0x0 in case you do not want DEBUG_LL functions to iterfere with your board uarts
>> +
>> +	  OMAP1:
>> +	  -------------------
>> +	  UART1 -> 0xfffb0000 (default)
>> +	  UART2 -> 0xfffb0800
>> +	  UART3 -> 0xfffb9800 (sx1, palmtt)
>> +
>> +	  OMAP2:
>> +	  -------------------
>> +	  UART1 -> 0x4806a000 (default)
>> +	  UART2 -> 0x4806c000
>> +	  UART3 -> 0x4806e000 (N8X0)
>> +
>> +	  OMAP3/4:
>> +	  -------------------
>> +	  UART1		-> 0x4806a000 (default: except following)
>> +	  UART2		-> 0x4806c000
>> +	  UART3		-> 0x49020000 (rx51, beagle, pendora, ldp, overo)
>> +	  UART4		-> 0x4806e000
>> +	  UART_EXT 	-> 0x10000000 (zoom2: Debug uart is on external debug board)
>>   config OMAP_SERIAL_WAKE
>>  	bool "Enable wake-up events for serial ports"
>> diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
>> index fdeab42..f29d31f 100644
>> --- a/arch/arm/plat-omap/include/mach/common.h
>> +++ b/arch/arm/plat-omap/include/mach/common.h
>> @@ -68,4 +68,11 @@ void omap2_set_globals_sdrc(struct omap_globals *);
>>  void omap2_set_globals_control(struct omap_globals *);
>>  void omap2_set_globals_prcm(struct omap_globals *);
>>  +/* In case Low Level debug is not defined
>> + * make the low level uart address as zero
>> + */
>> +#if !defined(CONFIG_DEBUG_LL)
>> +#define CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR 0
>> +#endif
>> +
>>  #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
>> diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
>> index ac24050..f546d6c 100644
>> --- a/arch/arm/plat-omap/include/mach/debug-macro.S
>> +++ b/arch/arm/plat-omap/include/mach/debug-macro.S
>> @@ -10,43 +10,19 @@
>>   * published by the Free Software Foundation.
>>   *
>>  */
>> +#include "io.h"
>>   		.macro	addruart,rx
>>  		mrc	p15, 0, \rx, c1, c0
>>  		tst	\rx, #1			@ MMU enabled?
>>  #ifdef CONFIG_ARCH_OMAP1
>> -		moveq	\rx, #0xff000000	@ physical base address
>> -		movne	\rx, #0xfe000000	@ virtual base
>> -		orr	\rx, \rx, #0x00fb0000
>> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
>> -		orr	\rx, \rx, #0x00009000	@ UART 3
>> -#endif
>> -#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
>> -		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
>> -#endif
>> -
>> -#elif  CONFIG_ARCH_OMAP2
>> -		moveq	\rx, #0x48000000	@ physical base address
>> -		movne	\rx, #0xd8000000	@ virtual base
>> -		orr	\rx, \rx, #0x0006a000
>> -#ifdef CONFIG_OMAP_LL_DEBUG_UART2
>> -		add	\rx, \rx, #0x00002000	@ UART 2
>> -#endif
>> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
>> -		add	\rx, \rx, #0x00004000	@ UART 3
>> -#endif
>> -
>> -#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> -		moveq	\rx, #0x48000000	@ physical base address
>> -		movne	\rx, #0xd8000000	@ virtual base
>> -		orr	\rx, \rx, #0x0006a000
>> -#ifdef CONFIG_OMAP_LL_DEBUG_UART2
>> -		add	\rx, \rx, #0x00002000	@ UART 2
>> -#endif
>> -#ifdef CONFIG_OMAP_LL_DEBUG_UART3
>> -		add	\rx, \rx, #0x00fb0000	@ UART 3
>> -		add	\rx, \rx, #0x00006000
>> -#endif
>> +					/* omap1 */
>> +		ldr	\rx, =CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR @ physical base address
>> +		subne	\rx, #CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR, #OMAP1_IO_OFFSET @ virtual base
>> +#else
>> +					/* omap2/omap3/omap4 */
>> +		ldr	\rx, =CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR @ physical base address
>> +		orrne	\rx, \rx, #OMAP2_IO_OFFSET	 @ virtual base
>>  #endif
>>  		.endm
>>  diff --git a/arch/arm/plat-omap/include/mach/uncompress.h 
>> b/arch/arm/plat-omap/include/mach/uncompress.h
>> index 0814c5f..0e21eb3 100644
>> --- a/arch/arm/plat-omap/include/mach/uncompress.h
>> +++ b/arch/arm/plat-omap/include/mach/uncompress.h
>> @@ -38,14 +38,8 @@ static void putc(int c)
>>  	return;
>>  #endif
>>  -#ifdef CONFIG_ARCH_OMAP
>> -#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
>> -	uart = (volatile u8 *)(OMAP_UART3_BASE);
>> -#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
>> -	uart = (volatile u8 *)(OMAP_UART2_BASE);
>> -#else
>> -	uart = (volatile u8 *)(OMAP_UART1_BASE);
>> -#endif
>> +#if defined(CONFIG_DEBUG_LL)
>> +	uart = (volatile u8 *)(CONFIG_OMAP_DEBUG_LL_UART_PHY_ADDR);
>>   #ifdef CONFIG_ARCH_OMAP1
>>  	/* Determine which serial port to use */
>> @@ -62,7 +56,6 @@ static void putc(int c)
>>  		return;
>>  	} while (0);
>>  #endif /* CONFIG_ARCH_OMAP1 */
>> -#endif
>>   	/*
>>  	 * Now, xmit each character
>> @@ -70,6 +63,7 @@ static void putc(int c)
>>  	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
>>  		barrier();
>>  	uart[UART_TX << shift] = c;
>> +#endif /* CONFIG_DEBUG_LL */
>>  }
>>   static inline void flush(void)
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
