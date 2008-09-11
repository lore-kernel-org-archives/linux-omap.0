From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/29] serial context save/restore
Date: Thu, 11 Sep 2008 15:33:55 +0300
Message-ID: <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43058 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbYIKMed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:33 -0400
In-Reply-To: <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the context save restore functions for UART
---
 arch/arm/mach-omap2/serial.c |   62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h   |    1 +
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 281c1c7..879d7c1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -83,6 +83,16 @@ static const u32 omap34xx_uart_padconf[OMAP_MAX_NR_PORTS] = {
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
 		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
@@ -314,6 +324,58 @@ static ssize_t awake_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
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
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..76ffd3c 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER           0x17    /* Wake-up enable register */
 
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.6.0

