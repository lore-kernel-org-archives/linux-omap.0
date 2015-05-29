From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] PM / Wakeirq: Fix typo in prototype for dev_pm_set_dedicated_wake_irq
Date: Fri, 29 May 2015 09:54:02 -0700
Message-ID: <1432918442-2043-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:40394 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964784AbbE2QyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 12:54:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Looks like I only built test the dev_pm_set_wake_irq and not the
dev_pm_set_dedicated_wake_irq case on x86.

Turns out there's a typo for the dev_pm_set_dedicated_wake_irq
prototype that causes a build error if CONFIG_COMPILE_TEST
and CONFIG_MMC_OMAP_HS are selected.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/pm_wakeirq.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index 4046fa1..cd5b62d 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -30,8 +30,7 @@ static inline int dev_pm_set_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
-static inline int dev_pm_set_dedicated__wake_irq(struct device *dev,
-						 int irq)
+static inline int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 {
 	return 0;
 }
-- 
2.1.4

