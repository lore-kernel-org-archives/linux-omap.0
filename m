From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] PM / Runtime: Update last_busy in rpm_resume
Date: Wed, 13 May 2015 16:36:32 -0700
Message-ID: <1431560196-5722-2-git-send-email-tony@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i572.relay.mailchannels.net ([46.232.183.126]:34212
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754387AbbEMXhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2015 19:37:16 -0400
In-Reply-To: <1431560196-5722-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

If we don't update last_busy in rpm_resume, devices can go back
to sleep immediately after resume. This happens at least in
cases where the device has been powered off and does not have
any interrupt pending until there's something in the FIFO.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4f..4ffe4a2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -741,6 +741,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	} else {
  no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
+		pm_runtime_mark_last_busy(dev);
 		if (parent)
 			atomic_inc(&parent->power.child_count);
 	}
-- 
2.1.4

