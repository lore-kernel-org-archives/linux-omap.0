From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/16] OMAP3: Serial context save/restore
Date: Fri, 26 Sep 2008 17:47:40 +0530
Message-ID: <01f401c91fd1$df21a5c0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYIZMRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:17:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the context save restore functions for UART

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/serial.c             |   65 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/serial.h |    4 +
 include/linux/serial_reg.h               |    1 
 3 files changed, 70 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c	2008-09-25 16:27:11.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/serial.c	2008-09-25 16:27:13.000000000 +0530
@@ -68,6 +68,17 @@ static const u32 omap3_uart_wk_bit[OMAP_
 	OMAP3430_ST_UART2,
 	OMAP3430_ST_UART3,
 };
+
+struct omap3_uart_regs {
+	u16 dll;
+	u16 dlh;
+	u16 ier;
+	u16 sysc;
+	u16 scr;
+	u16 wer;
+};
+
+static struct omap3_uart_regs uart_context[OMAP_MAX_NR_PORTS];
 #endif
 
 static const u32 *omap_uart_wk_st;
@@ -315,6 +326,60 @@ static ssize_t awake_store(struct kobjec
 	return n;
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+void omap3_uart_save_context(int unum)
+{
+	u16 lcr = 0;
+
+	struct plat_serial8250_port *p = serial_platform_data + unum;
+
+	if (uart_ick[unum] == NULL)
+		return;
+
+	lcr = serial_read_reg(p, UART_LCR);
+	serial_write_reg(p, UART_LCR, 0xBF);
+	uart_context[unum].dll = serial_read_reg(p, UART_DLL);
+	uart_context[unum].dlh = serial_read_reg(p, UART_DLM);
+	serial_write_reg(p, UART_LCR, lcr);
+	uart_context[unum].ier = serial_read_reg(p, UART_IER);
+	uart_context[unum].sysc = serial_read_reg(p, UART_OMAP_SYSC);
+	uart_context[unum].scr = serial_read_reg(p, UART_OMAP_SCR);
+	uart_context[unum].wer = serial_read_reg(p, UART_OMAP_WER);
+}
+EXPORT_SYMBOL(omap3_uart_save_context);
+
+void omap3_uart_restore_context(int unum)
+{
+	u16 efr = 0;
+
+	struct plat_serial8250_port *p = serial_platform_data + unum;
+
+	if (uart_ick[unum] == NULL)
+		return;
+
+	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_read_reg(p, UART_EFR);
+	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, 0x0);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_DLL, uart_context[unum].dll);
+	serial_write_reg(p, UART_DLM, uart_context[unum].dlh);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, uart_context[unum].ier);
+	serial_write_reg(p, UART_FCR, 0xA1);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_EFR, efr);
+	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(p, UART_OMAP_SCR, uart_context[unum].scr);
+	serial_write_reg(p, UART_OMAP_WER, uart_context[unum].wer);
+	serial_write_reg(p, UART_OMAP_SYSC, uart_context[unum].sysc);
+	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+}
+EXPORT_SYMBOL(omap3_uart_restore_context);
+#endif /* CONFIG_ARCH_OMAP3 */
+
 static struct platform_device serial_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_PLATFORM,
Index: linux-omap-2.6/include/linux/serial_reg.h
===================================================================
--- linux-omap-2.6.orig/include/linux/serial_reg.h	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/include/linux/serial_reg.h	2008-09-25 16:27:13.000000000 +0530
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #endif /* _LINUX_SERIAL_REG_H */
 
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/serial.h	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h	2008-09-25 16:27:13.000000000 +0530
@@ -40,4 +40,8 @@
 			__ret;						\
 			})
 
+#ifndef __ASSEMBLY__
+extern void omap3_uart_save_context(int unum);
+extern void omap3_uart_restore_context(int unum);
+#endif /* __ASSEMBLY__ */
 #endif

