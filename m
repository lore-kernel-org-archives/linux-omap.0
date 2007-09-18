From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Cleanup OMAP24XX serial code
Date: Tue, 18 Sep 2007 11:25:34 +0900
Message-ID: <20070918022534.GA18073@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Define the OMAP24XX_BASE_BAUD.
Remove one-line curly brace.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e9c367f..c9697a4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -38,7 +38,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.membase	= (char *)IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= (unsigned long)OMAP_UART2_BASE,
@@ -46,7 +46,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.membase	= (char *)IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= (unsigned long)OMAP_UART3_BASE,
@@ -54,7 +54,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 		.flags		= 0
 	}
@@ -87,7 +87,7 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
-void __init omap_serial_init()
+void __init omap_serial_init(void)
 {
 	int i;
 	const struct omap_uart_config *info;
@@ -98,8 +98,7 @@ void __init omap_serial_init()
 	 * if not needed.
 	 */
 
-	info = omap_get_config(OMAP_TAG_UART,
-			       struct omap_uart_config);
+	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
 
 	if (info == NULL)
 		return;
@@ -118,46 +117,40 @@ void __init omap_serial_init()
 			uart1_ick = clk_get(NULL, "uart1_ick");
 			if (IS_ERR(uart1_ick))
 				printk("Could not get uart1_ick\n");
-			else {
+			else
 				clk_enable(uart1_ick);
-			}
 
 			uart1_fck = clk_get(NULL, "uart1_fck");
 			if (IS_ERR(uart1_fck))
 				printk("Could not get uart1_fck\n");
-			else {
+			else
 				clk_enable(uart1_fck);
-			}
 			break;
 		case 1:
 			uart2_ick = clk_get(NULL, "uart2_ick");
 			if (IS_ERR(uart2_ick))
 				printk("Could not get uart2_ick\n");
-			else {
+			else
 				clk_enable(uart2_ick);
-			}
 
 			uart2_fck = clk_get(NULL, "uart2_fck");
 			if (IS_ERR(uart2_fck))
 				printk("Could not get uart2_fck\n");
-			else {
+			else
 				clk_enable(uart2_fck);
-			}
 			break;
 		case 2:
 			uart3_ick = clk_get(NULL, "uart3_ick");
 			if (IS_ERR(uart3_ick))
 				printk("Could not get uart3_ick\n");
-			else {
+			else
 				clk_enable(uart3_ick);
-			}
 
 			uart3_fck = clk_get(NULL, "uart3_fck");
 			if (IS_ERR(uart3_fck))
 				printk("Could not get uart3_fck\n");
-			else {
+			else
 				clk_enable(uart3_fck);
-			}
 			break;
 		}
 
diff --git a/include/asm-arm/arch-omap/serial.h b/include/asm-arm/arch-omap/serial.h
index f1bd9d1..b6771b4 100644
--- a/include/asm-arm/arch-omap/serial.h
+++ b/include/asm-arm/arch-omap/serial.h
@@ -30,6 +30,7 @@
 #define OMAP_MAX_NR_PORTS	3
 #define OMAP1510_BASE_BAUD	(12000000/16)
 #define OMAP16XX_BASE_BAUD	(48000000/16)
+#define OMAP24XX_BASE_BAUD	(48000000/16)
 
 #define is_omap_port(p)	({int __ret = 0;			\
 			if (p == IO_ADDRESS(OMAP_UART1_BASE) ||	\
