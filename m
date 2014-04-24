From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 17/26] ARM: OMAP2+: timer: Add fallback for of_clk_get
Date: Thu, 24 Apr 2014 16:44:00 -0500
Message-ID: <1398375849-6017-18-git-send-email-joelf@ti.com>
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

Not all platforms currently will support of_clk_get on timer
because they may not have clock property in their DT nodes. Add
code to handle this case so that things are kept working. Finally
we can delete this code once all system timer nodes have a clock
property.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 519ccfd..b3db1da 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -277,13 +277,19 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
-		timer->fclk = of_clk_get(np, 0);
-		if (IS_ERR(timer->fclk))
-			return PTR_ERR(timer->fclk);
-
 		r = omap_dmtimer_powerup(np);
 		if (r)
 			return r;
+
+		timer->fclk = of_clk_get(np, 0);
+		if (IS_ERR(timer->fclk)) {
+			/*
+			 * Support DT platforms temporarily that don't have
+			 * clock property in their dts yet. Ultimately this
+			 * fall back code is to be deleted and we're to return
+			 * PTR_ERR(timer->fclk) here.
+			 */
+		}
 	} else {
 		if (omap_dm_timer_reserve_systimer(timer->id))
 			return -ENODEV;
@@ -312,12 +318,17 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
+		omap_hwmod_setup_one(oh_name);
+		omap_hwmod_enable(oh);
+	}
+
+	if (!timer->fclk || IS_ERR(timer->fclk)) {
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh)
+			return -ENODEV;
 		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 		if (IS_ERR(timer->fclk))
 			return PTR_ERR(timer->fclk);
-
-		omap_hwmod_setup_one(oh_name);
-		omap_hwmod_enable(oh);
 	}
 
 	/*
-- 
1.7.9.5
