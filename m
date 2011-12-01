From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2 v2] ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
Date: Thu,  1 Dec 2011 21:13:02 +0100
Message-ID: <1322770382-30718-3-git-send-email-jkrzyszt@tis.icnet.pl>
References: <201112012023.04635.jkrzyszt@tis.icnet.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201112012023.04635.jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

Otherwise timing is inaccurate, resulting in devices which depend on it,
like omap-keypad, broken.

Created and tested on top of linux-omap/fixes on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
* was 5/5 v2, rebased on 1/2.

 arch/arm/mach-omap1/clock_data.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index b001299..0ef1e7d 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -16,6 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
@@ -927,7 +929,9 @@ int __init omap1_clk_init(void)
 
 void __init omap1_clk_late_init(void)
 {
-	if (ck_dpll1.rate >= OMAP1_DPLL1_SANE_VALUE)
+	unsigned long rate = ck_dpll1.rate;
+
+	if (rate >= OMAP1_DPLL1_SANE_VALUE)
 		return;
 
 	/* Find the highest supported frequency and enable it */
@@ -939,4 +943,5 @@ void __init omap1_clk_late_init(void)
 	}
 	propagate_rate(&ck_dpll1);
 	omap1_show_rates();
+	loops_per_jiffy = cpufreq_scale(loops_per_jiffy, rate, ck_dpll1.rate);
 }
-- 
1.7.3.4
