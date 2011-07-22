From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH] PM / Runtime: allow _put_sync() from interrupts-disabled context
Date: Fri, 22 Jul 2011 14:17:11 -0700
Message-ID: <1311369431-28775-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42985 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932211Ab1GVVQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 17:16:57 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so4285759pzk.16
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 14:16:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@google.com>, Nishanth Menon <nm@ti.com>

Currently the use of pm_runtime_put_sync() is not safe from
interrupts-disabled context because rpm_idle() will release the
spinlock and enable interrupts for the idle callbacks.  This enables
interrupts during a time where interrupts were expected to be
disabled, and can have strange side effects on drivers that expected
interrupts to be disabled.

This is not a bug since the documentation clearly states that only
_put_sync_suspend() is safe in IRQ-safe mode.

However, pm_runtime_put_sync() could be made safe when in IRQ-safe
mode by releasing the spinlock but not re-enabling interrupts, which
is what this patch aims to do.

Problem was found when using some buggy drivers that set
pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
context.

The offending drivers have been fixed to use _put_sync_suspend(),
But this patch is an RFC to see if it might make sense to allow
using _put_sync() from interrupts-disabled context.

Reported-by: Colin Cross <ccross@google.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/base/power/runtime.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8dc247c..acb3f83 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -226,11 +226,17 @@ static int rpm_idle(struct device *dev, int rpmflags)
 		callback = NULL;
 
 	if (callback) {
-		spin_unlock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_unlock(&dev->power.lock);
+		else
+			spin_unlock_irq(&dev->power.lock);
 
 		callback(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_lock(&dev->power.lock);
+		else
+			spin_lock_irq(&dev->power.lock);
 	}
 
 	dev->power.idle_notification = false;
-- 
1.7.6

