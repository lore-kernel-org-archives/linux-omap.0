From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part2 v1][PATCH 3/4] omap3: 3630sdp: Explicitly enable all UARTs
Date: Mon,  1 Mar 2010 12:55:53 -0600
Message-ID: <1267469754-10638-4-git-send-email-saaguirre@ti.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42414 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab0CASzj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Mar 2010 13:55:39 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o21Itd6b020648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Mar 2010 12:55:39 -0600
In-Reply-To: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

All UARTs seem physically reachable, so, enable them all.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
old mode 100755
new mode 100644
index 4386d2b..35df894
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -96,6 +96,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
+	omap_serial_init_allports();
 	zoom_peripherals_init();
 	board_smc91x_init();
 	enable_board_wakeup_source();
-- 
1.6.3.3

