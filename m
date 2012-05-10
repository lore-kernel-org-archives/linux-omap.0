From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup
Date: Thu, 10 May 2012 18:35:39 +0530
Message-ID: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34283 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab2EJNGP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 09:06:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

The commit (bce492c0  ARM: OMAP2+: UART: Fix incorrect population of
default uart pads) removed default uart pads that where getting populated
and which was making rx pin wakeup capable. If uart pads was used in
different mode by any other module then it would fail since the default
pads took over all the uart pins forcefully. With removal of default pads
the rx_pad wakeup for console uart while waking up from off mode is broken.

Utilise the mux api available to probe the availability of mux pins
in uart mode and probe for availability of uart pin in mux mode0
if uart is available as uart pin itself then configure rx pin
as wakeup capable.

This patch itself doesn't cater to all boards. Boards using uart rx wakeup
mechanism should ensure the usage of omap_serial_init_port by configuring
required uart ports and pass necessary mux data, till then this probing of
uart pins can cater to enabling of rx pad wakeup to most of the boards.

This patch can also throw some boot warning from _omap_mux_get_by_name
if pin is requested for availability is not present while dynamically probing
the uart pins availability such boot warnings can be addressed only when board
files are patched with omap_serial_init_port calls passing the right pads
needed for a given port.

Discussion Threads for reference:
http://www.spinics.net/lists/linux-omap/msg69859.html
http://www.spinics.net/lists/linux-omap/msg68659.html

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Ameya Palande <ameya.palande@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---

Patching of all board files would be difficult as even I am not aware of all
omap-board schematics and uart port usage. So individual board file can be
enabled accordingly for uart usage by calling omap_serial_init_port call
with right mux data.

for testing: Patch based on v3.4-rc6
(tested on beagle-xm for off mode rx wakeup)
Patch targeted for v3.5

 arch/arm/mach-omap2/mux.c    |    3 +-
 arch/arm/mach-omap2/mux.h    |   10 ++++++
 arch/arm/mach-omap2/serial.c |   65 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 6 deletions(-)

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
index 9fc2f44..c097317 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -57,6 +57,7 @@ struct omap_uart_state {
 
 	struct list_head node;
 	struct omap_hwmod *oh;
+	struct omap_device_pad default_omap_uart_pads[2];
 };
 
 static LIST_HEAD(uart_list);
@@ -126,11 +127,68 @@ static void omap_uart_set_smartidle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
-static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
+
+#define OMAP_UART_DEFAULT_PAD_NAME_LEN	28
+static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
+		tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN] __initdata;
+
+static void  __init
+omap_serial_fill_uart_tx_rx_pads(struct omap_board_data *bdata,
+				struct omap_uart_state *uart)
+{
+	uart->default_omap_uart_pads[0].name = rx_pad_name;
+	uart->default_omap_uart_pads[0].flags = OMAP_DEVICE_PAD_REMUX |
+							OMAP_DEVICE_PAD_WAKEUP;
+	uart->default_omap_uart_pads[0].enable = OMAP_PIN_INPUT |
+							OMAP_MUX_MODE0;
+	uart->default_omap_uart_pads[0].idle = OMAP_PIN_INPUT | OMAP_MUX_MODE0;
+	uart->default_omap_uart_pads[1].name = tx_pad_name;
+	uart->default_omap_uart_pads[1].enable = OMAP_PIN_OUTPUT |
+							OMAP_MUX_MODE0;
+	bdata->pads = uart->default_omap_uart_pads;
+	bdata->pads_cnt = ARRAY_SIZE(uart->default_omap_uart_pads);
+}
+
+static void  __init omap_serial_check_wakeup(struct omap_board_data *bdata,
+						struct omap_uart_state *uart)
 {
+	struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
+	struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
+	char *rx_fmt, *tx_fmt;
+	int uart_nr = bdata->id + 1;
+
+	if (bdata->id != 2) {
+		rx_fmt = "uart%d_rx.uart%d_rx";
+		tx_fmt = "uart%d_tx.uart%d_tx";
+	} else {
+		rx_fmt = "uart%d_rx_irrx.uart%d_rx_irrx";
+		tx_fmt = "uart%d_tx_irtx.uart%d_tx_irtx";
+	}
+
+	snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_fmt,
+			uart_nr, uart_nr);
+	snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_fmt,
+			uart_nr, uart_nr);
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
+		if (!(rx_mode & 0x07) && !(tx_mode & 0x07))
+			omap_serial_fill_uart_tx_rx_pads(bdata, uart);
+	}
 }
 #else
-static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
+static void __init omap_serial_check_wakeup(struct omap_board_data *bdata
+		struct omap_uart_state *uart) {}
 #endif
 
 char *cmdline_find_option(char *str)
@@ -295,8 +353,7 @@ void __init omap_serial_board_init(struct omap_uart_port_info *info)
 		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
 
-		if (cpu_is_omap44xx() || cpu_is_omap34xx())
-			omap_serial_fill_default_pads(&bdata);
+		omap_serial_check_wakeup(&bdata, uart);
 
 		if (!info)
 			omap_serial_init_port(&bdata, NULL);
-- 
1.7.9

