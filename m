From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Fix OFF mode on HS/EMU Devices
Date: Tue, 21 Jul 2009 18:28:27 +0300
Message-ID: <1248190107-21703-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62876 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZGUP3K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 11:29:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Defer calling omap3_save_scratchpad_contents() to after
omap3_secure_ram_storage has been initialized. This fixes
lockup & reboot while entering CORE OFF mode on HS/EMU devices.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e80d59f..14f10bc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1101,7 +1101,6 @@ static int __init omap3_pm_init(void)
 
 	pm_idle = omap3_pm_idle;
 
-	omap3_save_scratchpad_contents();
 	omap3_idle_init();
 
 	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
@@ -1131,6 +1130,7 @@ static int __init omap3_pm_init(void)
 		local_fiq_enable();
 	}
 
+	omap3_save_scratchpad_contents();
 err1:
 	return ret;
 err2:
-- 
1.6.0.4

