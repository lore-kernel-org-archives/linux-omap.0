From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Thu, 17 Sep 2009 20:47:50 +0100
Message-ID: <20090917194750.GA12766@n2100.arm.linux.org.uk>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com> <4A8FA4E7.9020206@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com> <87hbvtfw8g.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com> <873a7dwfk0.fsf@deeprootsystems.com> <20090916191127.GB16457@n2100.arm.linux.org.uk> <FCCFB4CDC6E5564B9182F639FC35608702F9DAF13E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37889 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZIQTsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 15:48:05 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9DAF13E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, Sep 18, 2009 at 12:30:25AM +0530, Pandita, Vikram wrote:
> There are review comments by Kevin [2] still getting fixed, 
> but a 'Russell-look' will surely help to the in-lined patch [3] .

Still not good.

> +		mov	r9, r0
> +
> +		bl	get_uart_base		@ get uart phy address
> +		adr     r2, __dummy
> +		str	r0, [r2]		@save uart phy adder in memory
> +		ldm	r2, {r13}^		@save phyadder in usermode reg
> +
> +		bl	get_uart_virt_base	@ get uart virtual address
> +		adr     r2, __dummy
> +		str	r0, [r2]		@save uart phy adder in memory
> +		ldm	r2, {r14}^		@save phyadder in usermode reg
> +
> +		mov	r0, r9
> +
>  		bl	cache_clean_flush
>  		add	pc, r5, r0		@ call relocation code
>  
> @@ -303,6 +317,9 @@  LC0:		.word	LC0			@ r1
>  LC1:		.word	reloc_end - reloc_start
>  		.size	LC0, . - LC0
>  
> +		.type   __dummy, #object
> +__dummy:		.word	__dummy

This appears to be in the text segment, and is written to.  That's not
going to work if the text segment is stored in flash (and in fact might
be dangerous in some cases.)

> +
>  #ifdef CONFIG_ARCH_RPC
>  		.globl	params
>  params:		ldr	r0, =params_phys
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 17153b5..0758656 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -22,6 +22,15 @@  unsigned int __machine_arch_type;
>  #include <linux/types.h>	/* for size_t */
>  #include <linux/stddef.h>	/* for NULL */
>  #include <asm/string.h>
> +#include <asm/mach-types.h>
> +/* TODO:
> + * Include of this header is not working.
> + * Gives Error: undefined reference to `omap_rev'
> + * This header is needed for constant:
> + * ZOOM2_EXT_QUART_VIRT = 0xFB000000
> + * ZOOM2_EXT_QUART_PHYS = 0x10000000
> + */
> +/* #include <mach/io.h> */
>  
>  #ifdef STANDALONE_DEBUG
>  #define putstr printf
> @@ -316,6 +325,103 @@  static void error(char *x)
>  
>  #ifndef STANDALONE_DEBUG
>  
> +u32  *omap_uart_debug_ll_phy_addr;
> +
> +static void find_debug_ll_uart_port(unsigned int arch_type)
> +{
> +	omap_uart_debug_ll_phy_addr = 0;
> +
> +	/* Add logic here for new platforms, using __macine_arch_type */
> +
> +	/* TODO: REVISIT -- Check Completeness
> +	 * DEFINE PHY ADDRESS for EACH BOARD HERE: omap1/2/3/4 */
> +#if defined(CONFIG_ARCH_OMAP1)
> +	switch (arch_type) {
> +	case MACH_TYPE_OMAP_PALMTT:
> +	case MACH_TYPE_SX1:
> +		/* UART2 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0800;
> +	break;
> +	default:
> +			/* UART1 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0000;
> +	break;
> +	}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP2)
> +	switch (arch_type) {
> +	case MACH_TYPE_NOKIA_N800:
> +	case MACH_TYPE_NOKIA_N810:
> +	case MACH_TYPE_NOKIA_N810_WIMAX:
> +		/* UART3 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806e000;
> +	break;
> +	default:
> +		/* UART1 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
> +	break;
> +	}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP3)
> +	switch (arch_type) {
> +	case MACH_TYPE_OMAP_LDP:
> +	case MACH_TYPE_OVERO:
> +	case MACH_TYPE_OMAP3_PANDORA:
> +	case MACH_TYPE_NOKIA_RX51:
> +	case MACH_TYPE_OMAP3_BEAGLE:
> +		/* UART3 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x49020000;
> +	break;
> +	case MACH_TYPE_OMAP_ZOOM2:
> +		/* EXTERNEL UART */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x10000000;
> +	break;
> +	default:
> +		/* UART1 */
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
> +	break;
> +	}
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +	switch (arch_type) {
> +	/* OMAP3: UART1 */
> +	case MACH_TYPE_OMAP_4430SDP:
> +	default:
> +		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
> +		putstr("This is an OMAP4 ...\n");
> +	break;
> +	}
> +#endif
> +}
> +
> +ulg
> +get_uart_base(void)
> +{
> +	return (ulg)omap_uart_debug_ll_phy_addr;
> +}
> +
> +ulg
> +get_uart_virt_base(void)
> +{
> +	ulg val = 0;
> +
> +#ifdef CONFIG_ARCH_OMAP1
> +	/* omap1 */
> +	val = 0xfef00000;
> +#else
> +	/* omap2/3/4... */
> +	if (MACH_TYPE_OMAP_ZOOM2 == __machine_arch_type)
> +		val = 0xFB000000; /* ZOOM2_EXT_QUART_VIRT */
> +	else
> +		val = 0xd8000000;
> +#endif
> +
> +	return (ulg)(((val) >> 18) & 0xfffc);
> +}
> +

Clearly, all this code should not be in here.  There's a perfectly good
header file to contain the platform specifics which it can live in, and
there's a perfectly good hook for it to latch into (arch_decomp_setup).

> diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
> index ac24050..ba80ca4 100644
> --- a/arch/arm/plat-omap/include/mach/debug-macro.S
> +++ b/arch/arm/plat-omap/include/mach/debug-macro.S
> @@ -10,43 +10,42 @@ 
>   * published by the Free Software Foundation.
>   *
>  */
> +#include "io.h"
> +
> +		.align
> +		.type   __phy_uart_addr, #object
> +__phy_uart_addr:       .word   0xFF
> +		.type   __virt_uart_addr, #object
> +__virt_uart_addr:       .word   0xFF

Again, this ends up in the text segment, and in the XIP case, the text
segment is not writable (writes hit the flash chip.)

> diff --git a/arch/arm/plat-omap/include/mach/uncompress.h b/arch/arm/plat-omap/include/mach/uncompress.h
> index 0814c5f..9121d7a 100644
> --- a/arch/arm/plat-omap/include/mach/uncompress.h
> +++ b/arch/arm/plat-omap/include/mach/uncompress.h
> @@ -21,7 +21,8 @@ 
>  #include <linux/serial_reg.h>
>  #include <mach/serial.h>
>  
> -unsigned int system_rev;
> +extern u32 *omap_uart_debug_ll_phy_addr;
> +extern unsigned int __machine_arch_type;

Just include asm/mach-types.h - there's no need to declare this here.
