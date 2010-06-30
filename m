From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/16] omap: mux: Select SIP package for H4
Date: Wed, 30 Jun 2010 15:06:55 +0300
Message-ID: <20100630120655.2637.13954.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51669 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0F3MGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:44 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Select SIP package for H4

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig    |    1 +
 arch/arm/mach-omap2/board-h4.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d3932d3..b59cdb7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -50,6 +50,7 @@ config MACH_OMAP2_TUSB6010
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2
+	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 54a231c..8c58f51 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -42,6 +42,8 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 
+#include "mux.h"
+
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
 
@@ -338,8 +340,18 @@ static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 	},
 };
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_h4_init(void)
 {
+	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAF);
+
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on

