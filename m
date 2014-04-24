From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 16/26] ARM: OMAP2+: timer: Fix error message to not use hwmod
 structure
Date: Thu, 24 Apr 2014 16:43:59 -0500
Message-ID: <1398375849-6017-17-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

oh->name is no longer used, correct the error message.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4fcfd7a..519ccfd 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -331,8 +331,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (clk_get_parent(timer->fclk) != src) {
 		r = clk_set_parent(timer->fclk, src);
 		if (r < 0) {
-			pr_warn("%s: %s cannot set source\n", __func__,
-				oh->name);
+			pr_warn("%s: cannot set timer's source\n", __func__);
+			WARN_ON(1);
 			clk_put(src);
 			return r;
 		}
-- 
1.7.9.5
