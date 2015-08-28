From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix booting if no timer parent clock is available
Date: Fri, 28 Aug 2015 12:06:16 -0700
Message-ID: <1440788776-19978-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When bringing up a new SoC we needlessly prevent booting at timer
init if timer clock_set_parent fails. This can fail if the system
is booting on bootloader configured PLL values until the clock
framework driver for the PLL is implemented.

Let's just WARN instead, this will provide helpful information
for anybody bringing up a new SoC what needs to be fixed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e4d8701..a556551 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -297,12 +297,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
-	r = clk_set_parent(timer->fclk, src);
-	if (r < 0) {
-		pr_warn("%s: %s cannot set source\n", __func__, oh->name);
-		clk_put(src);
-		return r;
-	}
+	WARN(clk_set_parent(timer->fclk, src) < 0,
+	     "Cannot set timer parent clock, no PLL clock driver?");
 
 	clk_put(src);
 
-- 
2.1.4
