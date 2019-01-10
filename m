From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] PM/runtime: Do not needlessly call ktime_get
Date: Thu, 10 Jan 2019 10:51:25 +0100
Message-ID: <20190110095125.GA4491@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990946AbfAJJv1YEa7P (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Thu, 10 Jan 2019 10:51:27 +0100
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

pm_runtime_autosuspend_expiration calls ktime_get even when
its returned value may be unused. Therefore get current time
later and remove gotos while there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 NOTE: Depends on Vincent's "[PATCH v2] PM/runtime: Fix autosuspend_delay
       on 32bits arch"!

 drivers/base/power/runtime.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03b744d..836b1b8784eb 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -129,24 +129,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
 u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
-	u64 last_busy, expires = 0;
-	u64 now = ktime_to_ns(ktime_get());
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
+	if (expires > ktime_to_ns(ktime_get()))
+		return expires;	/* Expires in the future */
 
- out:
-	return expires;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
 
-- 
2.20.1
