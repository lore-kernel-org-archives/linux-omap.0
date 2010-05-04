From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02a/11] omap: Use a memory address for storing the debug
 port info instead of UART1 scratchpad
Date: Mon, 3 May 2010 17:57:09 -0700
Message-ID: <20100504005709.GE29604@atomide.com>
References: <20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com>
 <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com>
 <20100501013751.GL29604@atomide.com>
 <20100501015050.GM29604@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
 <20100504004001.GB29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Zrag5V6pnZGjLKiw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56614 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab0EDA5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:57:11 -0400
Content-Disposition: inline
In-Reply-To: <20100504004001.GB29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's this patch one more time. I updated the comments
for what I think the new shortcomings are.

I also changed #define OMAP_UART_INFO (PHYS_OFFSET + 0x3ffc)
instead of 0x3ff8 as it's set as u32.

Regards,

Tony

--Zrag5V6pnZGjLKiw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-debug-ll-memory.patch"

>From 96554d70775e936e870f61d9523c9bab3fd54ad6 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 30 Apr 2010 17:39:19 -0700
Subject: [PATCH] omap: Use a memory address for storing the debug port info instead of UART1 scratchpad

This removes the dependency to the UART1 being available for storing
the debug configuration in uncompress.h. This will simplify the
DEBUG_LL UART configuration for boards that may not have UART1, or
have an external UART as it requires only one mapping for DEBUG_LL.

The patch has a few limitations. Basically now we're assuming that
the kernel uncompress code won't overlap with OMAP_UART_INFO. We also
assume the printascii is called at least once before paging_init in
order for addruart to have a chance to read the UART setup from
OMAP_UART_INFO.

As suggested by Cyril Chemparathy <cyril@ti.com>,
Vikram Pandita <vikram.pandita@ti.com> and
Kevin Hilman <khilman@deeprootsystems.com>. Based on an earlier
patch posted for Davinci by Cyril Chemparathy <cyril@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index b6d9584..e8a8cf3 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -13,6 +13,8 @@
 
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
+
 #include <plat/serial.h>
 
 		.pushsection .data
@@ -37,23 +39,12 @@ omap_uart_virt:	.word	0x0
 		cmp	\rx, #0			@ is port configured?
 		bne	99f			@ already configured
 
-		/* Check 7XX UART1 scratchpad register for uart to use */
+		/* Check the debug UART configuration set in uncompress.h */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP7XX_PORT_SHIFT)]
-		cmp	\rx, #0			@ anything in 7XX scratchpad?
-		bne	10f			@ found 7XX uart
-
-		/* Check 15xx/16xx UART1 scratchpad register for uart to use */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)]
+		ldreq	\rx, =OMAP_UART_INFO
+		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
+		ldr	\rx, [\rx, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 10:		cmp	\rx, #0			@ no port configured?
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 4a63a2e..4976169 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -13,6 +13,8 @@
 
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
+
 #include <plat/serial.h>
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
@@ -40,13 +42,12 @@ omap_uart_lsr:	.word	0
 		cmp	\rx, #0			@ is port configured?
 		bne	99f			@ already configured
 
-		/* Check UART1 scratchpad register for uart to use */
+		/* Check the debug UART configuration set in uncompress.h */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xfa000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000	@ uart1 on omap2/3/4
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)] @ scratchpad
+		ldreq	\rx, =OMAP_UART_INFO
+		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
+		ldr	\rx, [\rx, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 		cmp	\rx, #0			@ no port configured?
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 83dce4c..42a6318 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -15,6 +15,20 @@
 
 #include <linux/init.h>
 
+/*
+ * Memory entry used for the DEBUG_LL UART configuration. See also
+ * uncompress.h and debug-macro.S.
+ *
+ * Note that using a memory location for storing the UART configuration
+ * has at least two limitations:
+ *
+ * 1. Kernel uncompress code cannot overlap OMAP_UART_INFO as the
+ *    uncompress code could then partially overwrite itself
+ * 2. We assume printascii is called at least once before paging_init,
+ *    and addruart has a chance to read OMAP_UART_INFO
+ */
+#define OMAP_UART_INFO		(PHYS_OFFSET + 0x3ffc)
+
 /* OMAP1 serial ports */
 #define OMAP1_UART1_BASE	0xfffb0000
 #define OMAP1_UART2_BASE	0xfffb0800
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 81d9ec5..bbedd71 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -20,27 +20,21 @@
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
 #include <asm/mach-types.h>
 
 #include <plat/serial.h>
 
-static volatile u8 *uart1_base;
-static int uart1_shift;
-
 static volatile u8 *uart_base;
 static int uart_shift;
 
 /*
- * Store the DEBUG_LL uart number into UART1 scratchpad register.
+ * Store the DEBUG_LL uart number into memory.
  * See also debug-macro.S, and serial.c for related code.
- *
- * Please note that we currently assume that:
- * - UART1 clocks are enabled for register access
- * - UART1 scratchpad register can be used
  */
-static void set_uart1_scratchpad(unsigned char port)
+static void set_omap_uart_info(unsigned char port)
 {
-	uart1_base[UART_SCR << uart1_shift] = port;
+	*(volatile u32 *)OMAP_UART_INFO = port;
 }
 
 static void putc(int c)
@@ -60,42 +54,38 @@ static inline void flush(void)
 /*
  * Macros to configure UART1 and debug UART
  */
-#define _DEBUG_LL_ENTRY(mach, uart1_phys, uart1_shft,			\
-			dbg_uart, dbg_shft, dbg_id)			\
+#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
 	if (machine_is_##mach()) {					\
-		uart1_base = (volatile u8 *)(uart1_phys);		\
-		uart1_shift = (uart1_shft);				\
 		uart_base = (volatile u8 *)(dbg_uart);			\
 		uart_shift = (dbg_shft);				\
 		port = (dbg_id);					\
-		set_uart1_scratchpad(port);				\
+		set_omap_uart_info(port);				\
 		break;							\
 	}
 
 #define DEBUG_LL_OMAP7XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP7XX_PORT_SHIFT,	\
-		OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT, OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT,	\
+		OMAP1UART##p)
 
 #define DEBUG_LL_OMAP1(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP1UART##p)
 
 #define DEBUG_LL_OMAP2(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP2UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP2UART##p)
 
 #define DEBUG_LL_OMAP3(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP3_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP3UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP3UART##p)
 
 #define DEBUG_LL_OMAP4(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP4_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP4UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP4UART##p)
 
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
-		ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
+	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {

--Zrag5V6pnZGjLKiw--
