From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 7/8] OMAP4: pandaboard: Select CBL & CBS package and initialize mux
Date: Tue, 16 Nov 2010 21:55:36 +0100
Message-ID: <1289940937-31593-8-git-send-email-b-cousson@ti.com>
References: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52115 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab0KPU4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 15:56:06 -0500
In-Reply-To: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, sricharan <r.sricharan@ti.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: sricharan <r.sricharan@ti.com>

The mux framework allows the change of pad configuration by drivers
when needed. Prior to this the mux framework has to be initialised
with all the mux parameters specific to the board. The mux init is
already present in the board file for SDP. Adding the mux init
for panda boards.

Signed-off-by: sricharan <r.sricharan@ti.com>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig            |    2 ++
 arch/arm/mach-omap2/board-omap4panda.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 39229cf..186d270 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -290,6 +290,8 @@ config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
 	default y
 	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBL
+	select OMAP_PACKAGE_CBS
 
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..801f814 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,6 +40,7 @@
 
 #include "hsmmc.h"
 #include "control.h"
+#include "mux.h"
 
 #define GPIO_HUB_POWER		1
 #define GPIO_HUB_NRESET		62
@@ -368,8 +369,23 @@ static int __init omap4_panda_i2c_init(void)
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap4_panda_init(void)
 {
+	int package = OMAP_PACKAGE_CBS;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		package = OMAP_PACKAGE_CBL;
+	omap4_mux_init(board_mux, package);
+
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	omap_serial_init();
-- 
1.7.0.4

