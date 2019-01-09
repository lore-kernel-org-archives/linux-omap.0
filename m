From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Wed,  9 Jan 2019 03:16:28 +0100
Message-ID: <1547000188-2732-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com
Cc: Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
-- 
2.7.4
