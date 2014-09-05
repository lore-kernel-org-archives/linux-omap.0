From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/18] tty: serial: Add 8250-core based omap driver
Date: Fri,  5 Sep 2014 21:02:43 +0200
Message-ID: <1409943773-7874-9-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

This patch provides a 8250-core based UART driver for the internal OMAP
UART. The long term goal is to provide the same functionality as the
current OMAP uart driver and DMA support.
I tried to merge omap-serial code together with the 8250-core code.
There should should be hardly a noticable difference. The trigger level=
s
are different compared to omap-serial:
- omap serial
  TX: Interrupt comes after TX FIFO has room for 16 bytes.
      TX of 4096 bytes in one go results in 256 interrupts

  RX: Interrupt comes after there is on byte in the FIFO.
      RX of 4096 bytes results in 4096 interrupts.

- this driver
  TX: Interrupt comes once the TX FIFO is empty.
      TX of 4096 bytes results in 65 interrupts. That means there will
      be gaps on the line while the driver reloads the FIFO.

  RX: Interrupt comes once there are 48 bytes in the FIFO or less over
      "longer" time frame. We have
          1 / 11520 * 10^3 * 16 =3D> 1.38=E2=80=A6 ms
      1.38ms to react and purge the FIFO on 115200,8N1. Since the other
      driver fired after each byte it had ~5.47ms time to react. This
      _may_ cause problems if one relies on no missing bytes and has no
      flow control. On the other hand we get only 85 interrupts for the
      same amount of data.

It has been only tested as console UART on am335x-evm, dra7-evm and
beagle bone. I also did some longer raw-transfers to meassure the load.

The device name is ttyS based instead of ttyO. If a ttyO based node nam=
e
is required please ask udev for it. If both driver are activated (this
and omap-serial) then this serial driver will take control over the
device due to the link order

v7=E2=80=A6v8:
	- redo the register write. There is now one function for that
	  which is used from set_termios() and runtime-resume.
	- drop PORT_OMAP_16750 and move the setup to the omap file. We
	  have our own set termios function anyway (Heikki Krogerus)
	- use MEM instead of MEM32. TRM of AM/DM37x says that 32bit
	  access on THR might result in data abort. We only need 32bit
	  access in the errata function which is before we use 8250's
	  read function so it doesn't matter.
v4=E2=80=A6v7:
	- change trigger levels after some tests with raw transfers.
v3=E2=80=A6v4:
	- drop RS485 support
	- wire up ->throttle / ->unthrottle
v2=E2=80=A6v3:
	- wire up startup & shutdown for wakeup-irq handling.
	- RS485 handling (well the core does).

