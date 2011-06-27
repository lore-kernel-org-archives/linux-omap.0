From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 16:06:49 +0530
Message-ID: <1309171009-8075-1-git-send-email-premi@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Gregoire Gentil <gregoire@gentil.com>, Hrishikesh Bhandiwad <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, Sanjeev Premi <premi@ti.com>, Thomas Weber <weber@corscience.de>
List-Id: linux-omap@vger.kernel.org

From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>

Present current selection of the GPTIMER on Beagleboard
was result of a hardware issue in early versions of the
Beagleboards (Ax and B1 thru B4). [1][2]

Its been long since the hardware issue has been fixed.
This patch uses GPTIMER 1 for all newer board revisions
incl. Beagleboard XM.

Also, the clock source for GPTIMER12 is much less frequency
stable than clock sources for GPTIMER1. Using GPTIMER12 can
result in major time skew over a fairly short interval.

 [1] http://thread.gmane.org/gmane.comp.hardware.beagleboard.general/91
 [2] Errata #7 at http://elinux.org/BeagleBoard#Errata

Signed-off-by: Sanjeev Premi <premi@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
Cc: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
Cc: Thomas Weber <weber@corscience.de>
Cc: Jason Lam <lzg@ema-tech.com>
Cc: Gregoire Gentil <gregoire@gentil.com>
---

 Changes since v1:
   * Updated description with details from Paul Walmsley.
   * Changed author to Hrishikesh.
   * Expanded cc: to include original authors for other
     boards that are still using GPTIMER12.

 arch/arm/mach-omap2/board-omap3beagle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4b113b2..edc1596 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -509,7 +509,10 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
-	omap2_gp_clockevent_set_gptimer(12);
+	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_AXBX)
+		omap2_gp_clockevent_set_gptimer(12);
+	else
+		omap2_gp_clockevent_set_gptimer(1);
 #endif
 }
 
-- 
1.7.2.2
