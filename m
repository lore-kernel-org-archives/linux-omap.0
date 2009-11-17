From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/2] omap: serial: fix non-empty rx uart fifo abort
Date: Tue, 17 Nov 2009 15:17:31 -0600
Message-ID: <1258492651-16002-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39599 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbZKQVR6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 16:17:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org, akpm@linux-foundation.org
Cc: alan@lxorguk.ukuu.org.uk, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.

so pass the flag UPF_NO_EMPTY_FIFO_READ in plat_serial8250_port, so that 8250
driver does not abort on empty rx fifo read

tested on zoom3(3630) board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/serial.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..669652b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -624,8 +624,15 @@ void __init omap_serial_early_init(void)
 		uart->p = p;
 		list_add_tail(&uart->node, &uart_list);
 
-		if (cpu_is_omap44xx())
+		if (cpu_is_omap44xx()) {
 			p->irq += 32;
+			/* Do not read empty UART fifo on omap4 */
+			p->flags |= UPF_NO_EMPTY_FIFO_READ;
+		}
+
+		/* Do not read empty UART fifo on omap3630 */
+		if (cpu_is_omap3630())
+			p->flags |= UPF_NO_EMPTY_FIFO_READ;
 
 		omap_uart_enable_clocks(uart);
 	}
-- 
1.6.5.1.69.g36942

