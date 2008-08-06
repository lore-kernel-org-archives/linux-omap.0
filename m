From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 08/11] serial context save/restore
Date: Wed, 6 Aug 2008 18:46:53 +0530 (IST)
Message-ID: <46112.192.168.10.89.1218028613.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:52277 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYHFNRA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:17:00 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DGsqE019053
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:16:59 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DGpEq008899
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:16:53 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the context save restore functions for UART

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/serial.c |   62 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h   |    1
 2 files changed, 63 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c	2008-08-06
18:08:02.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/serial.c	2008-08-06 18:11:15.000000000
+0530
@@ -83,6 +83,16 @@ static const u32 omap34xx_uart_padconf[O
 	CONTROL_PADCONF_UART3_RX
 };

+struct omap_uart_regs {
+	u16 dll;
+	u16 dlh;
+	u16 ier;
+	u16 sysc;
+	u16 scr;
+	u16 wer;
+};
+static struct omap_uart_regs uart_ctx[OMAP_MAX_NR_PORTS];
+
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
@@ -293,6 +303,58 @@ void __init omap_serial_init(void)
 	omap_serial_kick();
 }

+void omap_save_uart_ctx(int unum)
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
+	uart_ctx[unum].dll = serial_read_reg(p, UART_DLL);
+	uart_ctx[unum].dlh = serial_read_reg(p, UART_DLM);
+	serial_write_reg(p, UART_LCR, lcr);
+	uart_ctx[unum].ier = serial_read_reg(p, UART_IER);
+	uart_ctx[unum].sysc = serial_read_reg(p, UART_OMAP_SYSC);
+	uart_ctx[unum].scr = serial_read_reg(p, UART_OMAP_SCR);
+	uart_ctx[unum].wer = serial_read_reg(p, UART_OMAP_WER);
+}
+EXPORT_SYMBOL(omap_save_uart_ctx);
+
+void omap_restore_uart_ctx(int unum)
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
+	serial_write_reg(p, UART_DLL, uart_ctx[unum].dll);
+	serial_write_reg(p, UART_DLM, uart_ctx[unum].dlh);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, uart_ctx[unum].ier);
+	serial_write_reg(p, UART_FCR, 0xA1);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_EFR, efr);
+	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(p, UART_OMAP_SCR, uart_ctx[unum].scr);
+	serial_write_reg(p, UART_OMAP_WER, uart_ctx[unum].wer);
+	serial_write_reg(p, UART_OMAP_SYSC, uart_ctx[unum].sysc);
+	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+}
+EXPORT_SYMBOL(omap_restore_uart_ctx);
+
 static struct platform_device serial_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_PLATFORM,
Index: linux-omap-2.6/include/linux/serial_reg.h
===================================================================
--- linux-omap-2.6.orig/include/linux/serial_reg.h	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/include/linux/serial_reg.h	2008-08-06 18:11:15.000000000 +0530
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER           0x17    /* Wake-up enable register */

 #endif /* _LINUX_SERIAL_REG_H */



