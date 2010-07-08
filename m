From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] omap2/3/4: serial: introduce errata handling
Date: Thu, 08 Jul 2010 13:08:26 +0300
Message-ID: <20100708100826.19285.19808.stgit@baageli.muru.com>
References: <20100708100715.19285.30066.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63078 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab0GHKI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:08:29 -0400
In-Reply-To: <20100708100715.19285.30066.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

introduce silicon specific quirks as a errata handling mechanism

as a start UART_ERRATA_FIFO_FULL_ABORT is used to handle the override
for fifo full condition for rx and tx.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 584a2ed..009b63f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -37,6 +37,8 @@
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
+#define UART_ERRATA_FIFO_FULL_ABORT	(0x1 << 0)
+
 /*
  * NOTE: By default the serial timeout is disabled as it causes lost characters
  * over the serial ports. This means that the UART clocks will stay on until
@@ -64,6 +66,7 @@ struct omap_uart_state {
 	struct list_head node;
 	struct platform_device pdev;
 
+	u32 errata;
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 	int context_valid;
 
@@ -756,11 +759,13 @@ void __init omap_serial_init_port(int port)
 	 * omap3xxx: Never read empty UART fifo on UARTs
 	 * with IP rev >=0x52
 	 */
-	if (cpu_is_omap44xx()) {
-		uart->p->serial_in = serial_in_override;
-		uart->p->serial_out = serial_out_override;
-	} else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV) {
+	if (cpu_is_omap44xx())
+		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
+	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
+
+	if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
 		uart->p->serial_in = serial_in_override;
 		uart->p->serial_out = serial_out_override;
 	}

