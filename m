From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap1: fix build when !CONFIG_OMAP_32K_TIMER
Date: Mon, 13 Jan 2014 12:03:57 -0600
Message-ID: <1389636237-2998-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46896 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbaAMSFX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 13:05:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

If CONFIG_OMAP_32K_TIMER isn't enabled, we will
try to use enable_dyn_sleep which wasn't defined
anywhere.

In order to fix the problem, we always define
enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 40a1ae3..dbee729 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,7 +71,11 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
-#ifdef CONFIG_OMAP_32K_TIMER
+#ifndef CONFIG_OMAP_32K_TIMER
+
+static unsigned short enable_dyn_sleep = 0;
+
+#else
 
 static unsigned short enable_dyn_sleep = 1;
 
-- 
1.8.5.2

