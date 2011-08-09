From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH] OMAP3: am3517crane: remove NULL board_mux from board file
Date: Tue,  9 Aug 2011 18:28:25 +0200
Message-ID: <1312907305-24134-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50472 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1HIQ2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 12:28:52 -0400
Received: by fxh19 with SMTP id 19so188419fxh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 09:28:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Since 7203f8a48bb63015ebe58a6f2a38aec1cb208b9d (arm: mach-omap2: remove
NULL board_mux from board files) NULL board_mux is defined in mux.h.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 5f2b55f..933e935 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -45,8 +45,6 @@ static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
 #endif
 
 static void __init am3517_crane_init_early(void)
-- 
1.7.6

