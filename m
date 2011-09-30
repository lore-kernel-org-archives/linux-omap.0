From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 08/16] OMAP2+: UART: Store certain reg values to port structure
Date: Fri, 30 Sep 2011 16:31:34 +0530
Message-ID: <1317380495-584-8-git-send-email-govindraj.raja@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757610Ab1I3LBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 07:01:54 -0400
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

In preparation to runtime conversion add missing uart regs to
port structure which can be used in context restore.
Also ensuring all uart reg info's are part of port structure.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ++
 drivers/tty/serial/omap-serial.c              |   33 ++++++++++++++----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 0f061b4..74822b3 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -99,6 +99,9 @@ struct uart_omap_port {
 	unsigned char		mcr;
 	unsigned char		fcr;
 	unsigned char		efr;
+	unsigned char		dll;
+	unsigned char		dlh;
+	unsigned char		mdr1;
 
 	int			use_dma;
 	/*
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6c2ea54..9a0eac2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -433,8 +433,9 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		mcr |= UART_MCR_LOOP;
 
-	mcr |= up->mcr;
-	serial_out(up, UART_MCR, mcr);
+	up->mcr = serial_in(up, UART_MCR);
+	up->mcr |= mcr;
+	serial_out(up, UART_MCR, up->mcr);
 }
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
@@ -573,8 +574,6 @@ static inline void
 serial_omap_configure_xonxoff
 		(struct uart_omap_port *up, struct ktermios *termios)
 {
-	unsigned char efr = 0;
-
 	up->lcr = serial_in(up, UART_LCR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	up->efr = serial_in(up, UART_EFR);
@@ -584,8 +583,7 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
 
 	/* clear SW control mode bits */
-	efr = up->efr;
-	efr &= OMAP_UART_SW_CLR;
+	up->efr &= OMAP_UART_SW_CLR;
 
 	/*
 	 * IXON Flag:
@@ -593,7 +591,7 @@ serial_omap_configure_xonxoff
 	 * Transmit XON1, XOFF1
 	 */
 	if (termios->c_iflag & IXON)
-		efr |= OMAP_UART_SW_TX;
+		up->efr |= OMAP_UART_SW_TX;
 
 	/*
 	 * IXOFF Flag:
@@ -601,7 +599,7 @@ serial_omap_configure_xonxoff
 	 * Receiver compares XON1, XOFF1.
 	 */
 	if (termios->c_iflag & IXOFF)
-		efr |= OMAP_UART_SW_RX;
+		up->efr |= OMAP_UART_SW_RX;
 
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
@@ -624,7 +622,7 @@ serial_omap_configure_xonxoff
 	 * load the new software flow control mode IXON or IXOFF
 	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
 	 */
-	serial_out(up, UART_EFR, efr | UART_EFR_SCD);
+	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
@@ -671,6 +669,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	up->dll = quot & 0xff;
+	up->dlh = quot >> 8;
+	up->mdr1 = UART_OMAP_MDR1_DISABLE;
+
 	up->fcr = UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
 			UART_FCR_ENABLE_FIFO;
 	if (up->use_dma)
@@ -723,6 +725,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;
 
 	/* FIFOs and DMA Settings */
 
@@ -759,7 +762,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -769,8 +772,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	serial_out(up, UART_DLL, quot & 0xff);          /* LS of divisor */
-	serial_out(up, UART_DLM, quot >> 8);            /* MS of divisor */
+	serial_out(up, UART_DLL, up->dll);	/* LS of divisor */
+	serial_out(up, UART_DLM, up->dlh);	/* MS of divisor */
 
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_IER, up->ier);
@@ -780,9 +783,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, cval);
 
 	if (baud > 230400 && baud != 3000000)
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_13X_MODE);
+		up->mdr1 = UART_OMAP_MDR1_13X_MODE;
 	else
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
+		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
+
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	/* Hardware Flow Control Configuration */
 
-- 
1.7.4.1

