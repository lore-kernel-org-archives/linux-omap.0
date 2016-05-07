From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions when
 not needed.
Date: Sat,  7 May 2016 18:21:46 +0300
Message-ID: <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com
Cc: devicetree@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

once omap_dm_timer_start() is called, which calls omap_dm_timer_enable()
and thus pm_runtime_get_sync(), it doesn't make sense to call PM runtime
functions again before omap_dm_timer_stop is called(). Otherwise PM runtime
functions called in omap_dm_timer_enable/disable lead to long and unneeded
delays.

Fix that by implementing an "enabled" counter, so the PM runtime functions
get called only when really needed.

Without that patch Nokia N900 IR TX driver (ir-rx51) does not function.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/plat-omap/dmtimer.c              | 9 ++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7a327bd..f35a78c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -365,6 +365,9 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
 	int c;
 
+	if (timer->enabled++)
+		return;
+
 	pm_runtime_get_sync(&timer->pdev->dev);
 
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
@@ -383,7 +386,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
-	pm_runtime_put_sync(&timer->pdev->dev);
+	if (timer->enabled == 1)
+		pm_runtime_put_sync(&timer->pdev->dev);
+
+	if (timer->enabled)
+		timer->enabled--;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dd79f30..fc984e1 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -114,6 +114,7 @@ struct omap_dm_timer {
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
+	u32 enabled;
 	struct timer_regs context;
 	int (*get_context_loss_count)(struct device *);
 	int ctx_loss_count;
-- 
1.9.1
