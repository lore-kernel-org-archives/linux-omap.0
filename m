From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem
Date: Fri, 27 May 2011 17:33:59 -0700
Message-ID: <1306542839-5688-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40428 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757549Ab1E1A1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 20:27:42 -0400
Received: by mail-pv0-f173.google.com with SMTP id 3so1058059pvg.4
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 17:27:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>

Some platforms wish to implement their PM core suspend code as
modules.  To do so, these functions need to be exported to modules.

Reported-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies against v2.6.39

 kernel/power/suspend.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6275970..eca495d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 	suspend_ops = ops;
 	mutex_unlock(&pm_mutex);
 }
+EXPORT_SYMBOL(suspend_set_ops);
 
 bool valid_state(suspend_state_t state)
 {
@@ -65,6 +66,7 @@ int suspend_valid_only_mem(suspend_state_t state)
 {
 	return state == PM_SUSPEND_MEM;
 }
+EXPORT_SYMBOL(suspend_valid_only_mem);
 
 static int suspend_test(int level)
 {
-- 
1.7.4

