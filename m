From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part2 v1][PATCH 2/4] omap3: zoom2/3 / 3630sdp: Don't init always all uarts
Date: Mon,  1 Mar 2010 12:55:52 -0600
Message-ID: <1267469754-10638-3-git-send-email-saaguirre@ti.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab0CASzj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Mar 2010 13:55:39 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o21ItcLt024059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Mar 2010 12:55:39 -0600
In-Reply-To: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This is useless, since in Zoom2/3 boards, the ports aren't even
physically accessible.

They must be explicitly initted in the board-zoom2.c, board-zoom3.c
and board-3630sdp.c files instead.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index a1011ee..6b39849 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -280,7 +280,6 @@ static void enable_board_wakeup_source(void)
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
-	omap_serial_init_allports();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
 }
-- 
1.6.3.3

