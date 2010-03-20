From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Fri, 19 Mar 2010 19:48:27 -0700
Message-ID: <20100320024827.GC11448@atomide.com>
References: <20100320003605.GA11448@atomide.com>
 <20100320004746.GB11448@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55877 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0CTCq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 22:46:56 -0400
Content-Disposition: inline
In-Reply-To: <20100320004746.GB11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Allen Pais <allen.pais@ti.com>, Vikram Pandita <vikram.pandita@ti.com>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100319 17:42]:
> * Tony Lindgren <tony@atomide.com> [100319 17:30]:
> > Hi all,
> > 
> > Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.
> 
> And of course it won't compile because of a missing #.
> Here's the working version.

One more time. Looks like what I posted is not enough, we
also need to make sure the mapping does not overlap with
other regions. So basically we can't use 0xfb000000 like
we currently have, let's use 0xf7000000 instead unless
somebody has better ideas.

Regards,

Tony

--7qSK/uQB79J36Y4o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom-uart.patch"

>From e1b58f9dec794a9ed7fb999a38874f9d785617b7 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 19 Mar 2010 17:18:45 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3

Zoom2 and 3 have UARTs only on the external debug board.
GPMC needs to be mapped early to use it for DEBUG_LL.

Additionally, 0xfb000000 overlaps with other areas, so
use 0xf7000000 for the virtual address instead.

Note that with the pending serial.c patches you need to
set console=ttyS0,115200n8 as it will be the only UART
mapped. To use DEBUG_LL, you need to pass also earlyprintk
in cmdline.

Cc: Allen Pais <allen.pais@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..d13af88 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -328,6 +328,15 @@ __create_page_tables:
 	add	r0, r4, #0xd8000000 >> 18
 	str	r3, [r0]
 #endif
+#if defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3)
+	/*
+	 * Zoom2 and Zoom3 have UARTs only on the debug board.
+	 * The debug board is connected to the GPMC.
+	 */
+	add	r0, r4, #0xf7000000 >> 18
+	orr	r3, r7, #0x10000000
+	str	r3, [r0]
+#endif
 #endif
 	mov	pc, lr
 ENDPROC(__create_page_tables)
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
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 87f676a..1803aac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -166,6 +166,15 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.length		= L4_EMU_34XX_SIZE,
 		.type		= MT_DEVICE
 	},
+#if defined(CONFIG_DEBUG_LL) &&						\
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
index 83dce4c..a18f617 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -39,7 +39,7 @@
 
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfb000000
+#define ZOOM_UART_VIRT		0xf7000000
 
 #define OMAP_PORT_SHIFT		2
 #define OMAP7XX_PORT_SHIFT	0

--7qSK/uQB79J36Y4o--
