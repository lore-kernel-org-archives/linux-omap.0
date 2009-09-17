From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Fri, 18 Sep 2009 00:30:25 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9DAF13E@dbde02.ent.ti.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
 <4A8FA4E7.9020206@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com>
 <87hbvtfw8g.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com>
 <873a7dwfk0.fsf@deeprootsystems.com>
 <20090916191127.GB16457@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49530 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760230AbZIQTA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 15:00:59 -0400
In-Reply-To: <20090916191127.GB16457@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Russell

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>Sent: Wednesday, September 16, 2009 2:11 PM
>To: Kevin Hilman
>Cc: Pandita, Vikram; linux-omap@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk
>Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
>
>On Thu, Aug 27, 2009 at 04:29:35PM +0300, Kevin Hilman wrote:
>> > The idea is to write to phys_io and io_pg_offset from kernel/head.S
>> > very early based on the uart address found in compressed/misc.c
>> >
>> > To make map_io writable, I will have to change the MACHINE_START to
>> > remove the const.  It so happens that Russell has defined
>> > MACHINE_START to be a const.
>> >
>> > Not sure is removing const from MACHINE_START is acceptable?
>>
>> we'll find out after you post for RFC.
>
>The answer is no, it is not acceptable - it'll break XIP kernels
>because this is placed into the read-only part of the kernel image
>no matter what.

The good news is that Version 2 of DEBUG_LL cleanup patch [1], 
does not change the const attribute of MACHINE_START.

There are review comments by Kevin [2] still getting fixed, 
but a 'Russell-look' will surely help to the in-lined patch [3] .


Regards,
Vikram 

[1] 	git://dev.omapzoom.org/pub/scm/vikram/omap3.git runtime-debug-ll

[2] http://patchwork.kernel.org/patch/46909/

[3] Patch inlined below --- 

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4515728..7fcc21a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -277,6 +277,20 @@  not_relocated:	mov	r0, #0
 		blo	1b
 		add	sp, r1, #128		@ relocate the stack
 
+		mov	r9, r0
+
+		bl	get_uart_base		@ get uart phy address
+		adr     r2, __dummy
+		str	r0, [r2]		@save uart phy adder in memory
+		ldm	r2, {r13}^		@save phyadder in usermode reg
+
+		bl	get_uart_virt_base	@ get uart virtual address
+		adr     r2, __dummy
+		str	r0, [r2]		@save uart phy adder in memory
+		ldm	r2, {r14}^		@save phyadder in usermode reg
+
+		mov	r0, r9
+
 		bl	cache_clean_flush
 		add	pc, r5, r0		@ call relocation code
 
@@ -303,6 +317,9 @@  LC0:		.word	LC0			@ r1
 LC1:		.word	reloc_end - reloc_start
 		.size	LC0, . - LC0
 
+		.type   __dummy, #object
+__dummy:		.word	__dummy
+
 #ifdef CONFIG_ARCH_RPC
 		.globl	params
 params:		ldr	r0, =params_phys
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 17153b5..0758656 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -22,6 +22,15 @@  unsigned int __machine_arch_type;
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <asm/string.h>
+#include <asm/mach-types.h>
+/* TODO:
+ * Include of this header is not working.
+ * Gives Error: undefined reference to `omap_rev'
+ * This header is needed for constant:
+ * ZOOM2_EXT_QUART_VIRT = 0xFB000000
+ * ZOOM2_EXT_QUART_PHYS = 0x10000000
+ */
+/* #include <mach/io.h> */
 
 #ifdef STANDALONE_DEBUG
 #define putstr printf
@@ -316,6 +325,103 @@  static void error(char *x)
 
 #ifndef STANDALONE_DEBUG
 
