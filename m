From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 11/20] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
Date: Wed, 16 Nov 2011 15:43:03 +0530
Message-ID: <CAAL8m4xYUd=5g7VOa7Ofnm6nRs8U1a7W+sofAkeCVOOURRfVXg@mail.gmail.com>
References: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com>
 <1321005551-21786-2-git-send-email-govindraj.raja@ti.com> <4EC17123.2070505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4EC17123.2070505@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 15, 2011 at 1:20 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,

[...]

>>
>> =A0 =A0 =A0 =A0oh =3D uart->oh;
>> - =A0 =A0 =A0 uart->dma_enabled =3D 0;
>> =A0 =A0 =A0 =A0name =3D DRIVER_NAME;
>>
>> =A0 =A0 =A0 =A0omap_up.dma_enabled =3D uart->dma_enabled;
>> =A0 =A0 =A0 =A0omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> =A0 =A0 =A0 =A0omap_up.flags =3D UPF_BOOT_AUTOCONF;
>> =A0 =A0 =A0 =A0omap_up.get_context_loss_count =3D
>> omap_pm_get_dev_context_loss_count;
>> + =A0 =A0 =A0 omap_up.set_forceidle =3D omap_uart_set_forceidle;
>> + =A0 =A0 =A0 omap_up.set_noidle =3D omap_uart_set_noidle;
>> +
>> + =A0 =A0 =A0 /* Enable the MDR1 errata for OMAP2/3/4 */
>> + =A0 =A0 =A0 if ((cpu_is_omap2430() || cpu_is_omap34xx() ||
>> cpu_is_omap44xx())&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 !cpu_is_ti816x())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_up.errata |=3D UART_ERRATA_i202_M=
DR1_ACCESS;
>
> I am not sure that this will apply the errata for OMAP3630 devices. I=
 think
> we need cpu_is_omap36xx() above too. Or you may wish to do
> !cpu_class_is_omap1 and !cpu_is_omap2420.
>

Yes correct, I have updated this patch as here [1].

btw, omap-serial is applicable only for omap2+ so
I think cpu_class_is omap1 not applicable here
need to be handled in /mach-omap1/serial.c.

>> =A0 =A0 =A0 =A0pdata =3D&omap_up;
>> =A0 =A0 =A0 =A0pdata_size =3D sizeof(struct omap_uart_port_info);
>> @@ -519,10 +481,6 @@ void __init omap_serial_init_port(struct
>> omap_board_data *bdata)
>> =A0 =A0 =A0 =A0if (((cpu_is_omap34xx() || cpu_is_omap44xx())&& =A0bd=
ata->pads) ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pdata->wk_en&& =A0pdata->wk_mask))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_init_wakeup(&pdev->dev, true);
>> -
>> - =A0 =A0 =A0 /* Enable the MDR1 errata for OMAP3 */
>> - =A0 =A0 =A0 if (cpu_is_omap34xx()&& =A0!cpu_is_ti816x())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->errata |=3D UART_ERRATA_i202_MDR=
1_ACCESS;
>> =A0}
>>
>> =A0/**

[...]

>>
>> + =A0 =A0 =A0 /* Errata i291 */
>> + =A0 =A0 =A0 if (up->use_dma&& =A0pdata->set_forceidle)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_forceidle(up->pdev);
>> +
>
> So it does appear that you are applying this to all devices. I think =
that
> this should only impact omap3.
>

Yes correct,  new one is has here [1].

--
Thanks,
Govindraj.R


[1]:

same is updated in here
(v8 uart runtime patches hosted in gitorious)
git://gitorious.org/runtime_3-0/runtime_3-0.git 3.2-rc1_uart_runtime.

=46rom e7ac07903a813f624c4a19d93131d40a09eb8f81 Mon Sep 17 00:00:00 200=
1
=46rom: Govindraj.R <govindraj.raja@ti.com>
Date: Mon, 7 Nov 2011 19:00:33 +0530
Subject: [PATCH v8 11/20] OMAP2+: UART: Move errata handling from
serial.c to omap-serial

Move the errata handling mechanism from serial.c to omap-serial file
and utilise the same func in driver file.

Errata i202, i291 are moved to be handled with omap-serial
Moving the errata macro from serial.c file to driver header file
as from on errata will be handled in driver file itself.
Corrected errata id from chapter reference 2.15 to errata id i291.

