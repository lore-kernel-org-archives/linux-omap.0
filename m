From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH v2 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access
Date: Fri,  9 Apr 2010 15:31:47 -0500
Message-ID: <1270845107-6236-1-git-send-email-nm@ti.com>
References: <[PM][PATCH 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39554 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab0DIUcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 16:32:18 -0400
In-Reply-To: <[PM][PATCH 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>, Nishanth Menon <nm@ti.com>

From: Deepak K <deepak.k@ti.com>

Original patch:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=42d4a342c009bd9727c100abc8a4bc3063c22f0c

Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):
UART module MDR1 register access can cause a dummy underrun
condition which could result in a freeze in the case of IrDA
communication or if used as UART, corrupted data.

Workaround is as follows for everytime MDR1 register is changed:
* setup all required UART registers
* setup MDR1.MODE_SELECT bit field
* Wait 5 L4 clk cycles + 5 UART functional clock cycles
* Clear the Tx and RX fifo using FCR register

Note: The following step is not done as I am assuming it is not
needed due to reconfiguration being done and there is no halted
operation perse.
* Read if required, the RESUME register to resume halted operation

Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Note: original patch was done for android kernel, ported and sanity
tested
Changes from V1:
 * Added check for LSR to ensure that FIFO is indeed empty.
 * Paranoid check to ensure that we can atleast timeout while waiting
   for FIFO empty.
 * Due to additional code, isolated the errata implementation to a
   function instead of duplicating it.

Ref:
v1: http://marc.info/?t=127074933100005&r=1&w=2

 arch/arm/mach-omap2/serial.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a7c45b5..78091e4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -185,6 +185,41 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 
+/*
+ * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
+ * The access to uart register after MDR1 Access
+ * causes UART to corrupt data.
+ *
+ * Need a delay =
+ * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
+ * give 10 times as much
+ */
+static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
+		u8 fcr_val)
+{
+	struct plat_serial8250_port *p = uart->p;
+	u8 timeout = 255;
+
+	serial_write_reg(p, UART_OMAP_MDR1, mdr1_val);
+	udelay(2);
+	/* Add TX and RX FIFO Clear */
+	serial_write_reg(p, UART_FCR, fcr_val | 0x06);
+	/*
+	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
+	 * TX_FIFO_E bit is 1. So, we check for 0x20 being read.
+	 */
+	while (0x20 != (serial_read_reg(p, UART_LSR) & 0x21)) {
+		timeout--;
+		if (!timeout) {
+			/* Should *never* happen. we warn and carry on */
+			dev_crit(&uart->pdev.dev, "Errata i202: timedout %x\n",
+				serial_read_reg(p, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
@@ -222,7 +257,7 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 
 	uart->context_valid = 0;
 
-	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	omap_uart_mdr1_errataset(uart, 0x07, 0xA0);
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	efr = serial_read_reg(p, UART_EFR);
 	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
@@ -235,14 +270,13 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_IER, uart->ier);
 	serial_write_reg(p, UART_LCR, 0x80);
 	serial_write_reg(p, UART_MCR, uart->mcr);
-	serial_write_reg(p, UART_FCR, 0xA1);
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	serial_write_reg(p, UART_EFR, efr);
 	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
 	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
 	serial_write_reg(p, UART_OMAP_WER, uart->wer);
 	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+	omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
 }
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
-- 
1.6.3.3

