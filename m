From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge][PATCH 07/10] omap3: zoom2/3 / 3630sdp: Don't init always all uarts
Date: Wed,  3 Mar 2010 08:18:42 -0600
Message-ID: <1267625925-22616-8-git-send-email-saaguirre@ti.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559Ab0CCOSf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 09:18:35 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23EIYNL025857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:18:34 -0600
In-Reply-To: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
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

