From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 56/59] omap: namespace cleanup to arch/arm/plat-omap/include/mach/pm.h
Date: Wed, 12 Nov 2008 00:57:15 +0200
Message-ID: <1226444238-14614-57-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
 <1226444238-14614-49-git-send-email-me@felipebalbi.com>
 <1226444238-14614-50-git-send-email-me@felipebalbi.com>
 <1226444238-14614-51-git-send-email-me@felipebalbi.com>
 <1226444238-14614-52-git-send-email-me@felipebalbi.com>
 <1226444238-14614-53-git-send-email-me@felipebalbi.com>
 <1226444238-14614-54-git-send-email-me@felipebalbi.com>
 <1226444238-14614-55-git-send-email-me@felipebalbi.com>
 <1226444238-14614-56-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43144 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYKKXOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:14:52 -0500
In-Reply-To: <1226444238-14614-56-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/pm.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index e4cf1c5..d87e507 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -171,28 +171,28 @@ extern void omap_serial_wake_trigger(int enable);
 #define omap_serial_wake_trigger(x)	{}
 #endif	/* CONFIG_OMAP_SERIAL_WAKE */
 
-#define ARM_SAVE(x) arm_sleep_save[ARM_SLEEP_SAVE_##x] = omap_readl(x)
-#define ARM_RESTORE(x) omap_writel((arm_sleep_save[ARM_SLEEP_SAVE_##x]), (x))
+#define ARM_SAVE(x) arm_sleep_save[ARM_SLEEP_SAVE_##x] = __raw_readl(x)
+#define ARM_RESTORE(x) __raw_writel((arm_sleep_save[ARM_SLEEP_SAVE_##x]), (x))
 #define ARM_SHOW(x) arm_sleep_save[ARM_SLEEP_SAVE_##x]
 
 #define DSP_SAVE(x) dsp_sleep_save[DSP_SLEEP_SAVE_##x] = __raw_readw(x)
 #define DSP_RESTORE(x) __raw_writew((dsp_sleep_save[DSP_SLEEP_SAVE_##x]), (x))
 #define DSP_SHOW(x) dsp_sleep_save[DSP_SLEEP_SAVE_##x]
 
-#define ULPD_SAVE(x) ulpd_sleep_save[ULPD_SLEEP_SAVE_##x] = omap_readw(x)
-#define ULPD_RESTORE(x) omap_writew((ulpd_sleep_save[ULPD_SLEEP_SAVE_##x]), (x))
+#define ULPD_SAVE(x) ulpd_sleep_save[ULPD_SLEEP_SAVE_##x] = __raw_readw(x)
+#define ULPD_RESTORE(x) __raw_writew((ulpd_sleep_save[ULPD_SLEEP_SAVE_##x]), (x))
 #define ULPD_SHOW(x) ulpd_sleep_save[ULPD_SLEEP_SAVE_##x]
 
-#define MPUI730_SAVE(x) mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x] = omap_readl(x)
-#define MPUI730_RESTORE(x) omap_writel((mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x]), (x))
+#define MPUI730_SAVE(x) mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x] = __raw_readl(x)
+#define MPUI730_RESTORE(x) __raw_writel((mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x]), (x))
 #define MPUI730_SHOW(x) mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x]
 
-#define MPUI1510_SAVE(x) mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x] = omap_readl(x)
-#define MPUI1510_RESTORE(x) omap_writel((mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x]), (x))
+#define MPUI1510_SAVE(x) mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x] = __raw_readl(x)
+#define MPUI1510_RESTORE(x) __raw_writel((mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x]), (x))
 #define MPUI1510_SHOW(x) mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x]
 
-#define MPUI1610_SAVE(x) mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x] = omap_readl(x)
-#define MPUI1610_RESTORE(x) omap_writel((mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]), (x))
+#define MPUI1610_SAVE(x) mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x] = __raw_readl(x)
+#define MPUI1610_RESTORE(x) __raw_writel((mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]), (x))
 #define MPUI1610_SHOW(x) mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_##x]
 
 /*
-- 
1.6.0.2.307.gc427

