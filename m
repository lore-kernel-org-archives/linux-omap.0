From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 3/9] OMAP: Devkit8000: Fix typo in pin name
Date: Wed, 24 Mar 2010 13:52:12 +0100
Message-ID: <1269435138-27192-4-git-send-email-weber@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
In-Reply-To: <1269435138-27192-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Replace wrong sdr_cke[01] with sdrc_cke[01].

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index fb0f2f8..cf90fe0 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -676,8 +676,8 @@ static void __init devkit8000_init(void)
 	devkit8000_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_mux_init_signal("sdr_cke0", OMAP_PIN_OUTPUT);
-	omap_mux_init_signal("sdr_cke1", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
 static void __init devkit8000_map_io(void)
-- 
1.6.4.4

