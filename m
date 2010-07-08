From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] omap2/3/4: serial: errata i202: fix for MDR1 access
Date: Thu, 08 Jul 2010 13:08:30 +0300
Message-ID: <20100708100830.19285.92518.stgit@baageli.muru.com>
References: <20100708100715.19285.30066.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64601 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab0GHKId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:08:33 -0400
In-Reply-To: <20100708100715.19285.30066.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Deepak K <deepak.k@ti.com>

From: Deepak K <deepak.k@ti.com>

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

Based on an earlier patch at:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=42d4a342c009bd9727c100abc8a4bc3063c22f0c

Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   52 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 009b63f..566e991 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -38,6 +38,7 @@
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #define UART_ERRATA_FIFO_FULL_ABORT	(0x1 << 0)
+#define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
 
 /*
  * NOTE: By default the serial timeout is disabled as it causes lost characters
@@ -184,6 +185,42 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 
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
+	serial_write_reg(p, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
+			UART_FCR_CLEAR_RCVR);
+	/*
+	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
+	 * TX_FIFO_E bit is 1.
+	 */
+	while (UART_LSR_THRE != (serial_read_reg(p, UART_LSR) &
+				(UART_LSR_THRE | UART_LSR_DR))) {
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
@@ -221,7 +258,10 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 
 	uart->context_valid = 0;
 
-	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(uart, 0x07, 0xA0);
+	else
+		serial_write_reg(p, UART_OMAP_MDR1, 0x7);
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	efr = serial_read_reg(p, UART_EFR);
 	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
@@ -234,14 +274,16 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
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
+	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
+	else
+		serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
 }
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
@@ -769,6 +811,10 @@ void __init omap_serial_init_port(int port)
 		uart->p->serial_in = serial_in_override;
 		uart->p->serial_out = serial_out_override;
 	}
+
+	/* Enable the MDR1 errata for OMAP3 */
+	if (cpu_is_omap34xx())
+		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
 /**

