From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 5/5] ARM: OMAP1: recalibrate loops per jiffy after dpll1 reprogram
Date: Sun, 27 Nov 2011 04:32:31 +0100
Message-ID: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56369 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab1K0DmI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Nov 2011 22:42:08 -0500
In-Reply-To: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>

Otherwise timing is not accurate, resulting in devices which depend
on it, like omap-keypad, broken.

Created against linux-3.2-rc2.
Depends on patch "init: allow for recalibration of loops per jiffy".
Tested on top of linux-omap/fixes on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sameer Nanda <snanda@chromium.org>
---
 arch/arm/mach-omap1/clock_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 201b1f2..7fa6b8b 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
@@ -942,4 +943,5 @@ void __init omap1_clk_late_init(void)
 	}
 	propagate_rate(&ck_dpll1);
 	omap1_show_rates();
+	recalibrate_delay();
 }
-- 
1.7.3.4

