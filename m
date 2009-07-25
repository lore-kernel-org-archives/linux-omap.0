From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2: N800: Fix compilation after recent omap2_init_common_hw()
 changes
Date: Fri, 24 Jul 2009 20:31:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907242031030.2700@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbZGYCb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:31:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jpihet@mvista.com>


This patch is intended to be applied after the 2.6.31-rc OMAP2/3 
SDRC/clock fixes series is merged to mainline.  Since N800 support is not 
yet in mainline, this chunk had to be split out from Jean's original patch 
into a linux-omap specific patch.

Update board-n800.c after recent omap2_init_common_hw() changes.

This code was written by Jean Pihet <jpihet@mvista.com>.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-n800.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 23296e9..fee6c62 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -64,7 +64,7 @@ struct omap_tmp105_config {
 
 void __init nokia_n800_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 
-- 
1.6.3.3.334.g916e1


