From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5] ARM: OMAP: Simplify dmtimer context-loss handling
Date: Tue, 19 Mar 2013 12:38:15 -0500
Message-ID: <1363714699-29622-2-git-send-email-jon-hunter@ti.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

The context loss handling in dmtimer appears to assume that
omap_dm_timer_set_load_start() or omap_dm_timer_start() and
omap_dm_timer_stop() bracket all interactions.  Only the first two
restore the context and the last updates the context loss counter.
However omap_dm_timer_set_load() or omap_dm_timer_set_match() can
reasonably be called outside this bracketing, and the fact that they
call omap_dm_timer_enable() / omap_dm_timer_disable() suggest that
is expected.

So if, after a transition into and out of off-mode which would cause
the dm timer to loose all state, omap_dm_timer_set_match() is called
before omap_dm_timer_start(), the value read from OMAP_TIMER_CTRL_REG
will be 'wrong' and this wrong value will be stored context.tclr so
a subsequent omap_dm_timer_start() can fail (As the control register
is wrong).

Simplify this be doing the restore-from-context in
omap_dm_timer_enable() so that whenever the timer is enabled, the
context is correct. Also update the ctx_loss_count at the same time as
we notice it is wrong - these is no value in delaying this until the
omap_dm_timer_disable() as it cannot change while the timer is enabled.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
[jon-hunter-l0cyMroinI0@public.gmane.org: minor update to subject and changed variable name]
Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/dmtimer.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index a0daa2f..5cae1dd 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -315,7 +315,19 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	int c;
+
 	pm_runtime_get_sync(&timer->pdev->dev);
+
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
+		if (timer->get_context_loss_count) {
+			c = timer->get_context_loss_count(&timer->pdev->dev);
+			if (c != timer->ctx_loss_count) {
+				omap_timer_restore_context(timer);
+				timer->ctx_loss_count = c;
+			}
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
@@ -410,13 +422,6 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		if (timer->get_context_loss_count &&
-			timer->get_context_loss_count(&timer->pdev->dev) !=
-				timer->ctx_loss_count)
-			omap_timer_restore_context(timer);
-	}
-
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
@@ -441,12 +446,6 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		if (timer->get_context_loss_count)
-			timer->ctx_loss_count =
-				timer->get_context_loss_count(&timer->pdev->dev);
-	}
-
 	/*
 	 * Since the register values are computed and written within
 	 * __omap_dm_timer_stop, we need to use read to retrieve the
@@ -553,13 +552,6 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 
 	omap_dm_timer_enable(timer);
 
-	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		if (timer->get_context_loss_count &&
-			timer->get_context_loss_count(&timer->pdev->dev) !=
-				timer->ctx_loss_count)
-			omap_timer_restore_context(timer);
-	}
-
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
-- 
1.7.10.4
