From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/16] ARM: OMAP2 Provide function to enable/disable uart clocks
Date: Fri,  6 Jun 2008 18:47:42 -0700
Message-ID: <1212803277-18007-2-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-06-06-184753
 <1212803277-18007-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:62427 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYFGBsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:48:01 -0400
In-Reply-To: <1212803277-18007-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

This patch adds common function to enable/disable omap2/3 uart
clocks. Enabled uarts are passed by bootloader in atags and clocks for
these enabled uarts are touched.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e9c367f..b0fa582 100644
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
 
 #include <asm/arch/common.h>
 #include <asm/arch/board.h>
 
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
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= (unsigned long)OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= (unsigned long)OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART3_BASE),
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
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 8ac0307..e015e94 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -34,6 +34,7 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
+extern void omap_serial_enable_clocks(int enable);
 #ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
diff --git a/include/asm-arm/arch-omap/serial.h b/include/asm-arm/arch-omap/serial.h
index 79a5297..b6771b4 100644
--- a/include/asm-arm/arch-omap/serial.h
+++ b/include/asm-arm/arch-omap/serial.h
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
