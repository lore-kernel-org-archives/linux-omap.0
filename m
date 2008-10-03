From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/07] ARM: OMAP2 Provide function to enable/disable uart clocks
Date: Fri,  3 Oct 2008 14:56:43 +0300
Message-ID: <1223035009-23866-2-git-send-email-tony@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62816 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYJCLyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:54:03 -0400
In-Reply-To: <1223035009-23866-1-git-send-email-tony@atomide.com>
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
index 0cbe452..4dcf39c 100644
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
@@ -22,12 +22,8 @@
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
@@ -37,7 +33,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
@@ -45,7 +41,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
@@ -53,7 +49,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.flags		= 0
 	}
@@ -86,10 +82,27 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
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
@@ -97,8 +110,7 @@ void __init omap_serial_init()
 	 * if not needed.
 	 */
 
-	info = omap_get_config(OMAP_TAG_UART,
-			       struct omap_uart_config);
+	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
 
 	if (info == NULL)
 		return;
@@ -112,53 +124,21 @@ void __init omap_serial_init()
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
index 515b89b..8a676a0 100644
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
 
 #define is_omap_port(pt)	({int __ret = 0;			\
 			if ((pt)->port.mapbase == OMAP_UART1_BASE ||	\