v1=E2=80=A6v2:
	- added runtime PM. Could somebody could please double check
	  this?
	- added omap_8250_set_termios()

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 905 ++++++++++++++++++++++++++++=
++++++++
 drivers/tty/serial/8250/Kconfig     |   9 +
 drivers/tty/serial/8250/Makefile    |   1 +
 3 files changed, 915 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_omap.c

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8=
250/8250_omap.c
new file mode 100644
index 000000000000..4128bbc35089
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -0,0 +1,905 @@
+/*
+ * 8250-core based driver for the OMAP internal UART
+ *
+ *  Copyright (C) 2014 Sebastian Andrzej Siewior
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <linux/console.h>
+#include <linux/pm_qos.h>
+
+#include "8250.h"
+
+#define UART_DLL_EM 9
+#define UART_DLM_EM 10
+
+#define DEFAULT_CLK_SPEED	48000000 /* 48 Mhz*/
+
+#define UART_ERRATA_i202_MDR1_ACCESS	(1 << 0)
+#define OMAP_UART_WER_HAS_TX_WAKEUP	(1 << 1)
+
+#define OMAP_UART_FCR_RX_TRIG		6
+#define OMAP_UART_FCR_TX_TRIG		4
+
+/* SCR register bitmasks */
+#define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK	(1 << 7)
+#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK	(1 << 6)
+#define OMAP_UART_SCR_TX_EMPTY			(1 << 3)
+#define OMAP_UART_SCR_DMAMODE_MASK		(3 << 1)
+#define OMAP_UART_SCR_DMAMODE_1			(1 << 1)
+#define OMAP_UART_SCR_DMAMODE_CTL		(1 << 0)
+
+/* MVR register bitmasks */
+#define OMAP_UART_MVR_SCHEME_SHIFT	30
+#define OMAP_UART_LEGACY_MVR_MAJ_MASK	0xf0
+#define OMAP_UART_LEGACY_MVR_MAJ_SHIFT	4
+#define OMAP_UART_LEGACY_MVR_MIN_MASK	0x0f
+#define OMAP_UART_MVR_MAJ_MASK		0x700
+#define OMAP_UART_MVR_MAJ_SHIFT		8
+#define OMAP_UART_MVR_MIN_MASK		0x3f
+
+#define UART_TI752_TLR_TX	0
+#define UART_TI752_TLR_RX	4
+
+#define TRIGGER_TLR_MASK(x)	((x & 0x3c) >> 2)
+#define TRIGGER_FCR_MASK(x)	(x & 3)
+
+/* Enable XON/XOFF flow control on output */
+#define OMAP_UART_SW_TX		0x08
+/* Enable XON/XOFF flow control on input */
+#define OMAP_UART_SW_RX		0x02
+
+#define OMAP_UART_WER_MOD_WKUP	0x7f
+#define OMAP_UART_TX_WAKEUP_EN	(1 << 7)
+
+#define TX_TRIGGER	1
+#define RX_TRIGGER	48
+
+#define OMAP_UART_TCR_RESTORE(x)	((x / 4) << 4)
+#define OMAP_UART_TCR_HALT(x)		((x / 4) << 0)
+
+#define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
+
+#define OMAP_UART_REV_46 0x0406
+#define OMAP_UART_REV_52 0x0502
+#define OMAP_UART_REV_63 0x0603
+
+struct omap8250_priv {
+	int line;
+	u32 habit;
+	u32 mdr1;
+	u32 efr;
+	u32 quot;
+	u32 scr;
+	u32 wer;
+	u32 xon;
+	u32 xoff;
+
+	bool is_suspending;
+	int wakeirq;
+	int wakeups_enabled;
+	u32 latency;
+	u32 calc_latency;
+	struct pm_qos_request pm_qos_request;
+	struct work_struct qos_work;
+	struct uart_8250_dma omap8250_dma;
+	bool dma_active;
+};
+
+static u32 uart_read(struct uart_8250_port *up, u32 reg)
+{
+	return readl(up->port.membase + (reg << up->port.regshift));
+}
+
+/*
+ * Work Around for Errata i202 (2430, 3430, 3630, 4430 and 4460)
+ * The access to uart register after MDR1 Access
+ * causes UART to corrupt data.
+ *
+ * Need a delay =3D
+ * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz =3D ~0.2u=
S)
+ * give 10 times as much
+ */
+static void omap_8250_mdr1_errataset(struct uart_8250_port *up, u8 mdr=
1)
+{
+	u8 timeout =3D 255;
+
+	serial_out(up, UART_OMAP_MDR1, mdr1);
+	udelay(2);
+	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
+			UART_FCR_CLEAR_RCVR);
+	/*
+	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
+	 * TX_FIFO_E bit is 1.
+	 */
+	while (UART_LSR_THRE !=3D (serial_in(up, UART_LSR) &
+				(UART_LSR_THRE | UART_LSR_DR))) {
+		timeout--;
+		if (!timeout) {
+			/* Should *never* happen. we warn and carry on */
+			dev_crit(up->port.dev, "Errata i202: timedout %x\n",
+						serial_in(up, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
+static void omap_8250_get_divisor(struct uart_port *port, unsigned int=
 baud,
+		struct omap8250_priv *priv)
+{
+	unsigned int uartclk =3D port->uartclk;
+	unsigned int div_13, div_16;
+	unsigned int abs_d13, abs_d16;
+
+	/*
+	 * Old custom speed handling.
+	 */
+	if (baud =3D=3D 38400 && (port->flags & UPF_SPD_MASK) =3D=3D UPF_SPD_=
CUST) {
+		priv->quot =3D port->custom_divisor & 0xffff;
+		/*
+		 * I assume that nobody is using this. But hey, if somebody
+		 * would like to specify the divisor _and_ the mode then the
+		 * driver is ready and waiting for it.
+		 */
+		if (port->custom_divisor & (1 << 16))
+			priv->mdr1 =3D UART_OMAP_MDR1_13X_MODE;
+		else
+			priv->mdr1 =3D UART_OMAP_MDR1_16X_MODE;
+		return;
+	}
+	div_13 =3D DIV_ROUND_CLOSEST(uartclk, 13 * baud);
+	div_16 =3D DIV_ROUND_CLOSEST(uartclk, 16 * baud);
+
+	abs_d13 =3D abs(baud - port->uartclk / 13 / div_13);
+	abs_d16 =3D abs(baud - port->uartclk / 16 / div_16);
+
+	if (abs_d13 >=3D abs_d16) {
+		priv->mdr1 =3D UART_OMAP_MDR1_16X_MODE;
+		priv->quot =3D div_16;
+	} else {
+		priv->mdr1 =3D UART_OMAP_MDR1_13X_MODE;
+		priv->quot =3D div_13;
+	}
+}
+
+static void omap8250_update_scr(struct uart_8250_port *up,
+		struct omap8250_priv *priv)
+{
+	/*
+	 * The manual recommends not to enable the DMA mode selector in the S=
CR
+	 * (instead of the FCR) register _and_ selecting the DMA mode as one
+	 * register write because this may lead to malfunction.
+	 */
+	if (priv->scr & OMAP_UART_SCR_DMAMODE_MASK)
+		serial_out(up, UART_OMAP_SCR,
+				priv->scr & ~OMAP_UART_SCR_DMAMODE_MASK);
+	serial_out(up, UART_OMAP_SCR, priv->scr);
+}
+
+static void omap8250_restore_regs(struct uart_8250_port *up)
+{
+	struct omap8250_priv *priv =3D up->port.private_data;
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_DLL, 0);
+	serial_out(up, UART_DLM, 0);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, UART_MCR_TCRTLR);
+
+	serial_out(up, UART_TI752_TCR,
+			OMAP_UART_TCR_RESTORE(16) | OMAP_UART_TCR_HALT(52));
+
+	serial_out(up, UART_TI752_TLR,
+			TRIGGER_TLR_MASK(TX_TRIGGER) << UART_TI752_TLR_TX |
+			TRIGGER_TLR_MASK(RX_TRIGGER) << UART_TI752_TLR_RX);
+	serial_out(up, UART_FCR, up->fcr);
+
+	omap8250_update_scr(up, priv);
+
+	/* Protocol, Baud Rate, and Interrupt Settings */
+	if (priv->habit & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_8250_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
+	else
+		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_dl_write(up, priv->quot);
+	serial_out(up, UART_XON1, priv->xon);
+	serial_out(up, UART_XOFF1, priv->xoff);
+	serial_out(up, UART_EFR, priv->efr);
+
+	serial_out(up, UART_LCR, 0);
+	serial_out(up, UART_IER, up->ier);
+
+	serial_out(up, UART_FCR, up->fcr);
+
+	if (priv->habit & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_8250_mdr1_errataset(up, priv->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, priv->mdr1);
+
+	serial_out(up, UART_LCR, up->lcr);
+	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
+}
+/*
+ * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we ha=
ve have
+ * some differences in how we want to handle flow control.
+ */
+static void omap_8250_set_termios(struct uart_port *port,
+		struct ktermios *termios, struct ktermios *old)
+{
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+	struct omap8250_priv *priv =3D up->port.private_data;
+	unsigned char cval =3D 0;
+	unsigned long flags =3D 0;
+	unsigned int baud;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval =3D UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval =3D UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval =3D UART_LCR_WLEN7;
+		break;
+	default:
+	case CS8:
+		cval =3D UART_LCR_WLEN8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |=3D UART_LCR_STOP;
+	if (termios->c_cflag & PARENB)
+		cval |=3D UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |=3D UART_LCR_EPAR;
+	if (termios->c_cflag & CMSPAR)
+		cval |=3D UART_LCR_SPAR;
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud =3D uart_get_baud_rate(port, termios, old,
+			port->uartclk / 16 / 0xffff,
+			port->uartclk / 13);
+	omap_8250_get_divisor(port, baud, priv);
+
+	/*
+	 * Ok, we're now changing the port state. Do it with
+	 * interrupts disabled.
+	 */
+	pm_runtime_get_sync(port->dev);
+	spin_lock_irqsave(&port->lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	up->port.read_status_mask =3D UART_LSR_OE | UART_LSR_THRE | UART_LSR_=
DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |=3D UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |=3D UART_LSR_BI;
+
+	/*
+	 * Characters to ignore
+	 */
+	up->port.ignore_status_mask =3D 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |=3D UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |=3D UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |=3D UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) =3D=3D 0)
+		up->port.ignore_status_mask |=3D UART_LSR_DR;
+
+	/*
+	 * Modem status interrupts
+	 */
+	up->ier &=3D ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |=3D UART_IER_MSI;
+
+	up->lcr =3D cval;
+	/* Up to here it was mostly serial8250_do_set_termios() */
+
+	/*
+	 * We enable TRIG_GRANU for RX and TX and additionaly we set
+	 * SCR_TX_EMPTY bit. The result is the following:
+	 * - RX_TRIGGER amount of bytes in the FIFO will cause an interrupt.
+	 * - less than RX_TRIGGER number of bytes will also cause an interrup=
t
+	 *   once the UART decides that there no new bytes arriving.
+	 * - Once THRE is enabled, the interrupt will be fired once the FIFO =
is
+	 *   empty - the trigger level is ignored here.
+	 *
+	 * Once DMA is enabled:
+	 * - UART will assert the TX DMA line once there is room for TX_TRIGG=
ER
+	 *   bytes in the TX FIFO. On each assert the DMA engine will move
+	 *   TX_TRIGGER bytes into the FIFO.
+	 * - UART will assert the RX DMA line once there are RX_TRIGGER bytes=
 in
+	 *   the FIFO and move RX_TRIGGER bytes.
+	 * This is because treshold and trigger values are the same.
+	 */
+	up->fcr =3D UART_FCR_ENABLE_FIFO;
+	up->fcr |=3D TRIGGER_FCR_MASK(TX_TRIGGER) << OMAP_UART_FCR_TX_TRIG;
+	up->fcr |=3D TRIGGER_FCR_MASK(RX_TRIGGER) << OMAP_UART_FCR_RX_TRIG;
+
+	priv->scr =3D OMAP_UART_SCR_RX_TRIG_GRANU1_MASK | OMAP_UART_SCR_TX_EM=
PTY |
+		OMAP_UART_SCR_TX_TRIG_GRANU1_MASK;
+
+	priv->xon =3D termios->c_cc[VSTART];
+	priv->xoff =3D termios->c_cc[VSTOP];
+
+	priv->efr =3D 0;
+	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
+		/* Enable AUTORTS and AUTOCTS */
+		priv->efr |=3D UART_EFR_CTS | UART_EFR_RTS;
+
+		/* Ensure MCR RTS is asserted */
+		up->mcr |=3D UART_MCR_RTS;
+	}
+
+	if (up->port.flags & UPF_SOFT_FLOW) {
+		/*
+		 * IXON Flag:
+		 * Enable XON/XOFF flow control on input.
+		 * Receiver compares XON1, XOFF1.
+		 */
+		if (termios->c_iflag & IXON)
+			priv->efr |=3D OMAP_UART_SW_RX;
+
+		/*
+		 * IXOFF Flag:
+		 * Enable XON/XOFF flow control on output.
+		 * Transmit XON1, XOFF1
+		 */
+		if (termios->c_iflag & IXOFF)
+			priv->efr |=3D OMAP_UART_SW_TX;
+
+		/*
+		 * IXANY Flag:
+		 * Enable any character to restart output.
+		 * Operation resumes after receiving any
+		 * character after recognition of the XOFF character
+		 */
+		if (termios->c_iflag & IXANY)
+			up->mcr |=3D UART_MCR_XONANY;
+		else
+			up->mcr &=3D ~UART_MCR_XONANY;
+	}
+	omap8250_restore_regs(up);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
+	/* calculate wakeup latency constraint */
+	priv->calc_latency =3D USEC_PER_SEC * 64 * 8 / baud;
+	priv->latency =3D priv->calc_latency;
+
+	schedule_work(&priv->qos_work);
+
+	/* Don't rewrite B0 */
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
+}
+
+/* same as 8250 except that we may have extra flow bits set in EFR */
+static void omap_8250_pm(struct uart_port *port, unsigned int state,
+		unsigned int oldstate)
+{
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+	struct omap8250_priv *priv =3D up->port.private_data;
+
+	pm_runtime_get_sync(port->dev);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, priv->efr | UART_EFR_ECB);
+	serial_out(up, UART_LCR, 0);
+
+	serial_out(up, UART_IER, (state !=3D 0) ? UART_IERX_SLEEP : 0);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, priv->efr);
+	serial_out(up, UART_LCR, 0);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+}
+
+static void omap_serial_fill_features_erratas(struct uart_8250_port *u=
p,
+		struct omap8250_priv *priv)
+{
+	u32 mvr, scheme;
+	u16 revision, major, minor;
+
+	mvr =3D uart_read(up, UART_OMAP_MVER);
+
+	/* Check revision register scheme */
+	scheme =3D mvr >> OMAP_UART_MVR_SCHEME_SHIFT;
+
+	switch (scheme) {
+	case 0: /* Legacy Scheme: OMAP2/3 */
+		/* MINOR_REV[0:4], MAJOR_REV[4:7] */
+		major =3D (mvr & OMAP_UART_LEGACY_MVR_MAJ_MASK) >>
+			OMAP_UART_LEGACY_MVR_MAJ_SHIFT;
+		minor =3D (mvr & OMAP_UART_LEGACY_MVR_MIN_MASK);
+		break;
+	case 1:
+		/* New Scheme: OMAP4+ */
+		/* MINOR_REV[0:5], MAJOR_REV[8:10] */
+		major =3D (mvr & OMAP_UART_MVR_MAJ_MASK) >>
+			OMAP_UART_MVR_MAJ_SHIFT;
+		minor =3D (mvr & OMAP_UART_MVR_MIN_MASK);
+		break;
+	default:
+		dev_warn(up->port.dev,
+				"Unknown revision, defaulting to highest\n");
+		/* highest possible revision */
+		major =3D 0xff;
+		minor =3D 0xff;
+	}
+	/* normalize revision for the driver */
+	revision =3D UART_BUILD_REVISION(major, minor);
+
+	switch (revision) {
+	case OMAP_UART_REV_46:
+		priv->habit =3D UART_ERRATA_i202_MDR1_ACCESS;
+		break;
+	case OMAP_UART_REV_52:
+		priv->habit =3D UART_ERRATA_i202_MDR1_ACCESS |
+				OMAP_UART_WER_HAS_TX_WAKEUP;
+		break;
+	case OMAP_UART_REV_63:
+		priv->habit =3D UART_ERRATA_i202_MDR1_ACCESS |
+			OMAP_UART_WER_HAS_TX_WAKEUP;
+		break;
+	default:
+		break;
+	}
+}
+
+static void omap8250_uart_qos_work(struct work_struct *work)
+{
+	struct omap8250_priv *priv;
+
+	priv =3D container_of(work, struct omap8250_priv, qos_work);
+	pm_qos_update_request(&priv->pm_qos_request, priv->latency);
+}
+
+static irqreturn_t omap_wake_irq(int irq, void *dev_id)
+{
+	struct uart_port *port =3D dev_id;
+	int ret;
+
+	ret =3D port->handle_irq(port);
+	if (ret)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
+static int omap_8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+	struct omap8250_priv *priv =3D port->private_data;
+
+	int ret;
+
+	if (priv->wakeirq) {
+		ret =3D request_irq(priv->wakeirq, omap_wake_irq,
+				port->irqflags, "wakeup irq", port);
+		if (ret)
+			return ret;
+		disable_irq(priv->wakeirq);
+	}
+
+	pm_runtime_get_sync(port->dev);
+
+	ret =3D serial8250_do_startup(port);
+	if (ret)
+		goto err;
+
+#ifdef CONFIG_PM_RUNTIME
+	up->capabilities |=3D UART_CAP_RPM;
+#endif
+
+	/* Enable module level wake up */
+	priv->wer =3D OMAP_UART_WER_MOD_WKUP;
+	if (priv->habit & OMAP_UART_WER_HAS_TX_WAKEUP)
+		priv->wer |=3D OMAP_UART_TX_WAKEUP_EN;
+	serial_out(up, UART_OMAP_WER, priv->wer);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+	return 0;
+err:
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+	if (priv->wakeirq)
+		free_irq(priv->wakeirq, port);
+	return ret;
+}
+
+static void omap_8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+	struct omap8250_priv *priv =3D port->private_data;
+
+	flush_work(&priv->qos_work);
+
+	pm_runtime_get_sync(port->dev);
+
+	serial_out(up, UART_OMAP_WER, 0);
+	serial8250_do_shutdown(port);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+
+	if (priv->wakeirq)
+		free_irq(priv->wakeirq, port);
+}
+
+static void omap_8250_throttle(struct uart_port *port)
+{
+	unsigned long flags;
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+
+	pm_runtime_get_sync(port->dev);
+
+	spin_lock_irqsave(&port->lock, flags);
+	up->ier &=3D ~(UART_IER_RLSI | UART_IER_RDI);
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+}
+
+static void omap_8250_unthrottle(struct uart_port *port)
+{
+	unsigned long flags;
+	struct uart_8250_port *up =3D
+		container_of(port, struct uart_8250_port, port);
+
+	pm_runtime_get_sync(port->dev);
+
+	spin_lock_irqsave(&port->lock, flags);
+	up->ier |=3D UART_IER_RLSI | UART_IER_RDI;
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put_autosuspend(port->dev);
+}
+
+static int omap8250_probe(struct platform_device *pdev)
+{
+	struct resource *regs =3D platform_get_resource(pdev, IORESOURCE_MEM,=
 0);
+	struct resource *irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, =
0);
+	struct omap8250_priv *priv;
+	struct uart_8250_port up;
+	int ret;
+	void __iomem *membase;
+
+	if (!regs || !irq) {
+		dev_err(&pdev->dev, "missing registers or irq\n");
+		return -EINVAL;
+	}
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	membase =3D devm_ioremap_nocache(&pdev->dev, regs->start,
+			resource_size(regs));
+	if (!membase)
+		return -ENODEV;
+
+	memset(&up, 0, sizeof(up));
+	up.port.dev =3D &pdev->dev;
+	up.port.mapbase =3D regs->start;
+	up.port.membase =3D membase;
+	up.port.irq =3D irq->start;
+	/*
+	 * It claims to be 16C750 compatible however it is a little different=
=2E
+	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
+	 * have) is enabled via EFR instead of MCR. The type is set here 8250
+	 * just to get things going. UNKNOWN does not work for a few reasons =
and
+	 * we don't need our own type since we don't use 8250's set_termios()
+	 * and our "bugs" are handeld via the bug member.
+	 */
+	up.port.type =3D PORT_8250;
+	up.port.iotype =3D UPIO_MEM;
+	up.port.flags =3D UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
+		UPF_HARD_FLOW;
+	up.port.private_data =3D priv;
+
+	up.port.regshift =3D 2;
+	up.port.fifosize =3D 64;
+	up.tx_loadsz =3D 64;
+	up.capabilities =3D UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP;
+#ifdef CONFIG_PM_RUNTIME
+	/*
+	 * PM_RUNTIME is mostly transparent. However to do it right we need t=
o a
+	 * TX empty interrupt before we can put the device to auto idle. So i=
f
+	 * PM_RUNTIME is not enabled we don't add that flag and can spare tha=
t
+	 * one extra interrupt in the TX path.
+	 */
+	up.capabilities |=3D UART_CAP_RPM;
+#endif
+	up.port.set_termios =3D omap_8250_set_termios;
+	up.port.pm =3D omap_8250_pm;
+	up.port.startup =3D omap_8250_startup;
+	up.port.shutdown =3D omap_8250_shutdown;
+	up.port.throttle =3D omap_8250_throttle;
+	up.port.unthrottle =3D omap_8250_unthrottle;
+
+	if (pdev->dev.of_node) {
+		up.port.line =3D of_alias_get_id(pdev->dev.of_node, "serial");
+		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				&up.port.uartclk);
+		priv->wakeirq =3D irq_of_parse_and_map(pdev->dev.of_node, 1);
+	} else {
+		up.port.line =3D pdev->id;
+	}
+
+	if (up.port.line < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
+				up.port.line);
+		return -ENODEV;
+	}
+	if (!up.port.uartclk) {
+		up.port.uartclk =3D DEFAULT_CLK_SPEED;
+		dev_warn(&pdev->dev,
+				"No clock speed specified: using default: %d\n",
+				DEFAULT_CLK_SPEED);
+	}
+
+	priv->latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	priv->calc_latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	pm_qos_add_request(&priv->pm_qos_request,
+			PM_QOS_CPU_DMA_LATENCY, priv->latency);
+	INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
+
+	device_init_wakeup(&pdev->dev, true);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
+
+	pm_runtime_irq_safe(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	omap_serial_fill_features_erratas(&up, priv);
+	ret =3D serial8250_register_8250_port(&up);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to register 8250 port\n");
+		goto err;
+	}
+	priv->line =3D ret;
+	platform_set_drvdata(pdev, priv);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+	return 0;
+err:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int omap8250_remove(struct platform_device *pdev)
+{
+	struct omap8250_priv *priv =3D platform_get_drvdata(pdev);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	serial8250_unregister_port(priv->line);
+	pm_qos_remove_request(&priv->pm_qos_request);
+	device_init_wakeup(&pdev->dev, false);
+	return 0;
+}
+
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+
+static inline void omap8250_enable_wakeirq(struct omap8250_priv *priv,
+		bool enable)
+{
+	if (!priv->wakeirq)
+		return;
+
+	if (enable)
+		enable_irq(priv->wakeirq);
+	else
+		disable_irq_nosync(priv->wakeirq);
+}
+
+static void omap8250_enable_wakeup(struct omap8250_priv *priv,
+		bool enable)
+{
+	if (enable =3D=3D priv->wakeups_enabled)
+		return;
+
+	omap8250_enable_wakeirq(priv, enable);
+	priv->wakeups_enabled =3D enable;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int omap8250_prepare(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+
+	if (!priv)
+		return 0;
+	priv->is_suspending =3D true;
+	return 0;
+}
+
+static void omap8250_complete(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+
+	if (!priv)
+		return;
+	priv->is_suspending =3D false;
+}
+
+static int omap8250_suspend(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+
+	serial8250_suspend_port(priv->line);
+	flush_work(&priv->qos_work);
+
+	if (device_may_wakeup(dev))
+		omap8250_enable_wakeup(priv, true);
+	else
+		omap8250_enable_wakeup(priv, false);
+	return 0;
+}
+
+static int omap8250_resume(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		omap8250_enable_wakeup(priv, false);
+
+	serial8250_resume_port(priv->line);
+	return 0;
+}
+#else
+#define omap8250_prepare NULL
+#define omap8250_complete NULL
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static int omap8250_lost_context(struct uart_8250_port *up)
+{
+	u32 val;
+
+	val =3D serial_in(up, UART_OMAP_MDR1);
+	/*
+	 * If we lose context, then MDR1 is set to its reset value which is
+	 * UART_OMAP_MDR1_DISABLE. After set_termios() we set it either to 13=
x
+	 * or 16x but never to disable again.
+	 */
+	if (val =3D=3D UART_OMAP_MDR1_DISABLE)
+		return 1;
+	return 0;
+}
+
+static int omap8250_runtime_suspend(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+	struct uart_8250_port *up;
+
+	up =3D serial8250_get_port(priv->line);
+	/*
+	 * When using 'no_console_suspend', the console UART must not be
+	 * suspended. Since driver suspend is managed by runtime suspend,
+	 * preventing runtime suspend (by returning error) will keep device
+	 * active during suspend.
+	 */
+	if (priv->is_suspending && !console_suspend_enabled) {
+		if (uart_console(&up->port))
+			return -EBUSY;
+	}
+
+	omap8250_enable_wakeup(priv, true);
+
+	priv->latency =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	schedule_work(&priv->qos_work);
+
+	return 0;
+}
+
+static int omap8250_runtime_resume(struct device *dev)
+{
+	struct omap8250_priv *priv =3D dev_get_drvdata(dev);
+	struct uart_8250_port *up;
+	int loss_cntx;
+
+	/* In case runtime-pm tries this before we are setup */
+	if (!priv)
+		return 0;
+
+	up =3D serial8250_get_port(priv->line);
+	omap8250_enable_wakeup(priv, false);
+	loss_cntx =3D omap8250_lost_context(up);
+
+	if (loss_cntx)
+		omap8250_restore_regs(up);
+
+	priv->latency =3D priv->calc_latency;
+	schedule_work(&priv->qos_work);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops omap8250_dev_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
+	SET_RUNTIME_PM_OPS(omap8250_runtime_suspend,
+			omap8250_runtime_resume, NULL)
+	.prepare        =3D omap8250_prepare,
+	.complete       =3D omap8250_complete,
+};
+
+static const struct of_device_id omap8250_dt_ids[] =3D {
+	{ .compatible =3D "ti,omap2-uart" },
+	{ .compatible =3D "ti,omap3-uart" },
+	{ .compatible =3D "ti,omap4-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
+
+static struct platform_driver omap8250_platform_driver =3D {
+	.driver =3D {
+		.name		=3D "omap8250",
+		.pm		=3D &omap8250_dev_pm_ops,
+		.of_match_table =3D omap8250_dt_ids,
+		.owner		=3D THIS_MODULE,
+	},
+	.probe			=3D omap8250_probe,
+	.remove			=3D omap8250_remove,
+};
+module_platform_driver(omap8250_platform_driver);
+
+MODULE_AUTHOR("Sebastian Andrzej Siewior");
+MODULE_DESCRIPTION("OMAP 8250 Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/=
Kconfig
index 349ee598b34c..7a5073b3726f 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -298,3 +298,12 @@ config SERIAL_8250_RT288X
 	  If you have a Ralink RT288x/RT305x SoC based board and want to use =
the
 	  serial port, say Y to this option. The driver can handle up to 2 se=
rial
 	  ports. If unsure, say N.
+
+config SERIAL_8250_OMAP
+	tristate "Support for OMAP internal UART (8250 based driver)"
+	depends on SERIAL_8250 && ARCH_OMAP2PLUS
+	help
+	  If you have a machine based on an Texas Instruments OMAP CPU you
+	  can enable its onboard serial ports by enabling this option.
+
+	  This driver is in early stage and uses ttyS instead of ttyO.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250=
/Makefile
index 36d68d054307..4bac3923759b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SERIAL_8250_HUB6)		+=3D 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+=3D 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+=3D 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+=3D 8250_em.o
+obj-$(CONFIG_SERIAL_8250_OMAP)		+=3D 8250_omap.o
--=20
2.1.0
