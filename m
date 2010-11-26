From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH] arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
Date: Fri, 26 Nov 2010 20:06:02 +0300
Message-ID: <1290791163-21190-1-git-send-email-segoon@openwall.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

clk_get() returns ERR_PTR() on error, not NULL.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested at all.

 arch/arm/plat-omap/counter_32k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 155fe43..c1e0d00 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -164,7 +164,7 @@ static int __init omap_init_clocksource_32k(void)
 			return -ENODEV;
 
 		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
-		if (sync_32k_ick)
+		if (!IS_ERR(sync_32k_ick))
 			clk_enable(sync_32k_ick);
 
 		clocksource_32k.mult = clocksource_hz2mult(32768,
-- 
1.7.0.4
