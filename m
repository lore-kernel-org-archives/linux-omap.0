From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v4][PATCH 09/11] omap3: 3630sdp: Explicitly enable all UARTs
Date: Wed, 10 Mar 2010 18:14:22 -0600
Message-ID: <1268266464-15702-10-git-send-email-saaguirre@ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932953Ab0CKANZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Mar 2010 19:13:25 -0500
In-Reply-To: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

All UARTs seem physically reachable, so, enable them all.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
old mode 100755
new mode 100644
index a0a2a11..504d2bd
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

