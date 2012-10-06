From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 23/24] SERIAL: omap: move driver private definitions and
 structures to driver
Date: Sat, 06 Oct 2012 13:46:48 +0100
Message-ID: <E1TKTmK-0002nu-1Q@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

struct uart_omap_port and struct uart_omap_dma, and associated
definitions are private to the driver, so there's no point them sitting
in an include file under arch/arm.  Move them into the driver itself.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |   87 ------------------------
 drivers/tty/serial/omap-serial.c              |   88 +++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 87 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 6403441..bad00f1 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -32,35 +32,9 @@
  */
 #define OMAP_SERIAL_NAME	"ttyO"
 
-#define OMAP_MODE13X_SPEED	230400
-
-#define OMAP_UART_SCR_TX_EMPTY	0x08
-
-/* WER = 0x7F
- * Enable module level wakeup in WER reg
- */
-#define OMAP_UART_WER_MOD_WKUP	0X7F
-
-/* Enable XON/XOFF flow control on output */
-#define OMAP_UART_SW_TX		0x08
-
-/* Enable XON/XOFF flow control on input */
-#define OMAP_UART_SW_RX		0x02
-
 #define OMAP_UART_SYSC_RESET	0X07
-#define OMAP_UART_TCR_TRIG	0X0F
-#define OMAP_UART_SW_CLR	0XF0
 #define OMAP_UART_FIFO_CLR	0X06
 
-#define OMAP_UART_DMA_CH_FREE	-1
-
-#define OMAP_MAX_HSUART_PORTS	4
-
-#define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
-
-#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
-#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
-
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
@@ -76,65 +50,4 @@ struct omap_uart_port_info {
 	void (*enable_wakeup)(struct platform_device *, bool);
 };
 
-struct uart_omap_dma {
-	u8			uart_dma_tx;
-	u8			uart_dma_rx;
-	int			rx_dma_channel;
-	int			tx_dma_channel;
-	dma_addr_t		rx_buf_dma_phys;
-	dma_addr_t		tx_buf_dma_phys;
-	unsigned int		uart_base;
-	/*
-	 * Buffer for rx dma.It is not required for tx because the buffer
-	 * comes from port structure.
-	 */
-	unsigned char		*rx_buf;
-	unsigned int		prev_rx_dma_pos;
-	int			tx_buf_size;
-	int			tx_dma_used;
-	int			rx_dma_used;
-	spinlock_t		tx_lock;
-	spinlock_t		rx_lock;
-	/* timer to poll activity on rx dma */
-	struct timer_list	rx_timer;
-	unsigned int		rx_buf_size;
-	unsigned int		rx_poll_rate;
-	unsigned int		rx_timeout;
-};
-
-struct uart_omap_port {
-	struct uart_port	port;
-	struct uart_omap_dma	uart_dma;
-	struct platform_device	*pdev;
-
-	unsigned char		ier;
-	unsigned char		lcr;
-	unsigned char		mcr;
-	unsigned char		fcr;
-	unsigned char		efr;
-	unsigned char		dll;
-	unsigned char		dlh;
-	unsigned char		mdr1;
-	unsigned char		scr;
-
-	int			use_dma;
-	/*
-	 * Some bits in registers are cleared on a read, so they must
-	 * be saved whenever the register is read but the bits will not
-	 * be immediately processed.
-	 */
-	unsigned int		lsr_break_flag;
-	unsigned char		msr_saved_flags;
-	char			name[20];
-	unsigned long		port_activity;
-	u32			context_loss_cnt;
-	u32			errata;
-	u8			wakeups_enabled;
-
-	struct pm_qos_request	pm_qos_request;
-	u32			latency;
-	u32			calc_latency;
-	struct work_struct	qos_work;
-};
-
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a5482da..fad157c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -44,6 +44,8 @@
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
+#define OMAP_MAX_HSUART_PORTS	4
+
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
 
 #define OMAP_UART_REV_42 0x0402
@@ -51,6 +53,9 @@
 #define OMAP_UART_REV_52 0x0502
 #define OMAP_UART_REV_63 0x0603
 
+#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
+#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
+
 #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
 
 /* SCR register bitmasks */
@@ -71,6 +76,89 @@
 #define OMAP_UART_MVR_MAJ_SHIFT		8
 #define OMAP_UART_MVR_MIN_MASK		0x3f
 
+#define OMAP_UART_DMA_CH_FREE	-1
+
+#define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
+#define OMAP_MODE13X_SPEED	230400
+
+#define OMAP_UART_SCR_TX_EMPTY	0x08
+
+/* WER = 0x7F
+ * Enable module level wakeup in WER reg
+ */
+#define OMAP_UART_WER_MOD_WKUP	0X7F
+
+/* Enable XON/XOFF flow control on output */
+#define OMAP_UART_SW_TX		0x08
+
+/* Enable XON/XOFF flow control on input */
+#define OMAP_UART_SW_RX		0x02
+
+#define OMAP_UART_SW_CLR	0xF0
+
+#define OMAP_UART_TCR_TRIG	0x0F
+
+struct uart_omap_dma {
+	u8			uart_dma_tx;
+	u8			uart_dma_rx;
+	int			rx_dma_channel;
+	int			tx_dma_channel;
+	dma_addr_t		rx_buf_dma_phys;
+	dma_addr_t		tx_buf_dma_phys;
+	unsigned int		uart_base;
+	/*
+	 * Buffer for rx dma.It is not required for tx because the buffer
+	 * comes from port structure.
+	 */
+	unsigned char		*rx_buf;
+	unsigned int		prev_rx_dma_pos;
+	int			tx_buf_size;
+	int			tx_dma_used;
+	int			rx_dma_used;
+	spinlock_t		tx_lock;
+	spinlock_t		rx_lock;
+	/* timer to poll activity on rx dma */
+	struct timer_list	rx_timer;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_poll_rate;
+	unsigned int		rx_timeout;
+};
+
+struct uart_omap_port {
+	struct uart_port	port;
+	struct uart_omap_dma	uart_dma;
+	struct platform_device	*pdev;
+
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		fcr;
+	unsigned char		efr;
+	unsigned char		dll;
+	unsigned char		dlh;
+	unsigned char		mdr1;
+	unsigned char		scr;
+
+	int			use_dma;
+	/*
+	 * Some bits in registers are cleared on a read, so they must
+	 * be saved whenever the register is read but the bits will not
+	 * be immediately processed.
+	 */
+	unsigned int		lsr_break_flag;
+	unsigned char		msr_saved_flags;
+	char			name[20];
+	unsigned long		port_activity;
+	u32			context_loss_cnt;
+	u32			errata;
+	u8			wakeups_enabled;
+
+	struct pm_qos_request	pm_qos_request;
+	u32			latency;
+	u32			calc_latency;
+	struct work_struct	qos_work;
+};
+
 static struct uart_omap_port *serial_omap_port(struct uart_port *port)
 {
 	return container_of(port, struct uart_omap_port, port);
-- 
1.7.4.4

