From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 4/8] ARM: l2c: shorten warning about incorrect associativity
Date: Wed, 29 Oct 2014 10:22:57 +0100
Message-ID: <1414574581-2320-5-git-send-email-m.szyprowski@samsung.com>
References: <1414574581-2320-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414574581-2320-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

Warning message about missing/incorrect associativity was a bit too
long, so shorten it to fit a single line.

Suggested-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/cache-l2x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ad981894de73..83b36f3b415c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1200,8 +1200,8 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
 		break;
 	default:
-		pr_err("PL310 OF: cache setting yield illegal associativity\n");
-		pr_err("PL310 OF: %d calculated, only 8 and 16 legal\n", assoc);
+		pr_err("L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n",
+		       assoc);
 		break;
 	}
 }
-- 
1.9.2