+u32  *omap_uart_debug_ll_phy_addr;
+
+static void find_debug_ll_uart_port(unsigned int arch_type)
+{
+	omap_uart_debug_ll_phy_addr = 0;
+
+	/* Add logic here for new platforms, using __macine_arch_type */
+
+	/* TODO: REVISIT -- Check Completeness
+	 * DEFINE PHY ADDRESS for EACH BOARD HERE: omap1/2/3/4 */
+#if defined(CONFIG_ARCH_OMAP1)
+	switch (arch_type) {
+	case MACH_TYPE_OMAP_PALMTT:
+	case MACH_TYPE_SX1:
+		/* UART2 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0800;
+	break;
+	default:
+			/* UART1 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0000;
+	break;
+	}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2)
+	switch (arch_type) {
+	case MACH_TYPE_NOKIA_N800:
+	case MACH_TYPE_NOKIA_N810:
+	case MACH_TYPE_NOKIA_N810_WIMAX:
+		/* UART3 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806e000;
+	break;
+	default:
+		/* UART1 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
+	break;
+	}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3)
+	switch (arch_type) {
+	case MACH_TYPE_OMAP_LDP:
+	case MACH_TYPE_OVERO:
+	case MACH_TYPE_OMAP3_PANDORA:
+	case MACH_TYPE_NOKIA_RX51:
+	case MACH_TYPE_OMAP3_BEAGLE:
+		/* UART3 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x49020000;
+	break;
+	case MACH_TYPE_OMAP_ZOOM2:
+		/* EXTERNEL UART */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x10000000;
+	break;
+	default:
+		/* UART1 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
+	break;
+	}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+	switch (arch_type) {
+	/* OMAP3: UART1 */
+	case MACH_TYPE_OMAP_4430SDP:
+	default:
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
+		putstr("This is an OMAP4 ...\n");
+	break;
+	}
+#endif
+}
+
+ulg
+get_uart_base(void)
+{
+	return (ulg)omap_uart_debug_ll_phy_addr;
+}
+
+ulg
+get_uart_virt_base(void)
+{
+	ulg val = 0;
+
+#ifdef CONFIG_ARCH_OMAP1
+	/* omap1 */
+	val = 0xfef00000;
+#else
+	/* omap2/3/4... */
+	if (MACH_TYPE_OMAP_ZOOM2 == __machine_arch_type)
+		val = 0xFB000000; /* ZOOM2_EXT_QUART_VIRT */
+	else
+		val = 0xd8000000;
+#endif
+
+	return (ulg)(((val) >> 18) & 0xfffc);
+}
+
 ulg
 decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
 		  int arch_id)
@@ -325,6 +431,7 @@  decompress_kernel(ulg output_start, ulg free_mem_ptr_p, ulg free_mem_ptr_end_p,
 	free_mem_end_ptr	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
+	find_debug_ll_uart_port(arch_id);
 	arch_decomp_setup();
 
 	makecrc();
@@ -348,4 +455,3 @@  int main()
 	return 0;
 }
 #endif
-	
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..dc00780 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -162,22 +162,6 @@  config OMAP_DM_TIMER
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
-choice
-	prompt "Low-level debug console UART"
-	depends on ARCH_OMAP
-	default OMAP_LL_DEBUG_UART1
-
-config OMAP_LL_DEBUG_UART1
-	bool "UART1"
-
-config OMAP_LL_DEBUG_UART2
-	bool "UART2"
-
-config OMAP_LL_DEBUG_UART3
-	bool "UART3"
-
-endchoice
-
 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
 	depends on ARCH_OMAP1 && OMAP_MUX
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
index ac24050..ba80ca4 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -10,43 +10,42 @@ 
  * published by the Free Software Foundation.
  *
 */
+#include "io.h"
+
+		.align
+		.type   __phy_uart_addr, #object
+__phy_uart_addr:       .word   0xFF
+		.type   __virt_uart_addr, #object
+__virt_uart_addr:       .word   0xFF
 
 		.macro	addruart,rx
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-#ifdef CONFIG_ARCH_OMAP1
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		orr	\rx, \rx, #0x00009000	@ UART 3
-#endif
-#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
-		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
-#endif
+1000:
+		adr	r2,__phy_uart_addr
+		ldr	\rx, [r2]
+		tst	\rx, #0xFF
+		beq	1100f
+		stm	r2, {r13}^	@get uart phy addr
+		ldr	\rx, [r2]
 
