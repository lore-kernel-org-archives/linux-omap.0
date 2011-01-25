From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap2+: Fix omap_serial_early_init to work with init_early
 hook
Date: Mon, 24 Jan 2011 18:25:28 -0800
Message-ID: <20110125022528.GI13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110124202629.GE13589@atomide.com>
 <20110124215213.GA27044@n2100.arm.linux.org.uk>
 <20110125022119.GG13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15814 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab1AYCZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 21:25:43 -0500
Content-Disposition: inline
In-Reply-To: <20110125022119.GG13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The new init_early hook happens at the end of setup_arch,
which is too early for kzalloc. However, there's no need
to call omap_serial_early_init that early, so fix this
by setting it up as a core_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8f47609..5678c33 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -400,8 +400,6 @@ void __init omap2_init_common_infrastructure(void)
 void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
-	omap_serial_early_init();
-
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 302da74..539ec9c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -655,7 +655,7 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 #endif
 
-void __init omap_serial_early_init(void)
+static int __init omap_serial_early_init(void)
 {
 	int i = 0;
 
@@ -672,7 +672,7 @@ void __init omap_serial_early_init(void)
 
 		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
 		if (WARN_ON(!uart))
-			return;
+			return -ENODEV;
 
 		uart->oh = oh;
 		uart->num = i++;
@@ -691,7 +691,10 @@ void __init omap_serial_early_init(void)
 		 */
 		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
 	} while (1);
+
+	return 0;
 }
+core_initcall(omap_serial_early_init);
 
 /**
  * omap_serial_init_port() - initialize single serial port
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index cec5d56..a1a118d 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -96,7 +96,6 @@
 
 struct omap_board_data;
 
-extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
