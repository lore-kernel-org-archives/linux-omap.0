From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Mon, 6 Jul 2015 13:01:18 -0500
Message-ID: <1436205678-31640-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tmlind@atomide.com>
List-Id: linux-omap@vger.kernel.org

on a first call to dev_pm_attach_wake_irq(), if it
fails, it will leave dev->power.wakeirq set to a
dangling pointer. Instead, let's clear it to make
sure a subsequent call to dev_pm_attach_wake_irq()
has chance to succeed.

Cc: Tony Lindgren <tmlind@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/base/power/wakeirq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 7470004ca810..394d250a1ad8 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev, int irq,
 
 	err = device_wakeup_attach_irq(dev, wirq);
 	if (err)
-		return err;
+		goto err_cleanup;
 
 	return 0;
+
+err_cleanup:
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.wakeirq = NULL;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return err;
 }
 
 /**
-- 
2.4.4
