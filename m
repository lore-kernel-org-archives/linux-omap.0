From: Chen Baozi <baozich@gmail.com>
Subject: [PATCH] ARM: fix wrong address when loading PRM_FRAC_INCREMENTOR_DENUMERATOR_RELOAD
Date: Wed,  7 Aug 2013 22:05:21 +0800
Message-ID: <1375884321-30489-1-git-send-email-baozich@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Chen Baozi <baozich@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The denominator should be load from INCREMENTOR_DENUMERATOR_RELOAD_OFFSET
rather than INCREMENTER_NUMERATOR_OFFSET.

This is more likely a typo, since INCREMENTER_DENUMERATOR_RELOAD[23:17] is
reserved. It seems that it won't make much trouble without this fix, because
the useful [11:0] bits are mask and set the right value. Anyway, reading
from a right address is better choice.

Signed-off-by: Chen Baozi <baozich@gmail.com>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1e77f11..ccc5c72 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -537,7 +537,7 @@ static void __init realtime_counter_init(void)
 	reg |= num;
 	__raw_writel(reg, base + INCREMENTER_NUMERATOR_OFFSET);
 
-	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
+	reg = __raw_readl(base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET) &
 			NUMERATOR_DENUMERATOR_MASK;
 	reg |= den;
 	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
-- 
1.8.1.4
