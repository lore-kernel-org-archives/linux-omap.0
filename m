From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: omap3_pm_get_suspend_state() error ignored in pwrdm_suspend_get()
Date: Wed, 16 Dec 2009 17:22:04 +0100
Message-ID: <4B29092C.4040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934987AbZLPQUW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linu>
List-Id: linux-omap@vger.kernel.org

val is an u64 pointer, we need an int to check the error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 860b755..081ca85 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -488,9 +488,11 @@ int pm_dbg_regset_init(int reg_set)
 
 static int pwrdm_suspend_get(void *data, u64 *val)
 {
-	*val = omap3_pm_get_suspend_state((struct powerdomain *)data);
+	int ret;
+	ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
+	*val = ret;
 
-	if (*val >= 0)
+	if (ret >= 0)
 		return 0;
 	return *val;
 }
