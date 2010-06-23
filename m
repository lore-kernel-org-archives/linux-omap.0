From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/5] omap3: serial: Add context save and restore for mcr
Date: Tue, 22 Jun 2010 23:17:50 -0500
Message-ID: <1277266674-5906-2-git-send-email-nm@ti.com>
References: <1277266674-5906-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39076 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab0FWESG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 00:18:06 -0400
In-Reply-To: <1277266674-5906-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Govindraj R <govindraj.raja@ti.com>, Deepak K <deepak.k@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>, Nishanth Menon <nm@ti.com>

From: Govindraj R <govindraj.raja@ti.com>

Ref:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=c74952c3077e4b19e649b5b48c785c01f73ab9d4

Adds context save/restore for mcr register as state of mcr register
is lost after core off.

Cc: Deepak K <deepak.k@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/serial.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3771254..804dbb2 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -74,6 +74,7 @@ struct omap_uart_state {
 	u16 sysc;
 	u16 scr;
 	u16 wer;
+	u16 mcr;
 #endif
 };
 
@@ -197,6 +198,9 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
 	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
 	uart->wer = serial_read_reg(p, UART_OMAP_WER);
+	serial_write_reg(p, UART_LCR, 0x80);
+	uart->mcr = serial_read_reg(p, UART_MCR);
+	serial_write_reg(p, UART_LCR, lcr);
 
 	uart->context_valid = 1;
 }
@@ -225,6 +229,8 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
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

