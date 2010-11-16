From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 6/8] OMAP4: sdp4430: Select CBS package for ES2
Date: Tue, 16 Nov 2010 21:55:35 +0100
Message-ID: <1289940937-31593-7-git-send-email-b-cousson@ti.com>
References: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57033 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512Ab0KPU4H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 15:56:07 -0500
In-Reply-To: <1289940937-31593-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Select the CBS package if SDP4430 is enabled during config.
Use the proper package (CBL or CBS) based on chip revision.

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
index e4f1726..94d989b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -517,8 +517,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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

