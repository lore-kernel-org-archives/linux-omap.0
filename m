From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH-v4.2-rc6 4/5] arm: omap2: timer: simplify
 omap4_local_timer_init()
Date: Mon, 10 Aug 2015 16:41:50 -0500
Message-ID: <1439242911-715-5-git-send-email-balbi@ti.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439242911-715-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

all users of omap4_local_timer_init() are already
DT-only, so we can remove the check for having
DTB or not.

While at that, fix a typo in comment.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cac46d852da1..88d39f98e7ff 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -649,23 +649,15 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() != OMAP4430_REV_ES1_0) {
-		int err;
 
-		if (of_have_populated_dt()) {
-			clocksource_of_init();
-			return;
-		}
+	/* Local timers are not supported on OMAP4430 ES1.0 */
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;
 
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
-	}
+	clocksource_of_init();
 }
 #else
 void __init omap4_local_timer_init(void)
-- 
2.5.0
