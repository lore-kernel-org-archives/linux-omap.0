From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 30 Apr 2010 18:50:50 -0700
Message-ID: <20100501015050.GM29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203349.25812.64659.stgit@baageli.muru.com>
 <87sk6cirt0.fsf@deeprootsystems.com>
 <20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com>
 <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com>
 <20100501013751.GL29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52101 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab0EABu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 21:50:59 -0400
Content-Disposition: inline
In-Reply-To: <20100501013751.GL29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100430 18:33]:
> 
> So far only tested on n900, will give it a try also on zoom3 after
> updating the zoom3 related patch.

And here's the updated zoom debug_ll patch, seems to work.
 
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -20,27 +20,22 @@
>  #include <linux/types.h>
>  #include <linux/serial_reg.h>
>  
> +#include <asm/memory.h>
> +#include <asm/io.h>
>  #include <asm/mach-types.h>
>  
>  #include <plat/serial.h>

BTW, the include of asm/io.h is not needed, I'll remove that.

Regards,

Tony

--n/aVsWSeQ4JHkrmm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom-debug-ll.patch"

>From 0130fa96f1016c25540ded86ea66f5a6198489c7 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 30 Apr 2010 12:57:14 -0700
Subject: [PATCH] omap2/3: Fix DEBUG_LL for omap zoom2/3

Zoom2 and 3 have UARTs only on the external debug board.
GPMC needs to be mapped early to use it for DEBUG_LL.

Additionally, 0xfb000000 overlaps with other areas, so
use 0xfa400000 for the virtual address instead.

Note that with the pending serial.c patches you need to
set console=ttyS0,115200n8 as it will be the only UART
mapped. To use DEBUG_LL, you need to pass also earlyprintk
in cmdline.

Cc: Allen Pais <allen.pais@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index e15d2e8..1d7f827 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -82,7 +82,7 @@ static inline void __init zoom_init_smsc911x(void)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.mapbase	= 0x10000000,
+		.mapbase	= ZOOM_UART_BASE,
 		.irq		= OMAP_GPIO_IRQ(102),
 		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
 		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 9a26f84..803ef14 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -91,8 +91,8 @@ static void __init omap_zoom2_map_io(void)
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	.phys_io	= ZOOM_UART_BASE,
+	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom2_map_io,
 	.init_irq	= omap_zoom2_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index cd3e40c..3314704 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -73,8 +73,8 @@ static void __init omap_zoom_init(void)
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	.phys_io	= ZOOM_UART_BASE,
+	.io_pg_offst	= (ZOOM_UART_VIRT >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom_map_io,
 	.init_irq	= omap_zoom_init_irq,
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 4976169..35b2440 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -88,10 +88,10 @@ omap_uart_lsr:	.word	0
 		b	98f
 44:		mov	\rx, #UART_OFFSET(OMAP4_UART4_BASE)
 		b	98f
-95:		mov	\rx, #ZOOM_UART_BASE
+95:		ldr	\rx, =ZOOM_UART_BASE
 		ldr	\tmp, =omap_uart_phys
 		str	\rx, [\tmp, #0]
-		mov	\rx, #ZOOM_UART_VIRT
+		ldr	\rx, =ZOOM_UART_VIRT
 		ldr	\tmp, =omap_uart_virt
 		str	\rx, [\tmp, #0]
 		mov	\rx, #(UART_LSR << ZOOM_PORT_SHIFT)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 87f676a..3cfb425 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -166,6 +166,15 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.length		= L4_EMU_34XX_SIZE,
 		.type		= MT_DEVICE
 	},
+#if defined(CONFIG_DEBUG_LL) &&							\
+	(defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3))
+	{
+		.virtual	= ZOOM_UART_VIRT,
+		.pfn		= __phys_to_pfn(ZOOM_UART_BASE),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE
+	},
+#endif
 };
 #endif
 #ifdef	CONFIG_ARCH_OMAP4
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 20c27b9..a680715 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -41,7 +41,7 @@
 
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfb000000
+#define ZOOM_UART_VIRT		0xfa400000
 
 #define OMAP_PORT_SHIFT		2
 #define OMAP7XX_PORT_SHIFT	0

--n/aVsWSeQ4JHkrmm--
