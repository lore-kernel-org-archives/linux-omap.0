From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 12/21] OMAP2+: UART: Add wakeup mechanism for omap-uarts
Date: Tue, 18 Oct 2011 20:56:07 +0530
Message-ID: <1318951576-10165-13-git-send-email-govindraj.raja@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

>From the runtime callbacks enable hwmod wakeups for uart which will
internally enable io-pad wakeups for uarts if they have rx-pad pins
set as wakeup capabale.

Use the io-ring wakeup mechanism after uart clock gating and leave
the PM_WKST set for uart to default reset values cleanup the
code in serial.c which was handling PM_WKST reg.
Irq_chaing(PRM_DRIVER) is used to wakeup uart after uart clocks are gated
using pad wakeup mechanism.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   96 +++---------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
 drivers/tty/serial/omap-serial.c              |   15 ++++
 3 files changed, 29 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c6dc85..6b3f0bd 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -56,10 +56,6 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;
 
-	void __iomem *wk_st;
-	void __iomem *wk_en;
-	u32 wk_mask;
-
 	int clocked;
 
 	struct list_head node;
@@ -114,26 +110,6 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	omap_device_idle(uart->pdev);
 }
 
-static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
-{
-	/* Set wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v |= uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-}
-
-static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
-{
-	/* Clear wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v &= ~uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-}
-
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
@@ -163,65 +139,17 @@ int omap_uart_can_sleep(void)
 	return can_sleep;
 }
 
-static void omap_uart_idle_init(struct omap_uart_state *uart)
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
-	int ret;
-
-	uart->can_sleep = 0;
-	omap_uart_smart_idle_enable(uart, 0);
+	struct omap_device *od = to_omap_device(pdev);
 
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
-		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
-		u32 wk_mask = 0;
+	if (!od)
+		return;
 
-		/* XXX These PRM accesses do not belong here */
-		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
-		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
-		switch (uart->num) {
-		case 0:
-			wk_mask = OMAP3430_ST_UART1_MASK;
-			break;
-		case 1:
-			wk_mask = OMAP3430_ST_UART2_MASK;
-			break;
-		case 2:
-			wk_mask = OMAP3430_ST_UART3_MASK;
-			break;
-		case 3:
-			wk_mask = OMAP3630_ST_UART4_MASK;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-	} else if (cpu_is_omap24xx()) {
-		u32 wk_mask = 0;
-		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
-
-		switch (uart->num) {
-		case 0:
-			wk_mask = OMAP24XX_ST_UART1_MASK;
-			break;
-		case 1:
-			wk_mask = OMAP24XX_ST_UART2_MASK;
-			break;
-		case 2:
-			wk_en = OMAP24XX_PM_WKEN2;
-			wk_st = OMAP24XX_PM_WKST2;
-			wk_mask = OMAP24XX_ST_UART3_MASK;
-			break;
-		}
-		uart->wk_mask = wk_mask;
-		if (cpu_is_omap2430()) {
-			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, wk_st);
-		} else if (cpu_is_omap2420()) {
-			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, wk_en);
-			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, wk_st);
-		}
-	} else {
-		uart->wk_en = NULL;
-		uart->wk_st = NULL;
-		uart->wk_mask = 0;
-	}
+	if (enable)
+		omap_hwmod_enable_wakeup(od->hwmods[0]);
+	else
+		omap_hwmod_disable_wakeup(od->hwmods[0]);
 }
 
 /*
@@ -244,6 +172,8 @@ static void omap_uart_set_forceidle(struct platform_device *pdev)
 }
 
 #else
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
+{}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
 static void omap_uart_set_forceidle(struct platform_device *pdev) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -459,6 +389,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	omap_up.set_forceidle = omap_uart_set_forceidle;
 	omap_up.set_noidle = omap_uart_set_noidle;
+	omap_up.enable_wakeup = omap_uart_enable_wakeup;
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
@@ -493,15 +424,12 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_hwmod_idle(uart->oh);
 
 	omap_device_enable(uart->pdev);
-	omap_uart_idle_init(uart);
-	omap_hwmod_enable_wakeup(uart->oh);
 	omap_device_idle(uart->pdev);
 
 	omap_uart_block_sleep(uart);
 	console_unlock();
 
-	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
-		(pdata->wk_en && pdata->wk_mask))
+	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
 		device_init_wakeup(&pdev->dev, true);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index f9baf01..d58f081 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -69,6 +69,7 @@ struct omap_uart_port_info {
 	u32 (*get_context_loss_count)(struct device *);
 	void (*set_forceidle)(struct platform_device *);
 	void (*set_noidle)(struct platform_device *);
+	void (*enable_wakeup)(struct platform_device *, bool);
 };
 
 struct uart_omap_dma {
@@ -123,6 +124,7 @@ struct uart_omap_port {
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
 	u32			errata;
+	u8			wakeups_enabled;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4d020fb..3101130 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1495,9 +1495,24 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (!up)
 		return -EINVAL;
 
+	if (!pdata->enable_wakeup)
+		return 0;
+
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt = pdata->get_context_loss_count(dev);
 
+	if (device_may_wakeup(dev)) {
+		if (!up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wakeups_enabled = true;
+		}
+	} else {
+		if (up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wakeups_enabled = false;
+		}
+	}
+
 	/* Errata i291 */
 	if (up->use_dma && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
-- 
1.7.4.1

