From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC v2 5/7] OMAP4: mux: Select CBL package for SDP4430 with ES1
Date: Wed, 20 Oct 2010 00:22:34 +0200
Message-ID: <1287526956-21853-6-git-send-email-b-cousson@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab0JSWXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 18:23:40 -0400
In-Reply-To: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/board-4430sdp.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e14c73d..7efb256 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -280,6 +280,7 @@ config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
 	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBL
 
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index aafd306..83ee5b4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,6 +35,7 @@
 #include <plat/usb.h>
 #include <plat/mmc.h>
 
+#include "mux.h"
 #include "hsmmc.h"
 #include "timer-gp.h"
 #include "control.h"
@@ -500,10 +501,19 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
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
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-- 
1.7.0.4

