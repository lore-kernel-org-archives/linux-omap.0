From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/16] ARM: OMAP2 Provide function to enable/disable
	uart clocks
Date: Sat, 23 Aug 2008 15:21:01 -0700
Message-ID: <20080823222101.GB4713@atomide.com>
References: <1212803277-18007-1-git-send-email-tony@atomide.com> <1212803277-18007-2-git-send-email-tony@atomide.com> <20080819164013.GA17034@flint.arm.linux.org.uk> <87r68k6xse.fsf@trdhcp146196.ntc.nokia.com> <20080820072813.GB28862@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54544 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYHWWVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 18:21:08 -0400
Content-Disposition: inline
In-Reply-To: <20080820072813.GB28862@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [080820 00:28]:
> * Högander Jouni <jouni.hogander@nokia.com> [080820 08:50]:
> > "ext Russell King - ARM Linux" <linux@arm.linux.org.uk> writes:
> > 
> > > On Fri, Jun 06, 2008 at 06:47:42PM -0700, Tony Lindgren wrote:
> > >> This patch adds common function to enable/disable omap2/3 uart
> > >> clocks. Enabled uarts are passed by bootloader in atags and clocks for
> > >> these enabled uarts are touched.
> > >
> > > In some ways, this patch is a good thing, in others it's outrageous.
> > >
> > >> -static struct clk * uart1_ick = NULL;
> > >> -static struct clk * uart1_fck = NULL;
> > >> -static struct clk * uart2_ick = NULL;
> > >> -static struct clk * uart2_fck = NULL;
> > >> -static struct clk * uart3_ick = NULL;
> > >> -static struct clk * uart3_fck = NULL;
> > >> +static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
> > >> +static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
> > >>  
> > >>  static struct plat_serial8250_port serial_platform_data[] = {
> > >>  	{
> > >> -		.membase	= (char *)IO_ADDRESS(OMAP_UART1_BASE),
> > >> +		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
> > >
> > > __force in drivers is a big no no, immediate patch rejection.  Drivers
> > > do not use __force.
> > >
> > > The reason for adding __iomem is to pick up where people are doing
> > > stupid things with pointers, and __force is added in _private_ code
> > > (eg, functions supporting IO, mapping functions, etc) to provide a
> > > way of saying "this is part of the infrastructure and its permitted
> > > to do this conversion."
> > >
> > > The correct place for that cast, in its entirety, is inside the
> > > IO_ADDRESS macro.
> > >
> > >> @@ -71,7 +67,7 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
> > >>  				    int value)
> > >>  {
> > >>  	offset <<= p->regshift;
> > >> -	__raw_writeb(value, (unsigned long)(p->membase + offset));
> > >> +	__raw_writeb(value, p->membase + offset);
> > >
> > > Good.
> > >
> > >> @@ -87,10 +83,27 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
> > >>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
> > >>  }
> > >>  
> > >> -void __init omap_serial_init()
> > >> +void omap_serial_enable_clocks(int enable)
> > >> +{
> > >> +	int i;
> > >> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> > >> +		if (uart_ick[i] && uart_fck[i]) {
> > >> +			if (enable) {
> > >> +				clk_enable(uart_ick[i]);
> > >> +				clk_enable(uart_fck[i]);
> > >> +			} else {
> > >> +				clk_disable(uart_ick[i]);
> > >> +				clk_disable(uart_fck[i]);
> > >> +			}
> > >> +		}
> > >> +	}
> > >> +}
> > >
> > > Urgh.  Why enable all clocks?  I thought OMAP was about being as lean
> > > and mean as possible as far as power management goes, so why enable
> > > everything and disable everything?
> > 
> > Not everything, just those that are marked as a enabled by a
> > bootloader. This mean basically serial-console uart. If all three omap
> > uarts are used as a serial console, then this function will
> > disable/enable clocks for all of them.
> 
> Or marked as enabled in board-*.c file. The omap ATAGs are not going
> to mainline tree as discussed earlier and will get removed from l-o
> tree eventually also. Any bootloader tags must be generic, such as
> ATAG_UART or something similar.
> 
> > > Looking at the omapzoom tree, this function isn't even referenced by
> > > another part of the kernel, so maybe this function is just cruft?
> > 
> > This function is added for dynamic PM to have a mean to enable/disable
> > serial console clocks. My intention is to be able to have PM when
> > serial console is used without need to reboot the device and changing
> > atags from the bootloader. There are patches on linux-omap list which are
> > using this. They are not pushed yet.
> 
> The long term solution is to switch to omap-uart instead of 8250.c so we
> can support DMA and dynamic power and clocking.
> 
> > 
> > >
> > >> +		sprintf(name, "uart%d_ick", i+1);
> > >> +		uart_ick[i] = clk_get(NULL, name);
> > >> +		if (IS_ERR(uart_ick[i])) {
> > >> +			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
> > >> +			uart_ick[i] = NULL;
> > >> +		} else
> > >> +			clk_enable(uart_ick[i]);
> > >> +
> > >> +		sprintf(name, "uart%d_fck", i+1);
> > >> +		uart_fck[i] = clk_get(NULL, name);
> > >> +		if (IS_ERR(uart_fck[i])) {
> > >> +			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> > >> +			uart_fck[i] = NULL;
> > >> +		} else
> > >> +			clk_enable(uart_fck[i]);
> > >
> > > Definitely an improvement, but still some way to go yet... but not a
> > > reason not to get this in (once the above issues have been resolved.)
> > >
> > >
> > 

Here's this one updated with __force removed.

Tony

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=0001-serial

>From bb49b3cd1da2f23b344fcaf32607d280731d2653 Mon Sep 17 00:00:00 2001
From: Jouni Hogander <jouni.hogander@nokia.com>
Date: Sat, 23 Aug 2008 15:19:46 -0700
Subject: [PATCH] ARM: OMAP2 Provide function to enable/disable uart clocks