-#elif  CONFIG_ARCH_OMAP2
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART2
-		add	\rx, \rx, #0x00002000	@ UART 2
-#endif
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		add	\rx, \rx, #0x00004000	@ UART 3
-#endif
+		adr	r2,__virt_uart_addr
+		stm	r2, {r14}^	@get uart virt addr
+		ldr	\rx, [r2]
+		lsl	\rx, \rx, #18
+		adr	r2,__phy_uart_addr
+		ldr	r2, [r2]
+		orr	\rx, \rx, r2
+		adr	r2,__virt_uart_addr
+		str	\rx, [r2]
+		b	1000b
+1100:
+		mrc	p15, 0, r2, c1, c0
+		tst	r2, #1			@ MMU enabled?
 
-#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART2
-		add	\rx, \rx, #0x00002000	@ UART 2
-#endif
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		add	\rx, \rx, #0x00fb0000	@ UART 3
-		add	\rx, \rx, #0x00006000
-#endif
+#ifdef CONFIG_ARCH_OMAP1
+		subne	\rx, \rx, #OMAP1_IO_OFFSET @ virtual base
+#else
+		adr	r2,__virt_uart_addr @ omap2/omap3/omap4/etc...
+		ldrne	\rx, [r2]
 #endif
 		.endm
 
@@ -55,13 +54,20 @@ 
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
+1001:		adr	\rd,__phy_uart_addr
+		ldr	\rd, [\rd]
+		cmp	\rd, #ZOOM2_EXT_QUART_PHYS
+		movne	\rd, #(0x5 << 2)
+		moveq	\rd, #(0x5 << 1)
+		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #0x60
 		teq	\rd, #0x60
+#ifdef CONFIG_ARCH_OMAP1
 		beq	1002f
 		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
 		and	\rd, \rd, #0x60
 		teq	\rd, #0x60
+#endif
 		bne	1001b
 1002:
 		.endm
diff --git a/arch/arm/plat-omap/include/mach/uncompress.h b/arch/arm/plat-omap/include/mach/uncompress.h
index 0814c5f..9121d7a 100644
--- a/arch/arm/plat-omap/include/mach/uncompress.h
+++ b/arch/arm/plat-omap/include/mach/uncompress.h
@@ -21,7 +21,8 @@ 
 #include <linux/serial_reg.h>
 #include <mach/serial.h>
 
-unsigned int system_rev;
+extern u32 *omap_uart_debug_ll_phy_addr;
+extern unsigned int __machine_arch_type;
 
 #define UART_OMAP_MDR1		0x08	/* mode definition register */
 #define OMAP_ID_730		0x355F
@@ -38,14 +39,16 @@  static void putc(int c)
 	return;
 #endif
 
-#ifdef CONFIG_ARCH_OMAP
-#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP_UART3_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP_UART2_BASE);
-#else
-	uart = (volatile u8 *)(OMAP_UART1_BASE);
-#endif
+	uart = (volatile u8 *)(omap_uart_debug_ll_phy_addr);
+	if (!uart)
+		return;
+
+	if (MACH_TYPE_OMAP_ZOOM2 == __machine_arch_type) {
+		/* External UART has a shift=1 requirement
+		 * Internal OMAP UARTs have shift=2 requirement
+		 */
+		shift = 1;
+	}
 
 #ifdef CONFIG_ARCH_OMAP1
 	/* Determine which serial port to use */
@@ -62,7 +65,6 @@  static void putc(int c)
 		return;
 	} while (0);
 #endif /* CONFIG_ARCH_OMAP1 */
-#endif
 
 	/*
 	 * Now, xmit each character
