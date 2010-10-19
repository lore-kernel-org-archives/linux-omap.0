From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC v2 7/7] OMAP4: mux: Select CBS package for SDP4430 with ES2
Date: Wed, 20 Oct 2010 00:22:36 +0200
Message-ID: <1287526956-21853-8-git-send-email-b-cousson@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37298 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756327Ab0JSWXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 18:23:47 -0400
In-Reply-To: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/Kconfig         |    1 +
 arch/arm/mach-omap2/board-4430sdp.c |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 92fea63..39229cf 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -284,6 +284,7 @@ config MACH_OMAP_4430SDP
 	default y
 	depends on ARCH_OMAP4
 	select OMAP_PACKAGE_CBL
+	select OMAP_PACKAGE_CBS
 
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 83ee5b4..323b62e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -512,8 +512,12 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_4430sdp_init(void)
 {
 	int status;
+	int package = OMAP_PACKAGE_CBS;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		package = OMAP_PACKAGE_CBL;
+	omap4_mux_init(board_mux, package);
 
-	omap4_mux_init(board_mux, OMAP_PACKAGE_CBL);
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-- 
1.7.0.4

