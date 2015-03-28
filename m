From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] mfd: menelaus: delete omap_has_menelaus
Date: Sat, 28 Mar 2015 22:45:35 +0200
Message-ID: <1427575537-28508-2-git-send-email-aaro.koskinen@iki.fi>
References: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Delete unused macro.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/linux/mfd/menelaus.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelaus.h
index f097e89..a1e12bf3 100644
--- a/include/linux/mfd/menelaus.h
+++ b/include/linux/mfd/menelaus.h
@@ -38,10 +38,4 @@ extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV);
 
 extern int menelaus_set_regulator_sleep(int enable, u32 val);
 
-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_MENELAUS)
-#define omap_has_menelaus()	1
-#else
-#define omap_has_menelaus()	0
-#endif
-
 #endif
-- 
2.2.0
