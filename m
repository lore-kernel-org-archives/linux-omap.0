From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] omap3: serial: Add context save and restore for mcr
Date: Thu, 08 Jul 2010 13:08:12 +0300
Message-ID: <20100708100812.19285.48402.stgit@baageli.muru.com>
References: <20100708100715.19285.30066.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64312 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab0GHKIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:08:17 -0400
In-Reply-To: <20100708100715.19285.30066.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Govindraj R <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

From: Govindraj R <govindraj.raja@ti.com>

Adds context save/restore for mcr register as state of mcr register
is lost after core off.

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

