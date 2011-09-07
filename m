From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 03/11] OMAP2+: UART: cleanup + remove certain uart calls
	from pm code
Date: Wed, 7 Sep 2011 18:23:25 +0530
Message-ID: <1315400013-4849-4-git-send-email-govindraj.raja@ti.com>
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

In preparation to UART runtime conversion. Remove certain uart specific calls
from pm24xx/34xx files. Remove uart pads from 3430 board file.
These func calls will no more be used with upcoming uart runtime design.

1.) omap_uart_can_sleep :- not needed driver can autosuspend based on usage_count
    and autosuspend delay.
2.) omap_uart_prepare_suspend :- can be taken care with driver.
3.) The pad values in 3430 board file are same as the default pad values to be
    updated in serial.c file with uart runtime conversion changes.
    Avoid structure duplication and use default pads.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |  100 +-----------------------------
 arch/arm/mach-omap2/pm24xx.c             |    3 -
 arch/arm/mach-omap2/pm34xx.c             |    5 --
 arch/arm/plat-omap/include/plat/serial.h |    4 -
 4 files changed, 1 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd600cf..b12b38f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -482,106 +482,8 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-
-static struct omap_device_pad serial1_pads[] __initdata = {
-	/*
-	 * Note that off output enable is an active low
-	 * signal. So setting this means pin is a
-	 * input enabled in off mode
-	 */
-	OMAP_MUX_STATIC("uart1_cts.uart1_cts",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rts.uart1_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_rx.uart1_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart1_tx.uart1_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLDOWN |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT |
-			 OMAP_PIN_OFF_INPUT_PULLDOWN |
-			 OMAP_OFFOUT_EN |
-			 OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT |
-			 OMAP_OFF_EN |
-			 OMAP_MUX_MODE0),
-};
-
-static struct omap_board_data serial1_data __initdata = {
-	.id		= 0,
-	.pads		= serial1_pads,
-	.pads_cnt	= ARRAY_SIZE(serial1_pads),
-};
-
-static struct omap_board_data serial2_data __initdata = {
-	.id		= 1,
-	.pads		= serial2_pads,
-	.pads_cnt	= ARRAY_SIZE(serial2_pads),
-};
-
-static struct omap_board_data serial3_data __initdata = {
-	.id		= 2,
-	.pads		= serial3_pads,
-	.pads_cnt	= ARRAY_SIZE(serial3_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init_port(&serial1_data);
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-}
 #else
 #define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
 #endif
 
 /*
@@ -718,7 +620,7 @@ static void __init omap_3430sdp_init(void)
 	else
 		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
 	omap_ads7846_init(1, gpio_pendown, 310, NULL);
-	board_serial_init();
+	omap_serial_init();
 	usb_musb_init(NULL);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e7..39f26af 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -265,8 +265,6 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
@@ -317,7 +315,6 @@ static int omap2_pm_suspend(void)
 	mir1 = omap_readl(0x480fe0a4);
 	omap_writel(1 << 5, 0x480fe0ac);
 
-	omap_uart_prepare_suspend();
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..9f3bf2c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -485,8 +485,6 @@ console_still_active:
 
 int omap3_can_sleep(void)
 {
-	if (!omap_uart_can_sleep())
-		return 0;
 	return 1;
 }
 
@@ -531,7 +529,6 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
 	omap_sram_idle();
@@ -578,14 +575,12 @@ static int omap3_pm_begin(suspend_state_t state)
 {
 	disable_hlt();
 	suspend_state = state;
-	omap_uart_enable_irqs(0);
 	return 0;
 }
 
 static void omap3_pm_end(void)
 {
 	suspend_state = PM_SUSPEND_ON;
-	omap_uart_enable_irqs(1);
 	enable_hlt();
 	return;
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..bfd73b7 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -109,12 +109,8 @@ struct omap_board_data;
 
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
-extern int omap_uart_can_sleep(void);
-extern void omap_uart_check_wakeup(void);
-extern void omap_uart_prepare_suspend(void);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
-extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.7.4.1
