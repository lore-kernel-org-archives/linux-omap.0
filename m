From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v4][PATCH 08/11] omap3: zoom2/3 / 3630sdp: Don't init always all uarts
Date: Wed, 10 Mar 2010 18:14:21 -0600
Message-ID: <1268266464-15702-9-git-send-email-saaguirre@ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49037 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948Ab0CKANV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Mar 2010 19:13:21 -0500
In-Reply-To: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

This is useless, since in Zoom2/3 boards, the ports aren't even
physically accessible.

They must be explicitly initted in the board-zoom2.c, board-zoom3.c
and board-3630sdp.c files instead.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
old mode 100755
new mode 100644
index ca95d8d..6b39849
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

