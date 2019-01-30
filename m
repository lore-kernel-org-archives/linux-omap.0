From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] PM/runtime: Optimize pm_runtime_autosuspend_expiration()
Date: Wed, 30 Jan 2019 22:40:17 +0100
Message-ID: <20190130214017.GA5038@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

pm_runtime_autosuspend_expiration calls ktime_get_mono_fast_ns
even when its returned value may be unused. Therefore get
current time later and remove gotos while there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 This patch is based on top of bleeding-edge branch, where
 "[PATCH v2 ] PM-runtime: fix deadlock with ktime" is sitting.
 I expect v3 of that patch, which should not harm this one.
 It is meant to replace "PM/runtime: Do not needlessly call ktime_get"
 sent earlier.

 drivers/base/power/runtime.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 65e2b5f48e0c..7bbe28faca8d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -145,24 +145,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
 u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
-	u64 last_busy, expires = 0;
-	u64 now = ktime_get_mono_fast_ns();
+	u64 expires;
 
 	if (!dev->power.use_autosuspend)
-		goto out;
+		return 0;
 
 	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
 	if (autosuspend_delay < 0)
-		goto out;
-
-	last_busy = READ_ONCE(dev->power.last_busy);
+		return 0;
 
-	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
-	if (expires <= now)
-		expires = 0;	/* Already expired. */
+	expires  = READ_ONCE(dev->power.last_busy);
+	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
+	if (expires > ktime_get_mono_fast_ns())
+		return expires;	/* Expires in the future */
 
- out:
-	return expires;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
 
-- 
2.20.1
