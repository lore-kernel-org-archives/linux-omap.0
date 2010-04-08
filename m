From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access
Date: Thu,  8 Apr 2010 12:54:07 -0500
Message-ID: <1270749249-14041-3-git-send-email-nm@ti.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
 <1270749249-14041-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45733 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932955Ab0DHRyX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 13:54:23 -0400
In-Reply-To: <1270749249-14041-2-git-send-email-nm@ti.com>
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

 arch/arm/mach-omap2/serial.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 86d3b47..144033f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -223,6 +223,19 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	uart->context_valid = 0;
 
 	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	/*
+	 * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
+	 * The access to uart register after MDR1 Access
+	 * causes UART to corrupt data.
+	 *
+	 * Need a delay =
+	 * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
+	 * give 10 times as much
+	 */
+	udelay(2);
+	/* TX and RX FIFO Clear; FIFO dis */
+	serial_write_reg(p, UART_FCR, 0xA6);
+
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	efr = serial_read_reg(p, UART_EFR);
 	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
@@ -235,7 +248,6 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_IER, uart->ier);
 	serial_write_reg(p, UART_LCR, 0x80);
 	serial_write_reg(p, UART_MCR, uart->mcr);
-	serial_write_reg(p, UART_FCR, 0xA1);
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	serial_write_reg(p, UART_EFR, efr);
 	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
@@ -243,6 +255,10 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_OMAP_WER, uart->wer);
 	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
 	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+	/* Errata: i202 */
+	udelay(2);
+	/* TX and RX FIFO Clear; FIFO en */
+	serial_write_reg(p, UART_FCR, 0xA7);
 }
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
-- 
1.6.3.3

