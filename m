From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
Date: Tue, 1 Sep 2009 20:19:04 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9AF18CF@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F9A4570A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48765 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbZIAOtL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 10:49:11 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n81En71c031906
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 09:49:13 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A4570A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Govindraj

>From: Govindraj R <govindraj.raja@ti.com>
>
>This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>
>It currently adds support for the following features.
>
>        1. Supports Interrupt Mode for all three UARTs on SDP/ZOOM2.
>        2. Supports DMA Mode for all three UARTs on SDP/ZOOM2.
>        3. Supports Hardware flow control (CTS/RTS) on SDP/ZOOM2.
>        4. Supports 3.6Mbps baudrate on SDP/ZOOM2.
>        5. Debug Console support on all UARTs on SDP/ZOOM2.
>        6. Support for quad uart on ZOOM2 board.

What about UART3 supporting IRDA and CIR modes?
Is that planned to be added?
 

>
>+
>+static unsigned int check_modem_status(struct uart_omap_port *up)

What is the use case for modem_status? 


>+{
>+
>+/*
>+ * This handles the interrupt from one port.
>+ */
>+static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
>+{
>+	struct uart_omap_port *up = dev_id;
>+	unsigned int iir, lsr;
>+
>+	iir = serial_in(up, UART_IIR);
>+	if (iir & UART_IIR_NO_INT)
>+		return IRQ_NONE;
>+	lsr = serial_in(up, UART_LSR);
>+	if ((iir & 0x4) && up->use_dma) {
>+		up->ier &= ~UART_IER_RDI;
>+		serial_out(up, UART_IER, up->ier);
>+		serial_omap_start_rxdma(up);
>+	} else if (lsr & UART_LSR_DR)
>+		receive_chars(up, &lsr);
>+	check_modem_status(up);
>+	if ((lsr & UART_LSR_THRE) && (iir & 0x2))
>+		transmit_chars(up);
>+	up_activity = jiffies;
>+
>+	return IRQ_HANDLED;
>+}
>+

Query: 
>+static void serial_omap_rx_timeout(unsigned long uart_no)
>+{
>+	struct uart_omap_port *up = ui[uart_no - 1];
>+	unsigned int curr_dma_pos;
>+	curr_dma_pos = omap_readl(OMAP34XX_DMA4_BASE +
>+				  OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
>+	if ((curr_dma_pos == up->uart_dma.prev_rx_dma_pos) ||
>+			     (curr_dma_pos == 0)) {
>+		if (jiffies_to_msecs(jiffies - up_activity) < 10000) {
>+			mod_timer(&up->uart_dma.rx_timer, jiffies +
>+				usecs_to_jiffies(up->uart_dma.rx_timeout));

Is this a 10 second timeout? Is this acceptable way?
This has to be done in conjunction with the inactivity timer in mach-omap2/serial.c

>+		} else {
>+			serial_omap_stop_rxdma(up);
>+			up->ier |= UART_IER_RDI;
>+			serial_out(up, UART_IER, up->ier);
>+		}
>+
>+		return;
>+	} else {
>+		unsigned int curr_transmitted_size = curr_dma_pos -
>+						up->uart_dma.prev_rx_dma_pos;
>+		up->port.icount.rx += curr_transmitted_size;
>+		tty_insert_flip_string(up->port.info->port.tty,
>+				up->uart_dma.rx_buf +
>+				(up->uart_dma.prev_rx_dma_pos -
>+				up->uart_dma.rx_buf_dma_phys),
>+				curr_transmitted_size);
>+		tty_flip_buffer_push(up->port.info->port.tty);
>+		up->uart_dma.prev_rx_dma_pos = curr_dma_pos;
>+		if (up->uart_dma.rx_buf_size +
>+				up->uart_dma.rx_buf_dma_phys == curr_dma_pos)
>+			serial_omap_start_rxdma(up);
>+		else
>+			mod_timer(&up->uart_dma.rx_timer, jiffies +
>+				usecs_to_jiffies(up->uart_dma.rx_timeout));
>+		up_activity = jiffies;
>+
>+	}


