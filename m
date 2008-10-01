From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] CPUidle: increment state counter for state actually entered
Date: Wed,  1 Oct 2008 13:47:04 +0300
Message-ID: <1222858024-20369-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:55371 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbYJAKrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:47:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so357568fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 01 Oct 2008 03:47:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org

Currently, the count for state that the governor chooses is always
incremented after the 'state_enter' hook is called.  However, the
target's enter hook may choose a different state based on BM activity
or other factors.

This patch does the accounting use 'dev->last_state' state instead of
the governor-chosen state.  If the target's enter_idle hook enters a
different state than it was asked, it should update dev->last_state.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/cpuidle/cpuidle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 5ce07b5..c1294f5 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -67,10 +67,10 @@ static void cpuidle_idle_call(void)
 	target_state = &dev->states[next_state];
 
 	/* enter the state and update stats */
-	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
-	target_state->time += (unsigned long long)dev->last_residency;
-	target_state->usage++;
+	dev->last_residency = target_state->enter(dev, target_state);
+	dev->last_state->time += (unsigned long long)dev->last_residency;
+	dev->last_state->usage++;
 
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
-- 
1.6.0

