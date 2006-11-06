From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc4-omap] omap GP timer:  HZ != 100
Date: Mon, 6 Nov 2006 10:17:27 -0800
Message-ID: <200611061017.28116.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Teach OMAP2 gp timer that HZ isn't always 100.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -65,7 +65,7 @@ static void __init omap2_gp_timer_init(v
 	BUG_ON(gptimer == NULL);
 
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
-	tick_period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / 100;
+	tick_period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
 	tick_period -= 1;
 
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
