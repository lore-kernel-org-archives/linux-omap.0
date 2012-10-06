From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 24/24] SERIAL: omap: remove OMAP_UART_SYSC_RESET and
 OMAP_UART_FIFO_CLR
Date: Sat, 06 Oct 2012 13:47:08 +0100
Message-ID: <E1TKTme-0002nz-5E@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47355 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2JFMrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:47:15 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

OMAP_UART_SYSC_RESET and OMAP_UART_FIFO_CLR are unused, remove them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index bad00f1..da2e51f 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -32,9 +32,6 @@
  */
 #define OMAP_SERIAL_NAME	"ttyO"
 
-#define OMAP_UART_SYSC_RESET	0X07
-#define OMAP_UART_FIFO_CLR	0X06
-
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
-- 
1.7.4.4

