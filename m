From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 1/4] OMAP3: Serial: Add context save and restore for mcr
Date: Thu,  8 Apr 2010 12:54:06 -0500
Message-ID: <1270749249-14041-2-git-send-email-nm@ti.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42615 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932955Ab0DHRyU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 13:54:20 -0400
In-Reply-To: <1270749249-14041-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>, Nishanth Menon <nm@ti.com>

From: Govindraj R <govindraj.raja@ti.com>

Ref:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=c74952c3077e4b19e649b5b48c785c01f73ab9d4

Adds context save/restore for mcr register as state of mcr register
is lost after core off.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Note: Original Patch was done for android kernel, was ported and sanity
tested to l-o pm.  A quick check did not reveal any mcr access in
arch/arm/mach-omap2/serial.c though drivers/serial/8250.c seems to
hit on it a lot, hence posting.

 arch/arm/mach-omap2/serial.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b731556..86d3b47 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -78,6 +78,7 @@ struct omap_uart_state {
 	u16 sysc;
 	u16 scr;
 	u16 wer;
+	u16 mcr;
 #endif
 };
 
@@ -201,6 +202,9 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
 	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
 	uart->wer = serial_read_reg(p, UART_OMAP_WER);
+	serial_write_reg(p, UART_LCR, 0x80);
+	uart->mcr = serial_read_reg(p, UART_MCR);
+	serial_write_reg(p, UART_LCR, lcr);
 
 	uart->context_valid = 1;
 }
@@ -229,6 +233,8 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	serial_write_reg(p, UART_DLM, uart->dlh);
 	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
 	serial_write_reg(p, UART_IER, uart->ier);
+	serial_write_reg(p, UART_LCR, 0x80);
+	serial_write_reg(p, UART_MCR, uart->mcr);
 	serial_write_reg(p, UART_FCR, 0xA1);
 	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
 	serial_write_reg(p, UART_EFR, efr);
-- 
1.6.3.3

