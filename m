From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2][PATCH 09/11] omap3: 3630sdp: Explicitly enable all UARTs
Date: Mon,  8 Mar 2010 11:20:52 -0600
Message-ID: <1268068854-13429-10-git-send-email-saaguirre@ti.com>
References: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576Ab0CHRUC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 12:20:02 -0500
In-Reply-To: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

All UARTs seem physically reachable, so, enable them all.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
old mode 100755
new mode 100644
index 4386d2b..399117a
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -96,6 +96,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
+	omap_serial_init();
 	zoom_peripherals_init();
 	board_smc91x_init();
 	enable_board_wakeup_source();
-- 
1.6.3.3

