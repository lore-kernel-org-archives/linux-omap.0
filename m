From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 20/21] OMAP2+: UART: Avoid uart idling on suspend for no_console_suspend usecase
Date: Tue, 18 Oct 2011 21:05:40 +0530
Message-ID: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

If no_console_suspend is used we have prevent uart idling during suspend
to provide debug prints.

Power domain hooks can idle uarts if left enabled during system wide suspend
so re-use the omap_device_disable_idle_on_suspend API's to ensure console_uart
is not idled during suspend.

omap_device_disable_idle_on_suspend API was used on all uarts since the uart
driver was not runtime adapted, now with runtime adaptation we can re-use this
API only for no_console_suspend use cases.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 55903f0..5e3bbce 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -64,6 +64,7 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id = -1;
+static u8 no_console_suspend;
 
 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -308,6 +309,10 @@ static int __init omap_serial_early_init(void)
 
 		if (cmdline_find_option(uart_name)) {
 			console_uart_id = uart->num;
+
+			if (cmdline_find_option("no_console_suspend"))
+				no_console_suspend = true;
+
 			/*
 			 * omap-uart can be used for earlyprintk logs
 			 * So if omap-uart is used as console then prevent
@@ -400,7 +405,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 		od->pm_lats = console_uart_latency;
 	}
 
-	omap_device_disable_idle_on_suspend(pdev);
+	if (no_console_suspend)
+		omap_device_disable_idle_on_suspend(pdev);
+
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
 	uart->pdev = pdev;
-- 
1.7.4.1

