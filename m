From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to enable uart
Date: Fri, 29 Apr 2011 18:09:55 +0530
Message-ID: <1304080796-625-12-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Use resume idle call from prcm_irq to enable uart_port from low power states.
Add api to check pad wakeup status which will we used from uart_resume func.
to enable back uart port if a wakeup event occurred.

UART_Resume func. can be removed once we have irq_chaining functionality
available.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c                     |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h                     |   13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c              |   13 +++++++++++++
 arch/arm/mach-omap2/pm24xx.c                  |    2 ++
 arch/arm/mach-omap2/pm34xx.c                  |    2 ++
 arch/arm/mach-omap2/serial.c                  |   23 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |    1 +
 drivers/tty/serial/omap-serial.c              |   23 +++++++++++++++++++++++
 10 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index a4ab1e3..7149671 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -348,6 +348,29 @@ err1:
 	return NULL;
 }
 
+/* Gets the wakeup status of given pad from omap-hwmod.
+ * Returns the wake_up status bit of available pad mux pin
+ */
+bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
+{
+	int i;
+	unsigned int val;
+	u8 ret = 0;
+
+	for (i = 0; i < hmux->nr_pads; i++) {
+		struct omap_device_pad *pad = &hmux->pads[i];
+
+		val = omap_mux_read(pad->partition,
+					pad->mux->reg_offset);
+		if (val & OMAP_WAKEUP_EVENT) {
+			ret = 1;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 137f321..379fb6e 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
 
+
+/**
+ * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup event
+ * @hmux:		Pads for a hwmod
+ *
+ * Called only from omap_hwmod.c, do not use.
+ */
+bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
 #else
 
+static inline bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4a12336..86cb8c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2403,3 +2403,16 @@ int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
 
 	return ret;
 }
+
+/**
+ * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is available.
+ * @oh: struct omap_hwmod *
+ *
+ * Returns the wake_up status bit of available pad mux pin.
+ */
+int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)
+{
+	if (oh->mux)
+		return omap_hwmod_mux_wakeup(oh->mux);
+	return -EINVAL;
+}
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c405bda..ba58a1d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -137,6 +137,8 @@ static void omap2_enter_full_retention(void)
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
+	omap_uart_resume_idle();
+
 no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ce0ecdc..3960330 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -216,6 +216,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 
 	wkst = omap2_prm_read_mod_reg(module, wkst_off);
 	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
+
+	c += omap_uart_resume_idle();
 	if (wkst) {
 		iclk = omap2_cm_read_mod_reg(module, iclk_off);
 		fclk = omap2_cm_read_mod_reg(module, fclk_off);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5b2bdf8..d4ef370 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -199,6 +199,28 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 	}
 }
 
+/* TBD: Will be removed once we have irq-chaing mechanism */
+static bool omap_uart_chk_wakeup(struct platform_device *pdev)
+{
+	struct omap_uart_port_info *up = pdev->dev.platform_data;
+	struct omap_device *od;
+	u32 wkst = 0;
+	bool ret = false;
+
+	od = to_omap_device(pdev);
+	if (omap_hmwod_pad_wakeup_status(od->hwmods[0]))
+		ret = true;
+
+	/* Check for normal UART wakeup (and clear it) */
+	wkst = __raw_readl(up->wk_st) & up->wk_mask;
+	if (wkst) {
+		__raw_writel(wkst, up->wk_st);
+		ret = true;
+	}
+
+	return ret;
+}
+
 static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
 {
 	struct omap_uart_port_info *up = pdev->dev.platform_data;
@@ -369,6 +391,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
 	pdata->enable_wakeup = omap_uart_wakeup_enable;
+	pdata->chk_wakeup = omap_uart_chk_wakeup;
 	pdata->dma_enabled = info->dma_enabled;
 	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
 	pdata->dma_rx_poll_rate = info->dma_rx_poll_rate;
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index c5f4dd9..b5117bd 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -75,6 +75,7 @@ struct omap_uart_port_info {
 	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void (*enable_wakeup)(struct platform_device *, bool);
+	bool (*chk_wakeup)(struct platform_device *);
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
@@ -132,6 +133,7 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	unsigned int		errata;
 	void (*enable_wakeup)(struct platform_device *, bool);
+	bool (*chk_wakeup)(struct platform_device *);
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index b7f8d1b..6e60708 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -603,6 +603,7 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable);
 
+int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh);
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index a18668d..f2e4ae3 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -108,6 +108,7 @@ struct omap_uart_port_info;
 extern void omap_serial_init(struct omap_uart_port_info *platform_data);
 extern void omap_serial_init_port(struct omap_board_data *bdata,
 		struct omap_uart_port_info *platform_data);
+extern u32 omap_uart_resume_idle(void);
 #endif
 
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9ed993c..eea478c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -43,6 +43,7 @@
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 #include <plat/omap_device.h>
+#include <plat/serial.h>
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -108,6 +109,27 @@ static inline void serial_omap_port_enable(struct uart_omap_port *up)
 	pm_runtime_get_sync(&up->pdev->dev);
 }
 
+/* TBD: Should be removed once we irq-chaining mechanism in place */
+u32 omap_uart_resume_idle()
+{
+	int i;
+	u32 ret = 0;
+
+	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
+		struct uart_omap_port *up = ui[i];
+
+		if (!up)
+			continue;
+
+		if (up->chk_wakeup(up->pdev)) {
+			serial_omap_port_enable(up);
+			serial_omap_port_disable(up);
+			ret++;
+		}
+	}
+	return ret;
+}
+
 static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 {
 	if (up->uart_dma.rx_dma_used) {
@@ -1379,6 +1401,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->uart_dma.uart_base = mem->start;
 	up->errata = omap_up_info->errata;
 	up->enable_wakeup = omap_up_info->enable_wakeup;
+	up->chk_wakeup = omap_up_info->chk_wakeup;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
-- 
1.7.1

