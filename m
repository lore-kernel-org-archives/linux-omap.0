From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 4/7] omap3: zoom2/3 / 3630sdp: Don't init always all uarts
Date: Mon, 15 Mar 2010 18:04:09 -0500
Message-ID: <1268694252-21985-5-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49260 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386Ab0COXCd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 19:02:33 -0400
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This is useless, since in Zoom2/3 boards, the ports aren't even
physically accessible.

They must be explicitly initted in the board-zoom2.c, board-zoom3.c
and board-3630sdp.c files instead.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index ca95d8d..6b39849 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -280,7 +280,6 @@ static void enable_board_wakeup_source(void)
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
-	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
 }
-- 
1.6.3.3

