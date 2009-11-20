From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3 2/2] omap: serial: fix non-empty uart fifo read abort
Date: Fri, 20 Nov 2009 10:02:36 -0600
Message-ID: <1258732956-18799-3-git-send-email-vikram.pandita@ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
 <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38744 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160AbZKTQCl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 11:02:41 -0500
In-Reply-To: <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.

Override the default 8250 read handler: mem_serial_in()
by a custom handler: serial_in_8250()

serial_in_8250() makes sure that RX fifo is not read when empty,
on omap4 and 3630 silicons only

tested on zoom3(3630) board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 arch/arm/mach-omap2/serial.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..600e4d2 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -572,6 +572,23 @@ static struct omap_uart_state omap_uart[] = {
 #endif
 };
 
+/*
+ * Override the default 8250 read handler: mem_serial_in()
+ * Empty RX fifo read causes an abort on omap3630 and omap4
+ * This function makes sure that an empty rx fifo is not read on these silicons
+ * (OMAP1/2/3 are not affected)
+ */
+static unsigned int serial_in_override(struct uart_port *up, int offset)
+{
+	if (UART_RX == offset) {
+		unsigned int lsr;
+		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
+		if (!(lsr & UART_LSR_DR))
+			return -EPERM;
+	}
+	return serial_read_reg(omap_uart[up->line].p, offset);
+}
+
 void __init omap_serial_early_init(void)
 {
 	int i;
@@ -627,6 +644,10 @@ void __init omap_serial_early_init(void)
 		if (cpu_is_omap44xx())
 			p->irq += 32;
 
+		/* Do not read empty UART fifo on omap3630/omap4 */
+		if (omap3_has_uart_no_empty_fifo_read())
+			p->serial_in = serial_in_override;
+
 		omap_uart_enable_clocks(uart);
 	}
 }
-- 
1.6.5.1.69.g36942