This patch adds common function to enable/disable omap2/3 uart
clocks. Enabled uarts are passed by bootloader in atags and clocks for
these enabled uarts are touched.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index adc8a26..bd6f8c9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -3,7 +3,7 @@
  *
  * OMAP2 serial support.
  *
- * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2005-2008 Nokia Corporation
  * Author: Paul Mundt <paul.mundt@nokia.com>
  *
  * Based off of arch/arm/mach-omap/omap1/serial.c
@@ -18,43 +18,39 @@
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <mach/common.h>
 #include <mach/board.h>
 
-static struct clk * uart1_ick = NULL;
-static struct clk * uart1_fck = NULL;
-static struct clk * uart2_ick = NULL;
-static struct clk * uart2_fck = NULL;
-static struct clk * uart3_ick = NULL;
-static struct clk * uart3_fck = NULL;
+static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
+static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= (char *)IO_ADDRESS(OMAP_UART1_BASE),
+		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= (unsigned long)OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= (unsigned long)OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= (unsigned long)OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.flags		= 0
 	}
@@ -71,7 +67,7 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 				    int value)
 {
 	offset <<= p->regshift;
-	__raw_writeb(value, (unsigned long)(p->membase + offset));
+	__raw_writeb(value, p->membase + offset);
 }
 
 /*
@@ -87,10 +83,27 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
-void __init omap_serial_init()
+void omap_serial_enable_clocks(int enable)
+{
+	int i;
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		if (uart_ick[i] && uart_fck[i]) {
+			if (enable) {
+				clk_enable(uart_ick[i]);
+				clk_enable(uart_fck[i]);
+			} else {
+				clk_disable(uart_ick[i]);
+				clk_disable(uart_fck[i]);
+			}
+		}
+	}
+}
+
+void __init omap_serial_init(void)
 {
 	int i;
 	const struct omap_uart_config *info;
+	char name[16];
 
 	/*
 	 * Make sure the serial ports are muxed on at this point.
@@ -98,8 +111,7 @@ void __init omap_serial_init()
 	 * if not needed.
 	 */
 
-	info = omap_get_config(OMAP_TAG_UART,
-			       struct omap_uart_config);
+	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
 
 	if (info == NULL)
 		return;
@@ -108,58 +120,26 @@ void __init omap_serial_init()
 		struct plat_serial8250_port *p = serial_platform_data + i;
 
 		if (!(info->enabled_uarts & (1 << i))) {
-			p->membase = 0;
+			p->membase = NULL;
 			p->mapbase = 0;
 			continue;
 		}
 
-		switch (i) {
-		case 0:
-			uart1_ick = clk_get(NULL, "uart1_ick");
-			if (IS_ERR(uart1_ick))
-				printk("Could not get uart1_ick\n");
-			else {
-				clk_enable(uart1_ick);
-			}
-
-			uart1_fck = clk_get(NULL, "uart1_fck");
-			if (IS_ERR(uart1_fck))
-				printk("Could not get uart1_fck\n");
-			else {
-				clk_enable(uart1_fck);
-			}
-			break;
-		case 1:
-			uart2_ick = clk_get(NULL, "uart2_ick");
-			if (IS_ERR(uart2_ick))
-				printk("Could not get uart2_ick\n");
-			else {
-				clk_enable(uart2_ick);
-			}
-
-			uart2_fck = clk_get(NULL, "uart2_fck");
-			if (IS_ERR(uart2_fck))
-				printk("Could not get uart2_fck\n");
-			else {
-				clk_enable(uart2_fck);
-			}
-			break;
-		case 2:
-			uart3_ick = clk_get(NULL, "uart3_ick");
-			if (IS_ERR(uart3_ick))
-				printk("Could not get uart3_ick\n");
-			else {
-				clk_enable(uart3_ick);
-			}
-
-			uart3_fck = clk_get(NULL, "uart3_fck");
-			if (IS_ERR(uart3_fck))
-				printk("Could not get uart3_fck\n");
-			else {
-				clk_enable(uart3_fck);
-			}
-			break;
-		}
+		sprintf(name, "uart%d_ick", i+1);
+		uart_ick[i] = clk_get(NULL, name);
+		if (IS_ERR(uart_ick[i])) {
+			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
+			uart_ick[i] = NULL;
+		} else
+			clk_enable(uart_ick[i]);
+
+		sprintf(name, "uart%d_fck", i+1);
+		uart_fck[i] = clk_get(NULL, name);
+		if (IS_ERR(uart_fck[i])) {
+			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
+			uart_fck[i] = NULL;
+		} else
+			clk_enable(uart_fck[i]);
 
 		omap_serial_reset(p);
 	}
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 0609311..515c628 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -34,6 +34,7 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
+extern void omap_serial_enable_clocks(int enable);
 #ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index cc6bfa5..abea6ef 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -20,11 +20,17 @@
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x4806e000
+#elif defined(CONFIG_ARCH_OMAP3)
+/* OMAP3 serial ports */
+#define OMAP_UART1_BASE		0x4806a000
+#define OMAP_UART2_BASE		0x4806c000
+#define OMAP_UART3_BASE		0x49020000
 #endif
 
 #define OMAP_MAX_NR_PORTS	3
 #define OMAP1510_BASE_BAUD	(12000000/16)
 #define OMAP16XX_BASE_BAUD	(48000000/16)
+#define OMAP24XX_BASE_BAUD	(48000000/16)
 
 #define is_omap_port(p)	({int __ret = 0;			\
 			if (p == IO_ADDRESS(OMAP_UART1_BASE) ||	\

--i9LlY+UWpKt15+FH--
