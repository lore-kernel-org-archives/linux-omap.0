From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 08/20] OMAP2+: UART: Ensure all reg values configured are available from port structure
Date: Fri, 11 Nov 2011 15:27:25 +0530
Message-ID: <1321005446-21741-9-git-send-email-govindraj.raja@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44413 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab1KKJ6l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 04:58:41 -0500
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Add missing uart regs to uart_port structure which can be used in
context restore. Store dll, dlh, mdr1, scr, efr, lcr, mcr reg values
into uart_port structure while configuring individual port in termios
function.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    4 ++
 drivers/tty/serial/omap-serial.c              |   43 +++++++++++++++----------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index db9bda9..70e7738 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -97,6 +97,10 @@ struct uart_omap_port {
 	unsigned char		mcr;
 	unsigned char		fcr;
 	unsigned char		efr;
+	unsigned char		dll;
+	unsigned char		dlh;
+	unsigned char		mdr1;
+	unsigned char		scr;
 
 	int			use_dma;
 	/*
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a834e91..5327ff0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -466,8 +466,9 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	pm_runtime_get_sync(&up->pdev->dev);
-	mcr |= up->mcr;
-	serial_out(up, UART_MCR, mcr);
+	up->mcr = serial_in(up, UART_MCR);
+	up->mcr |= mcr;
+	serial_out(up, UART_MCR, up->mcr);
 	pm_runtime_put(&up->pdev->dev);
 }
 
@@ -616,8 +617,6 @@ static inline void
 serial_omap_configure_xonxoff
 		(struct uart_omap_port *up, struct ktermios *termios)
 {
-	unsigned char efr = 0;
-
 	up->lcr = serial_in(up, UART_LCR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	up->efr = serial_in(up, UART_EFR);
@@ -627,8 +626,7 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
 
 	/* clear SW control mode bits */
-	efr = up->efr;
-	efr &= OMAP_UART_SW_CLR;
+	up->efr &= OMAP_UART_SW_CLR;
 
 	/*
 	 * IXON Flag:
@@ -636,7 +634,7 @@ serial_omap_configure_xonxoff
 	 * Transmit XON1, XOFF1
 	 */
 	if (termios->c_iflag & IXON)
-		efr |= OMAP_UART_SW_TX;
+		up->efr |= OMAP_UART_SW_TX;
 
 	/*
 	 * IXOFF Flag:
@@ -644,7 +642,7 @@ serial_omap_configure_xonxoff
 	 * Receiver compares XON1, XOFF1.
 	 */
 	if (termios->c_iflag & IXOFF)
-		efr |= OMAP_UART_SW_RX;
+		up->efr |= OMAP_UART_SW_RX;
 
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
@@ -667,7 +665,7 @@ serial_omap_configure_xonxoff
 	 * load the new software flow control mode IXON or IXOFF
 	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
 	 */
-	serial_out(up, UART_EFR, efr | UART_EFR_SCD);
+	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
@@ -714,6 +712,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	up->dll = quot & 0xff;
+	up->dlh = quot >> 8;
+	up->mdr1 = UART_OMAP_MDR1_DISABLE;
+
 	up->fcr = UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
 			UART_FCR_ENABLE_FIFO;
 	if (up->use_dma)
@@ -767,6 +769,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;
 
 	/* FIFOs and DMA Settings */
 
@@ -793,17 +796,18 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (up->use_dma) {
 		serial_out(up, UART_TI752_TLR, 0);
-		serial_out(up, UART_OMAP_SCR,
-			(UART_FCR_TRIGGER_4 | UART_FCR_TRIGGER_8));
+		up->scr |= (UART_FCR_TRIGGER_4 | UART_FCR_TRIGGER_8);
 	}
 
+	serial_out(up, UART_OMAP_SCR, up->scr);
+
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -813,8 +817,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	serial_out(up, UART_DLL, quot & 0xff);          /* LS of divisor */
-	serial_out(up, UART_DLM, quot >> 8);            /* MS of divisor */
+	serial_out(up, UART_DLL, up->dll);	/* LS of divisor */
+	serial_out(up, UART_DLM, up->dlh);	/* MS of divisor */
 
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_IER, up->ier);
@@ -824,9 +828,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
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
 
@@ -1416,15 +1422,18 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
 	serial_out(up, UART_LCR, 0x0); /* Operational mode */
 	serial_out(up, UART_IER, 0x0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_DLL, up->dll);
+	serial_out(up, UART_DLM, up->dlh);
 	serial_out(up, UART_LCR, 0x0); /* Operational mode */
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_FCR, up->fcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_OMAP_SCR, up->scr);
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
 }
 
 #ifdef CONFIG_PM_RUNTIME
-- 
1.7.4.1

