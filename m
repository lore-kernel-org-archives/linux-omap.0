From: "Girish" <girishsg@ti.com>
Subject: [RFC] [PATCH 2/2] high speed uart driver: supporting  header files
Date: Mon, 17 Dec 2007 19:50:00 +0530
Message-ID: <02a501c840b7$e88a9c10$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds supporting declaration and #defines for High speed uart on OMAP 3430.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 include/asm-arm/arch-omap/omap-hsuart.h |  130 ++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h              |    5 +
 2 files changed, 135 insertions(+)

Index: linux-omap-dec10/include/asm-arm/arch-omap/omap-hsuart.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-dec10/include/asm-arm/arch-omap/omap-hsuart.h	2007-12-17 16:56:05.520229665 +0530
@@ -0,0 +1,130 @@
+/*
+ * linux/include/asm-arm/arch-omap2/omap-hsuart.h
+ *
+ * register definitions for omap hsuart controller.
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef __OMAP_HSUART_H__
+#define __OMAP_HSUART_H__
+
+#include <asm/arch/hardware.h>
+
+struct uart_config {
+	int mode;
+	int mdr1;		/* Mode registers */
+	int mdr2;
+	int dll;		/* divisor registers - generates baudrates */
+	int dlh;
+	int mcr;		/* Modem control register */
+	int efr;		/* Enhanced feature register */
+	int scr;		/* Scratchpad register */
+	int tlr;		/* Trigger level register */
+	int fcr;		/* FIFO control register */
+	int ier;		/* interrupt enable register */
+	int lcr;
+	int rxfll;		/* Received frame length register */
+	int rxflh;
+	int txfll;
+	int txflh;
+	int acreg;
+	int eblr;
+};
+
+struct uart_setparm {
+	int lcr;
+	int reg;
+	int reg_data;
+};
+
+struct uart_callback {
+	void (*uart_tx_dma_callback)(int lch, u16 ch_status, void *data);
+	void (*uart_rx_dma_callback)(int lch, u16 ch_status, void *data);
+	int tx_buf_size;
+	int rx_buf_size;
+	/* ISR config */
+	void (*int_callback) (int , void*);
+	char *dev_name;
+	void *dev;
+	int txrx_req_flag;
+};
+
+/* UART numbers */
+#define UART1					0
+#define UART2					1
+#define UART3					2
+#define MAX_UARTS				UART3
+
+
+#define BASE_CLK				(48000000)
+#define DISABLE					0
+#define ENABLE					1
+#define UART_MODE				0
+#define IRDA_MODE				1
+#define UART_AUTOBAUD_MODE			2
+#define CIR_MODE				3
+
+#define IR_SIR_SPEED				115200
+#define IR_MIR_SPEED				1152000
+#define IR_FIR_SPEED				4000000
+#define UART_16X_SPEED				2304000
+#define UART_13X_SPEED				3686400
+
+#define SIP_PULSE				0x40
+#define BOF_1					0x01
+#define BOF_2					0x02
+#define BOF_3					0x03
+/* MDR1 - Defines */
+#define UART_16X_MODE				0x00
+#define UART_SIR_MODE				0x01
+#define UART_16XAUTO_MODE			0x02
+#define UART_13X_MODE				0x03
+#define UART_MIR_MODE				0x04
+#define UART_FIR_MODE				0x05
+#define UART_CIR_MODE				0x06
+#define MODE_SELECT_MASK			~(0x07)
+#define FIFO_SIZE				64
+
+#define TXRX					0
+#define RX_ONLY					1
+#define TX_ONLY					2
+
+/* Function Templates */
+int omap_hsuart_release(u8 uart_no);
+int omap_hsuart_request(u8 uart_no, struct uart_callback*);
+int omap_hsuart_stop(u8 uart_no);
+int omap_hsuart_config(u8 uart_no, struct uart_config *uart_cfg);
+int omap_hsuart_set_speed(u8 uart_no, int speed);
+int omap_hsuart_get_speed(u8 uart_no, int *speed);
+int omap_hsuart_set_parms(u8 uart_no, struct uart_setparm *uart_set);
+int omap_hsuart_get_parms(u8 uart_no, u8 *param, u8 reg, u8 lcr_mode);
+int omap_hsuart_start_rx(u8 uart_no, int size);
+int omap_hsuart_start_tx(u8 uart_no, int size);
+int omap_hsuart_interrupt(u8 uart_no, int enable);
+int omap_hsuart_reset(u8 uart_no);
+int omap_hsuart_stop_tx(u8 uart_no);
+int omap_hsuart_stop_rx(u8 uart_no);
+int omap_hsuart_rx(u8 uart_no, void *data, int *len);
+int omap_hsuart_tx(u8 uart_no, void *data, int size);
+int console_detect(char *str);
+void serial8250_unregister_port(int line);
+
+/* BitField Definitions */
+#define MCR_TCR_TLR				(1 << 7)
+
+/* Library specific defines */
+#define LCR_MODE1				(0<<7)
+#define LCR_MODE2				(1<<7)
+#define LCR_MODE3				(0xbf)
+
+
+#endif				/* End of __OMAP_HSUART_H__ */
Index: linux-omap-dec10/include/linux/serial_reg.h
===================================================================
--- linux-omap-dec10.orig/include/linux/serial_reg.h	2007-12-17 16:52:35.000000000 +0530
+++ linux-omap-dec10/include/linux/serial_reg.h	2007-12-17 16:56:05.520229665 +0530
@@ -324,5 +324,10 @@
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
 
+#define UART_OMAP_RESUME	0x0B	/* Read resumes halted operation */
+#define UART_OMAP_RXFLL		0x0C	/* Received frame length reg low */
+#define UART_OMAP_RXFLH		0x0D	/* Received frame length reg high */
+#define UART_OMAP_ACREG		0x0F	/* Auxiliary control register */
+
 #endif /* _LINUX_SERIAL_REG_H */