Removed errata and dma_enabled fields from omap_uart_state struct
as they are no more needed with errata handling done within omap-serial=
=2E

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |  101 ++++++++---------=
--------
 arch/arm/plat-omap/include/plat/omap-serial.h |    7 ++
 drivers/tty/serial/omap-serial.c              |   68 ++++++++++++++++-
 3 files changed, 102 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 98e2666..9cbf230 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -42,8 +42,6 @@
 #include "control.h"
 #include "mux.h"

-#define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
-
 /*
  * NOTE: By default the serial timeout is disabled as it causes lost c=
haracters
  * over the serial ports. This means that the UART clocks will stay on=
 until
@@ -61,59 +59,17 @@ struct omap_uart_state {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
-	u32 dma_enabled;

 	int clocked;

 	struct list_head node;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
-
-	u32 errata;
 };

 static LIST_HEAD(uart_list);
 static u8 num_uarts;

-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
-
-/*
- * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
- * The access to uart register after MDR1 Access
- * causes UART to corrupt data.
- *
- * Need a delay =3D
- * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz =3D ~0.2u=
S)
- * give 10 times as much
- */
-static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 =
mdr1_val,
-		u8 fcr_val)
-{
-	u8 timeout =3D 255;
-
-	serial_write_reg(uart, UART_OMAP_MDR1, mdr1_val);
-	udelay(2);
-	serial_write_reg(uart, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
-			UART_FCR_CLEAR_RCVR);
-	/*
-	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
-	 * TX_FIFO_E bit is 1.
-	 */
-	while (UART_LSR_THRE !=3D (serial_read_reg(uart, UART_LSR) &
-				(UART_LSR_THRE | UART_LSR_DR))) {
-		timeout--;
-		if (!timeout) {
-			/* Should *never* happen. we warn and carry on */
-			dev_crit(&uart->pdev->dev, "Errata i202: timedout %x\n",
-			serial_read_reg(uart, UART_LSR));
-			break;
-		}
-		udelay(1);
-	}
-}
-
-#endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
-
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uar=
t)
 {
 	if (uart->clocked)
@@ -156,27 +112,6 @@ static void omap_uart_disable_wakeup(struct
omap_uart_state *uart)
 	}
 }

-static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
-					       int enable)
-{
-	u8 idlemode;
-
-	if (enable) {
-		/**
-		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
-		 * in Smartidle Mode When Configured for DMA Operations.
-		 */
-		if (uart->dma_enabled)
-			idlemode =3D HWMOD_IDLEMODE_FORCE;
-		else
-			idlemode =3D HWMOD_IDLEMODE_SMART;
-	} else {
-		idlemode =3D HWMOD_IDLEMODE_NO;
-	}
-
-	omap_hwmod_set_slave_idlemode(uart->oh, idlemode);
-}
-
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
@@ -267,7 +202,28 @@ static void omap_uart_idle_init(struct
omap_uart_state *uart)
 	}
 }

+/*
+ * Errata i291: [UART]:Cannot Acknowledge Idle Requests
+ * in Smartidle Mode When Configured for DMA Operations.
+ * WA: configure uart in force idle mode.
+ */
+static void omap_uart_set_noidle(struct platform_device *pdev)
+{
+	struct omap_device *od =3D to_omap_device(pdev);
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
+}
+
+static void omap_uart_set_forceidle(struct platform_device *pdev)
+{
+	struct omap_device *od =3D to_omap_device(pdev);
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
+}
+
 #else
+static void omap_uart_set_noidle(struct platform_device *pdev) {}
+static void omap_uart_set_forceidle(struct platform_device *pdev) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	/* Needed to enable UART clocks when built without CONFIG_PM */
@@ -473,13 +429,22 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata)
 			break;

 	oh =3D uart->oh;
-	uart->dma_enabled =3D 0;
 	name =3D DRIVER_NAME;

 	omap_up.dma_enabled =3D uart->dma_enabled;
 	omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags =3D UPF_BOOT_AUTOCONF;
 	omap_up.get_context_loss_count =3D omap_pm_get_dev_context_loss_count=
