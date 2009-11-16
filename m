From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/2] omap: serial: fix non-empty rx uart fifo abort
Date: Mon, 16 Nov 2009 16:53:56 -0600
Message-ID: <1258412036-31986-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931AbZKPWyJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 17:54:09 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAGMsFO1020741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 16:54:15 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Empty uart rx fifo read can cause omap to abort
OMAP silicon affected: OMAP3630, OMAP4430
OMAP silicon not-affected: omap1/2/3

So pass flag UPF_NO_EMPTY_FIFO_READ in plat_serial8250_port, so that 8250
driver does not abort on empty rx fifo read

Tested on zoom3(3630) board

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

