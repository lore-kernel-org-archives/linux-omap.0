From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Thu, 10 Jan 2019 10:00:40 +0100
Message-ID: <1547110840-15396-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com, ladis@linux-mips.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires or slack will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v1:
- add u64 cast for slack computation

 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..76d0676 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
@@ -525,7 +525,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 				 * We add a slack of 25% to gather wakeups
 				 * without sacrificing the granularity.
 				 */
-				u64 slack = READ_ONCE(dev->power.autosuspend_delay) *
+				u64 slack = (u64)READ_ONCE(dev->power.autosuspend_delay) *
 						    (NSEC_PER_MSEC >> 2);
 
 				dev->power.timer_expires = expires;
-- 
2.7.4
