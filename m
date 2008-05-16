From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 02/10] 34XX: PM: Workaround for uart clocks
Date: Fri, 16 May 2008 14:04:56 +0300
Message-ID: <1210935896-27937-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59207 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYEPLFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:07 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB50CT003216
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:04 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This patch is needed until we have uart driver which disables uart
clocks when they are not needed.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1826dcd..e578503 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <asm/arch/pm.h>
 #include <asm/arch/clockdomain.h>
 #include <asm/arch/powerdomain.h>
+#include <asm/arch/common.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -197,8 +198,12 @@ static void omap_sram_idle(void)
 	 * handles fcks correctly */
 	per_gpio_clk_disable();
 
+	omap_serial_enable_clocks(0);
+
 	_omap_sram_idle(NULL, save_state);
 
+	omap_serial_enable_clocks(1);
+
 	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
 	 * handles fcks correctly */
 	per_gpio_clk_enable();
-- 
1.5.5

