From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 08/11] Serial: OMAP2+: Move erratum handling from serial.c
Date: Wed, 7 Sep 2011 18:23:30 +0530
Message-ID: <1315400013-4849-9-git-send-email-govindraj.raja@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Move the erratum handling mechanism from serial.c to driver file
and utilise the same func in driver file.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |   58 ++++++++++++++++++++++++++++++++++---
 1 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 30bdd05..96fc860 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -52,6 +52,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
 static void serial_omap_rx_timeout(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
+static void omap_uart_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
@@ -805,7 +806,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -830,7 +835,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
 
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	/* Hardware Flow Control Configuration */
 
@@ -1424,9 +1432,47 @@ static int serial_omap_remove(struct platform_device *dev)
 	return 0;
 }
 
+/*
+ * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
+ * The access to uart register after MDR1 Access
+ * causes UART to corrupt data.
+ *
+ * Need a delay =
+ * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
+ * give 10 times as much
+ */
+static void omap_uart_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
+{
+	u8 timeout = 255;
+
+	serial_out(up, UART_OMAP_MDR1, mdr1);
+	udelay(2);
+	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
+			UART_FCR_CLEAR_RCVR);
+	/*
+	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
+	 * TX_FIFO_E bit is 1.
+	 */
+	while (UART_LSR_THRE != (serial_in(up, UART_LSR) &
+				(UART_LSR_THRE | UART_LSR_DR))) {
+		timeout--;
+		if (!timeout) {
+			/* Should *never* happen. we warn and carry on */
+			dev_crit(&up->pdev->dev, "Errata i202: timedout %x\n",
+						serial_in(up, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
 static void omap_uart_restore_context(struct uart_omap_port *up)
 {
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
+	else
+		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
 	serial_out(up, UART_EFR, UART_EFR_ECB);
 	serial_out(up, UART_LCR, 0x0); /* Operational mode */
@@ -1442,8 +1488,10 @@ static void omap_uart_restore_context(struct uart_omap_port *up)
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
-	/* UART 16x mode */
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 }
 
 static int omap_serial_runtime_suspend(struct device *dev)
-- 
1.7.4.1
