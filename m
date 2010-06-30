From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/16] omap: mux: Select POP package for Apollon
Date: Wed, 30 Jun 2010 15:06:59 +0300
Message-ID: <20100630120659.2637.21973.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57562 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab0F3MGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:47 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org

Select POP package for Apollon

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/board-apollon.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b59cdb7..269f84f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -56,6 +56,7 @@ config MACH_OMAP_H4
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2
+	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 987b24d..b86a879 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -42,6 +42,8 @@
 #include <plat/gpmc.h>
 #include <plat/control.h>
 
+#include "mux.h"
+
 /* LED & Switch macros */
 #define LED0_GPIO13		13
 #define LED1_GPIO14		14
@@ -309,10 +311,20 @@ static void __init apollon_usb_init(void)
 	omap2_usbfs_init(&apollon_usb_config);
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_apollon_init(void)
 {
 	u32 v;
 
+	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
+
 	apollon_led_init();
 	apollon_flash_init();
 	apollon_usb_init();

