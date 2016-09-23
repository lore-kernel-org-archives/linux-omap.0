From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] omapfb: use complete() instead complete_all()
Date: Fri, 23 Sep 2016 13:33:22 +0200
Message-ID: <1474630402-11514-1-git-send-email-wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Daniel Wagner <daniel.wagner@bmw-carit.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

There is only one waiter for the completion, therefore there
is no need to use complete_all(). Let's make that clear by
using complete() instead of complete_all().

While we are at it, we also change the init_completion() to
reinit_completion() which slightly lighter.

The usage pattern of the completion is:

waiter context                          waker context

dss_mgr_disable_compat()
  mutex_lock(apply_lock)
  wait_pending_extra_info_updates()
    reinit_completion()
    wait_for_completion_timeout()
  mutex_unlock(apply_lock)

dss_ovl_unset_manager()
  mutex_lock(apply_lock)
  wait_pending_extra_info_updates()
    reinit_completion()
    wait_for_completion_timeout()
  mutex_unlock(apply_lock)

					dss_apply_irq_handler()
					  complete()

Furthermore dss_mgr_disable_compat(), dss_ovl_unset_manager and
dss_apply_irq_handler() are serialized via the data_lock spinlock. That
means the reinit_completion() and complete() call do not race.  The only
problem there could be the ordering of those two functions. It is not
clear to me if that is enforced by the hardware or the design of the
driver. Given the fact this has been in place since years, it should
just work as before.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/omap2/omapfb/dss/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/apply.c b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
index 2481f48..f345aa9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/apply.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
@@ -413,7 +413,7 @@ static void wait_pending_extra_info_updates(void)
 		return;
 	}
 
-	init_completion(&extra_updated_completion);
+	reinit_completion(&extra_updated_completion);
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
@@ -922,7 +922,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 
 	extra_updating = extra_info_update_ongoing();
 	if (!extra_updating)
-		complete_all(&extra_updated_completion);
+		complete(&extra_updated_completion);
 
 	/* call framedone handlers for manual update displays */
 	for (i = 0; i < num_mgrs; i++) {
-- 
2.7.4