;
+	omap_up.set_forceidle =3D omap_uart_set_forceidle;
+	omap_up.set_noidle =3D omap_uart_set_noidle;
+
+	/* Enable the MDR1 Errata i202 for OMAP2430/3xxx/44xx */
+	if (!cpu_is_omap2420() && !cpu_is_ti816x())
+		omap_up.errata |=3D UART_ERRATA_i202_MDR1_ACCESS;
+
+	/* Enable DMA Mode Force Idle Errata i291 for omap34xx/3630 */
+	if (cpu_is_omap34xx() || cpu_is_omap3630())
+		omap_up.errata |=3D UART_ERRATA_i291_DMA_FORCEIDLE;

 	pdata =3D &omap_up;
 	pdata_size =3D sizeof(struct omap_uart_port_info);
@@ -519,10 +484,6 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata)
 	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
 		(pdata->wk_en && pdata->wk_mask))
 		device_init_wakeup(&pdev->dev, true);
-
-	/* Enable the MDR1 errata for OMAP3 */
-	if (cpu_is_omap34xx() && !cpu_is_ti816x())
-		uart->errata |=3D UART_ERRATA_i202_MDR1_ACCESS;
 }

 /**
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
b/arch/arm/plat-omap/include/plat/omap-serial.h
index 348c9ea..842b429 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -58,12 +58,18 @@

 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA

+#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
+#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
+
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
 	upf_t			flags;		/* UPF_* flags */
+	u32			errata;

 	int (*get_context_loss_count)(struct device *);
+	void (*set_forceidle)(struct platform_device *);
+	void (*set_noidle)(struct platform_device *);
 };

 struct uart_omap_dma {
@@ -117,6 +123,7 @@ struct uart_omap_port {
 	char			name[20];
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
+	u32			errata;
 };

 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index ea4c24a..764ac77 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,6 +51,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORT=
S];
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
 static void serial_omap_rx_timeout(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
+static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 m=
dr1);

 static inline unsigned int serial_in(struct uart_omap_port *up, int of=
fset)
 {
@@ -808,7 +809,11 @@ serial_omap_set_termios(struct uart_port *port,
struct ktermios *termios,

 	/* Protocol, Baud Rate, and Interrupt Settings */

-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);

 	up->efr =3D serial_in(up, UART_EFR);
@@ -833,7 +838,10 @@ serial_omap_set_termios(struct uart_port *port,
struct ktermios *termios,
 	else
 		up->mdr1 =3D UART_OMAP_MDR1_16X_MODE;

-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);

 	/* Hardware Flow Control Configuration */

@@ -1362,6 +1370,7 @@ static int serial_omap_probe(struct platform_devi=
ce *pdev)
 	up->port.flags =3D omap_up_info->flags;
 	up->port.uartclk =3D omap_up_info->uartclk;
 	up->uart_dma.uart_base =3D mem->start;
+	up->errata =3D omap_up_info->errata;

 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx =3D dma_tx->start;
@@ -1415,9 +1424,47 @@ static int serial_omap_remove(struct
platform_device *dev)
 	return 0;
 }

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
+static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 m=
dr1)
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
+			dev_crit(&up->pdev->dev, "Errata i202: timedout %x\n",
+						serial_in(up, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
 static void serial_omap_restore_context(struct uart_omap_port *up)
 {
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
+	else
+		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
 	serial_out(up, UART_EFR, UART_EFR_ECB);
 	serial_out(up, UART_LCR, 0x0); /* Operational mode */
@@ -1434,7 +1481,10 @@ static void serial_omap_restore_context(struct
uart_omap_port *up)
 	serial_out(up, UART_OMAP_SCR, up->scr);
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 }

 #ifdef CONFIG_PM_RUNTIME
@@ -1449,6 +1499,11 @@ static int serial_omap_runtime_suspend(struct
device *dev)
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt =3D pdata->get_context_loss_count(dev);

+	/* Errata i291 */
+	if (up->use_dma && pdata->set_forceidle &&
+			(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
+		pdata->set_forceidle(up->pdev);
+
 	return 0;
 }

@@ -1464,6 +1519,11 @@ static int serial_omap_runtime_resume(struct dev=
ice *dev)
 			if (up->context_loss_cnt !=3D loss_cnt)
 				serial_omap_restore_context(up);
 		}
+
+		/* Errata i291 */
+		if (up->use_dma && pdata->set_noidle &&
+				(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
+			pdata->set_noidle(up->pdev);
 	}

 	return 0;
--=20
1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
