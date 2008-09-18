From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-0] OMAP3: PM: Remove extra prcm save from idle loop
Date: Thu, 18 Sep 2008 11:18:14 +0300
Message-ID: <1221725894-26877-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25143 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYIRIQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 04:16:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

Prcm registers are saved two times in case of core OFF. First one can
be removed.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1b0272d..e8a47a5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -304,7 +304,6 @@ void omap_sram_idle(void)
 					OMAP3430_GR_MOD,
 					OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_save_core_ctx();
-			omap3_save_prcm_ctx();
 			omap_save_uart_ctx(0);
 			omap_save_uart_ctx(1);
 		}
-- 
1.5.5

