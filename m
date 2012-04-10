From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup
Date: Tue, 10 Apr 2012 19:10:46 +0530
Message-ID: <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54735 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab2DJNlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 09:41:22 -0400
In-Reply-To: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

Default pad populating procedure should first probe whether the uart
pins are available as uart tx/rx pins if yes then we can configure them
and use rx pin for wakeup capability.

Utilise the mux api available to probe the availability of mux pins
in uart mode.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c    |    3 +-
 arch/arm/mach-omap2/mux.h    |   10 +++++++
 arch/arm/mach-omap2/serial.c |   56 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 65c3391..d937ddd 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -217,8 +217,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
 	return -ENODEV;
 }
 
-static int __init
-omap_mux_get_by_name(const char *muxname,
+int __init omap_mux_get_by_name(const char *muxname,
 			struct omap_mux_partition **found_partition,
 			struct omap_mux **found_mux)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 69fe060..68927f1 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
 
+int omap_mux_get_by_name(const char *muxname,
+		struct omap_mux_partition **found_partition,
+		struct omap_mux **found_mux);
 #else
 
+static inline int omap_mux_get_by_name(const char *muxname,
+		struct omap_mux_partition **found_partition,
+		struct omap_mux **found_mux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1554233..7bb971e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -120,11 +120,63 @@ static void omap_uart_set_smartidle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
-static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
+
+#define OMAP_UART_DEFAULT_PAD_NAME_LEN	28
+static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
+		tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN] __initdata;
+static struct omap_device_pad default_omap_uart_pads[2] __initdata;
+
+static void  __init omap_serial_fill_default_pads(struct omap_board_data *bdata)
 {
+	struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
+	struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
+
+	if (bdata->id != 2) {
+		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			 "uart%d_rx.uart%d_rx", bdata->id + 1, bdata->id + 1);
+		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			 "uart%d_tx.uart%d_tx", bdata->id + 1, bdata->id + 1);
+	} else {
+		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			"uart%d_rx_irrx.uart%d_rx_irrx", bdata->id + 1,
+			bdata->id + 1);
+		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			"uart%d_tx_irtx.uart%d_tx_irtx", bdata->id + 1,
+			bdata->id + 1);
+	}
+
+	if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_mux) >= 0 &&
+			omap_mux_get_by_name
+				(tx_pad_name, &tx_partition, &tx_mux) >= 0) {
+		u16 tx_mode, rx_mode;
+
+		tx_mode = omap_mux_read(tx_partition, tx_mux->reg_offset);
+		rx_mode = omap_mux_read(rx_partition, rx_mux->reg_offset);
+
+		/*
+		 * Check if uart is used in default tx/rx mode i.e. in mux mode0
+		 * if yes then configure rx pin for wake up capability
+		 */
+		if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
+			default_omap_uart_pads[0].name = rx_pad_name;
+			default_omap_uart_pads[0].flags  =
+				OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
+			default_omap_uart_pads[0].enable = OMAP_PIN_INPUT |
+								OMAP_MUX_MODE0;
+			default_omap_uart_pads[0].idle = OMAP_PIN_INPUT |
+								OMAP_MUX_MODE0;
+
+			default_omap_uart_pads[1].name = tx_pad_name;
+			default_omap_uart_pads[1].enable = OMAP_PIN_OUTPUT |
+								OMAP_MUX_MODE0;
+			bdata->pads = default_omap_uart_pads;
+			bdata->pads_cnt = ARRAY_SIZE(default_omap_uart_pads);
+		}
+	}
 }
 #else
-static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
+static void __init omap_serial_fill_default_pads(struct omap_board_data *bdata)
+{}
 #endif
 
 char *cmdline_find_option(char *str)
-- 
1.7.9

