From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 08/21] OMAP2+: UART: Ensure all reg values configured are available from port structure
Date: Tue, 18 Oct 2011 20:56:03 +0530
Message-ID: <1318951576-10165-9-git-send-email-govindraj.raja@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

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
index 0d87985..192fc8b 100644
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
 
@@ -619,8 +620,6 @@ static inline void
 serial_omap_configure_xonxoff
 		(struct uart_omap_port *up, struct ktermios *termios)
 {
-	unsigned char efr = 0;
-
 	up->lcr = serial_in(up, UART_LCR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	up->efr = serial_in(up, UART_EFR);
@@ -630,8 +629,7 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
 
 	/* clear SW control mode bits */
-	efr = up->efr;
-	efr &= OMAP_UART_SW_CLR;
+	up->efr &= OMAP_UART_SW_CLR;
 
 	/*
 	 * IXON Flag:
@@ -639,7 +637,7 @@ serial_omap_configure_xonxoff
 	 * Transmit XON1, XOFF1
 	 */
 	if (termios->c_iflag & IXON)
-		efr |= OMAP_UART_SW_TX;
+		up->efr |= OMAP_UART_SW_TX;
 
 	/*
 	 * IXOFF Flag:
@@ -647,7 +645,7 @@ serial_omap_configure_xonxoff
 	 * Receiver compares XON1, XOFF1.
 	 */
 	if (termios->c_iflag & IXOFF)
-		efr |= OMAP_UART_SW_RX;
+		up->efr |= OMAP_UART_SW_RX;
 
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
@@ -670,7 +668,7 @@ serial_omap_configure_xonxoff
 	 * load the new software flow control mode IXON or IXOFF
 	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
 	 */
-	serial_out(up, UART_EFR, efr | UART_EFR_SCD);
+	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
@@ -717,6 +715,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	up->dll = quot & 0xff;
+	up->dlh = quot >> 8;
+	up->mdr1 = UART_OMAP_MDR1_DISABLE;
+
 	up->fcr = UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
 			UART_FCR_ENABLE_FIFO;
 	if (up->use_dma)
@@ -770,6 +772,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;
 
 	/* FIFOs and DMA Settings */
 
@@ -796,17 +799,18 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
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
@@ -816,8 +820,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	serial_out(up, UART_DLL, quot & 0xff);          /* LS of divisor */
-	serial_out(up, UART_DLM, quot >> 8);            /* MS of divisor */
+	serial_out(up, UART_DLL, up->dll);	/* LS of divisor */
+	serial_out(up, UART_DLM, up->dlh);	/* MS of divisor */
 
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_IER, up->ier);
@@ -827,9 +831,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
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
 
@@ -1415,15 +1421,18 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
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

