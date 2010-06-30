From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/16] omap: mux: Select POP package for N8X0
Date: Wed, 30 Jun 2010 15:07:02 +0300
Message-ID: <20100630120702.2637.12923.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51864 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab0F3MGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:52 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Select POP package for N8X0

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig      |    1 +
 arch/arm/mach-omap2/board-n8x0.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 269f84f..4158368 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -120,6 +120,7 @@ config MACH_NOKIA_N810_WIMAX
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on ARCH_OMAP2420
+	select OMAP_PACKAGE_ZAC
 	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 3ccc34e..5b9bbdc 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -33,6 +33,8 @@
 #include <plat/mmc.h>
 #include <plat/serial.h>
 
+#include "mux.h"
+
 static int slot1_cover_open;
 static int slot2_cover_open;
 static struct device *mmc_device;
@@ -649,8 +651,17 @@ static void __init n8x0_init_irq(void)
 	omap_gpio_init();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init n8x0_init_machine(void)
 {
+	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 	/* FIXME: add n810 spi devices */
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));

