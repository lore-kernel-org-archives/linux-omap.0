From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] omap2+: Use omap_device_board_data for platform
 level serial init
Date: Wed, 22 Dec 2010 18:51:10 -0800
Message-ID: <20101223025110.GJ7771@atomide.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
 <20101203004528.31687.93327.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57732 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0LWCvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 21:51:15 -0500
Content-Disposition: inline
In-Reply-To: <20101203004528.31687.93327.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101202 16:35]:
> This is needed to pass board specific data such as pads used.

Here's this one updated to not use omap_device_build.

Regards,

Tony


Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Dec 22 18:42:35 2010 -0800

    omap2+: Add struct omap_board_data and use it for platform level serial init
    
    This is needed to pass board specific data such as pads used to the
    platform level driver init code.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index c9ec50d..a4ab17a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -87,6 +87,20 @@
 #define OMAP_MUX_GPIO_IN_MODE3		(1 << 1)
 
 /**
+ * struct omap_board_data - board specific device data
+ * @id: instance id
+ * @flags: additional flags for platform init code
+ * @pads: array of device specific pads
+ * @pads_cnt: ARRAY_SIZE() of pads
+ */
+struct omap_board_data {
+	int			id;
+	u32			flags;
+	struct omap_device_pad	*pads;
+	int			pads_cnt;
+};
+
+/**
  * struct mux_partition - contain partition related information
  * @name: name of the current partition
  * @flags: flags specific to this partition
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c8740ba..c645788 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -45,6 +45,7 @@
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
 #include "control.h"
+#include "mux.h"
 
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
@@ -694,16 +695,16 @@ void __init omap_serial_early_init(void)
 
 /**
  * omap_serial_init_port() - initialize single serial port
- * @port: serial port number (0-3)
+ * @bdata: port specific board data pointer
  *
- * This function initialies serial driver for given @port only.
+ * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
  * if they don't plan to use all available UARTs as serial ports.
  *
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(int port)
+void __init omap_serial_init_port(struct omap_board_data *bdata)
 {
 	struct omap_uart_state *uart;
 	struct omap_hwmod *oh;
@@ -721,13 +722,15 @@ void __init omap_serial_init_port(int port)
 	struct omap_uart_port_info omap_up;
 #endif
 
-	if (WARN_ON(port < 0))
+	if (WARN_ON(!bdata))
 		return;
-	if (WARN_ON(port >= num_uarts))
+	if (WARN_ON(bdata->id < 0))
+		return;
+	if (WARN_ON(bdata->id >= num_uarts))
 		return;
 
 	list_for_each_entry(uart, &uart_list, node)
-		if (port == uart->num)
+		if (bdata->id == uart->num)
 			break;
 
 	oh = uart->oh;
@@ -799,6 +802,8 @@ void __init omap_serial_init_port(int port)
 	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
+	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
+
 	uart->irq = oh->mpu_irqs[0].irq;
 	uart->regshift = 2;
 	uart->mapbase = oh->slaves[0]->addr->pa_start;
@@ -856,7 +861,14 @@ void __init omap_serial_init_port(int port)
 void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
+	struct omap_board_data bdata;
 
-	list_for_each_entry(uart, &uart_list, node)
-		omap_serial_init_port(uart->num);
+	list_for_each_entry(uart, &uart_list, node) {
+		bdata.id = uart->num;
+		bdata.flags = 0;
+		bdata.pads = NULL;
+		bdata.pads_cnt = 0;
+		omap_serial_init_port(&bdata);
+
+	}
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 19145f5..cec5d56 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -93,9 +93,12 @@
 			})
 
 #ifndef __ASSEMBLER__
+
+struct omap_board_data;
+
 extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
-extern void omap_serial_init_port(int port);
+extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
