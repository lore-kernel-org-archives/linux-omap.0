From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH] usb: musb: use put_sync_suspend instead of put_sync
Date: Thu, 4 Aug 2011 16:40:11 -0500
Message-ID: <1312494011-18745-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53386 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1HDVp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 17:45:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, ccross@google.com, balbi@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@suse.de, Axel Haslam <axelhaslam@ti.com>, Moiz Sonasath <m-sonasath@ti.com>

From: Axel Haslam <axelhaslam@ti.com>

As Documented in runtime documentation, drivers can call put_sync
in contexts where sleep is allowed, in contexts where sleep is not
possible, the drivers need to mark these as to be made interrupt
safe and also use put_sync_suspend instead of put_sync as the idle
callbacks will be called with interrupt enabled - which is not
a good thing to happen in isr context.

BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:798
in_atomic(): 0, irqs_disabled(): 0, pid: 44, name: irq/164-fsa9480
Backtrace:
[<c00520f0>] (dump_backtrace+0x0/0x110) from [<c059c1bc>] (dump_stack+0x18/0x1c)
r6:de41bcd8 r5:ffff72b6 r4:ffff6f03 r3:60000113
[<c059c1a4>] (dump_stack+0x0/0x1c) from [<c007e370>] (__might_sleep+0x130/0x134)
[<c007e240>] (__might_sleep+0x0/0x134) from [<c02b2cc0>] (__pm_runtime_resume+0x94/0x98)
r5:00000004 r4:de58a408
[<c02b2c2c>] (__pm_runtime_resume+0x0/0x98) from [<c0367b30>] (musb_otg_notifications+0x90/0x140)
r7:c07c8220 r6:de41bcd8 r5:c0760494 r4:de41b000
[<c0367aa0>] (musb_otg_notifications+0x0/0x140) from [<c00b2bc8>] (notifier_call_chain+0x4c/0x8c)
r5:00000000 r4:ffffffff
[<c00b2b7c>] (notifier_call_chain+0x0/0x8c) from [<c00b3280>] (__atomic_notifier_call_chain+0x40/0x54)
r8:00000004 r7:00000001 r6:de41bcd8 r5:ffffffff r4:c078ca38

A call to pm_runtime_irq_safe, will indefently prevent the parent
from sleeping by doing a call to get-sync on the parent.
this is "to prevent a irq-safe child to wait for a non-irq safe parent."
For this reason, the parent runtime-pm suspend is blocked, and we dont let L3 and
CORE enter into low power.

As a workaround, we call the parent runtime functions on the child
runtime hooks, for this to work, the parent has to be set to
ignere children, otherwise, even with a "timmed"  autosuspend call,
will return BUSY, as the child is not yet suspended.

This patch is based off:
https://lkml.org/lkml/2011/7/20/357

Signed-off-by: Axel Haslam <axelhaslam@ti.com>
Reported-by: Colin Cross <ccross@google.com>
Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
---
 drivers/usb/musb/musb_core.c   |    9 +++++++++
 drivers/usb/musb/musb_gadget.c |    2 +-
 drivers/usb/musb/omap2430.c    |    4 +++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c71b037..d22bc73 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1941,7 +1941,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	pm_runtime_use_autosuspend(musb->controller);
 	pm_runtime_set_autosuspend_delay(musb->controller, 200);
+	pm_runtime_use_autosuspend(musb->controller->parent);
+	pm_runtime_set_autosuspend_delay(musb->controller->parent, 500);
+	pm_suspend_ignore_children(musb->controller->parent,true);
 	pm_runtime_enable(musb->controller);
+	pm_runtime_irq_safe(musb->controller);
 
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
@@ -2375,6 +2379,9 @@ static int musb_runtime_suspend(struct device *dev)
 
 	musb_save_context(musb);
 
+	pm_runtime_mark_last_busy(musb->controller->parent);
+	pm_runtime_put_autosuspend(musb->controller->parent);
+
 	return 0;
 }
 
@@ -2392,6 +2399,8 @@ static int musb_runtime_resume(struct device *dev)
 	 * Also context restore without save does not make
 	 * any sense
 	 */
+	if (pm_runtime_suspended(dev->parent))
+		pm_runtime_get_sync(dev->parent);
 	if (!first)
 		musb_restore_context(musb);
 	first = 0;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 548338c..d5d8f3a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1710,7 +1710,7 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	pm_runtime_put(musb->controller);
+	pm_runtime_put_sync_suspend(musb->controller);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c5d4c44..8b6888d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -471,6 +471,7 @@ static int __init omap2430_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	return 0;
 
@@ -516,7 +517,8 @@ static int omap2430_runtime_resume(struct device *dev)
 	struct musb			*musb = glue_to_musb(glue);
 
 	omap2430_low_level_init(musb);
-	otg_set_suspend(musb->xceiv, 0);
+	if (musb->xceiv)
+		otg_set_suspend(musb->xceiv, 0);
 
 	return 0;
 }
-- 
1.6.0.4

