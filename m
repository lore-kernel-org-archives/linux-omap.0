From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP3: PM: UART save/restore support for OFF-mode
Date: Wed, 26 Nov 2008 16:30:00 -0800
Message-ID: <1227745800-5894-4-git-send-email-khilman@deeprootsystems.com>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
 <1227745800-5894-2-git-send-email-khilman@deeprootsystems.com>
 <1227745800-5894-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:45335 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYK0AaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:30:13 -0500
Received: by mail-qy0-f11.google.com with SMTP id 4so1010021qyk.13
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:30:13 -0800 (PST)
In-Reply-To: <1227745800-5894-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

If OFF-mode is enabled, each enabled UART will save its
context whenever clocks are disabled and restore it when
clocks are re-enabled.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   77 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h   |    1 +
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index f93dc52..dd32047 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -50,6 +50,18 @@ struct omap_uart_state {
 
 	struct plat_serial8250_port *p;
 	struct list_head node;
+
+#ifdef CONFIG_ARCH_OMAP3
+	int context_valid;
+
+	/* Registers to be saved/restored for OFF-mode */
+	u16 dll;
+	u16 dlh;
+	u16 ier;
+	u16 sysc;
+	u16 scr;
+	u16 wer;
+#endif
 };
 
 static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS];
@@ -114,6 +126,69 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+/* to be replaced by global with forthcoming OFF-mode patches */
+static int enable_off_mode;
+
+static void omap_uart_save_context(struct omap_uart_state *uart)
+{
+	u16 lcr = 0;
+	struct plat_serial8250_port *p = uart->p;
+
+	if (!enable_off_mode)
+		return;
+
+	lcr = serial_read_reg(p, UART_LCR);
+	serial_write_reg(p, UART_LCR, 0xBF);
+	uart->dll = serial_read_reg(p, UART_DLL);
+	uart->dlh = serial_read_reg(p, UART_DLM);
+	serial_write_reg(p, UART_LCR, lcr);
+	uart->ier = serial_read_reg(p, UART_IER);
+	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
+	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
+	uart->wer = serial_read_reg(p, UART_OMAP_WER);
+
+	uart->context_valid = 1;
+}
+
+static void omap_uart_restore_context(struct omap_uart_state *uart)
+{
+	u16 efr = 0;
+	struct plat_serial8250_port *p = uart->p;
+
+	if (!enable_off_mode)
+		return;
+
+	if (!uart->context_valid)
+		return;
+
+	uart->context_valid = 0;
+
+	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_read_reg(p, UART_EFR);
+	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, 0x0);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_DLL, uart->dll);
+	serial_write_reg(p, UART_DLM, uart->dlh);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, uart->ier);
+	serial_write_reg(p, UART_FCR, 0xA1);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_EFR, efr);
+	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
+	serial_write_reg(p, UART_OMAP_WER, uart->wer);
+	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
+	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+}
+#else
+static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
+static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
+#endif /* CONFIG_ARCH_OMAP3 */
+
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					  int enable)
 {
@@ -137,6 +212,7 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	clk_enable(uart->ick);
 	clk_enable(uart->fck);
 	uart->clocked = 1;
+	omap_uart_restore_context(uart);
 }
 
 static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
@@ -144,6 +220,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
+	omap_uart_save_context(uart);
 	uart->clocked = 0;
 	clk_disable(uart->ick);
 	clk_disable(uart->fck);
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..850db2e 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.6.0.3

