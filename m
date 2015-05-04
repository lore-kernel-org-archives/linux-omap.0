From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP1: Move UART defines to prepare for sparse IRQ
Date: Mon,  4 May 2015 12:52:19 -0700
Message-ID: <1430769142-3921-2-git-send-email-tony@atomide.com>
References: <1430769142-3921-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ar-005-i191.relay.mailchannels.net ([162.253.144.73]:42769 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750943AbbEDTwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 15:52:43 -0400
In-Reply-To: <1430769142-3921-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

These have been indirectly included via asm/irqs.h that
has included mach/hardware.h unless SPARSE_IRQ is specified.
Let's move them to where the other OMAP serial defines for
8250 are.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/serial.h | 5 -----
 include/uapi/linux/serial_reg.h           | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/serial.h b/arch/arm/mach-omap1/include/mach/serial.h
index 2ce6a2d..4700e38 100644
--- a/arch/arm/mach-omap1/include/mach/serial.h
+++ b/arch/arm/mach-omap1/include/mach/serial.h
@@ -27,11 +27,6 @@
  */
 #define OMAP_UART_INFO_OFS	0x3ffc
 
-/* OMAP1 serial ports */
-#define OMAP1_UART1_BASE	0xfffb0000
-#define OMAP1_UART2_BASE	0xfffb0800
-#define OMAP1_UART3_BASE	0xfffb9800
-
 #define OMAP_PORT_SHIFT		2
 #define OMAP7XX_PORT_SHIFT	0
 
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index e9b4cb0..1e5ac4e7 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -331,6 +331,9 @@
  * Extra serial register definitions for the internal UARTs
  * in TI OMAP processors.
  */
+#define OMAP1_UART1_BASE	0xfffb0000
+#define OMAP1_UART2_BASE	0xfffb0800
+#define OMAP1_UART3_BASE	0xfffb9800
 #define UART_OMAP_MDR1		0x08	/* Mode definition register */
 #define UART_OMAP_MDR2		0x09	/* Mode definition register 2 */
 #define UART_OMAP_SCR		0x10	/* Supplementary control register */
-- 
2.1.4

