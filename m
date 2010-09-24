From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC 4/5] OMAP4: mux: Select CBL package for SDP4430 with ES1
Date: Fri, 24 Sep 2010 11:15:47 +0200
Message-ID: <1285319748-28976-5-git-send-email-b-cousson@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab0IXJQB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 05:16:01 -0400
In-Reply-To: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/board-4430sdp.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 6aede64..4a8f897 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -240,6 +240,7 @@ config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
 	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBL
 
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..d087712 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,6 +35,8 @@
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+
+#include "mux.h"
 #include "hsmmc.h"
 
 #define ETH_KS8851_IRQ			34
@@ -426,10 +428,20 @@ static int __init omap4_i2c_init(void)
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
 static void __init omap_4430sdp_init(void)
 {
 	int status;
 
+	omap4_mux_init(board_mux, OMAP_PACKAGE_CBL);
 	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
-- 
1.6.0.4

