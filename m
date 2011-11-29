From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
Date: Tue, 29 Nov 2011 01:25:32 +0100
Message-ID: <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Otherwise timing is inaccurate, resulting in devices which depend on 
delay(), like omap-keypad, broken.

Created and tested on top of linux-omap/fixes on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
Hi,
This version no longer depends on changes to init/calibrate.c, using the
method kindly advised by Russell instead.  Then, patch 4/5 can be
dropped.

However, the result of cpufreq_scale() differs from that of
(re)calibrate_delay() by ca. 6%, i.e., 70.40 vs. 74.54. Please advise if
this approximation is acceptable.

Thanks, 
Janusz


 arch/arm/mach-omap1/clock_data.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 201b1f2..e616042 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -16,6 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
@@ -928,7 +930,9 @@ int __init omap1_clk_init(void)
 
 void __init omap1_clk_late_init(void)
 {
-	if (ck_dpll1.rate >= OMAP1_DPLL1_SANE_VALUE)
+	unsigned long rate = ck_dpll1.rate;
+
+	if (rate >= OMAP1_DPLL1_SANE_VALUE)
 		return;
 
 	/* Find the highest supported frequency and enable it */
@@ -942,4 +946,5 @@ void __init omap1_clk_late_init(void)
 	}
 	propagate_rate(&ck_dpll1);
 	omap1_show_rates();
+	loops_per_jiffy = cpufreq_scale(loops_per_jiffy, rate, ck_dpll1.rate);
 }
-- 
1.7.3.4
