From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Tue, 07 Jul 2015 01:13:21 +0200
Message-ID: <2783932.o7RC7vMDHB@vostro.rjw.lan>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1436205678-31640-1-git-send-email-balbi@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tmlind@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Monday, July 06, 2015 01:01:18 PM Felipe Balbi wrote:
> on a first call to dev_pm_attach_wake_irq(), if it
> fails, it will leave dev->power.wakeirq set to a
> dangling pointer. Instead, let's clear it to make
> sure a subsequent call to dev_pm_attach_wake_irq()
> has chance to succeed.
> 
> Cc: Tony Lindgren <tmlind@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/base/power/wakeirq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 7470004ca810..394d250a1ad8 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev, int irq,
>  
>  	err = device_wakeup_attach_irq(dev, wirq);
>  	if (err)
> -		return err;
> +		goto err_cleanup;
>  
>  	return 0;
> +
> +err_cleanup:
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	dev->power.wakeirq = NULL;
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +	return err;
>  }

Too many labels for me and the fact that acquiring of the lock again in the error
patch doesn't look good.

However, we can do the entire device_wakeup_attach_irq() under the lock (after
removing the locking from it), because we're its only caller.

So what about the below instead (build-tested only)?

Rafael


---
 drivers/base/power/wakeirq.c |   12 +++++-------
 drivers/base/power/wakeup.c  |   31 ++++++++++---------------------
 2 files changed, 15 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/base/power/wakeirq.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeirq.c
+++ linux-pm/drivers/base/power/wakeirq.c
@@ -45,14 +45,12 @@ static int dev_pm_attach_wake_irq(struct
 		return -EEXIST;
 	}
 
-	dev->power.wakeirq = wirq;
-	spin_unlock_irqrestore(&dev->power.lock, flags);
-
 	err = device_wakeup_attach_irq(dev, wirq);
-	if (err)
-		return err;
+	if (!err)
+		dev->power.wakeirq = wirq;
 
-	return 0;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	return err;
 }
 
 /**
@@ -105,10 +103,10 @@ void dev_pm_clear_wake_irq(struct device
 		return;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
+	device_wakeup_detach_irq(dev);
 	dev->power.wakeirq = NULL;
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
-	device_wakeup_detach_irq(dev);
 	if (wirq->dedicated_irq)
 		free_irq(wirq->irq, wirq);
 	kfree(wirq);
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -281,32 +281,25 @@ EXPORT_SYMBOL_GPL(device_wakeup_enable);
  * Attach a device wakeirq to the wakeup source so the device
  * wake IRQ can be configured automatically for suspend and
  * resume.
+ *
+ * Call under the device's power.lock lock.
  */
 int device_wakeup_attach_irq(struct device *dev,
 			     struct wake_irq *wakeirq)
 {
 	struct wakeup_source *ws;
-	int ret = 0;
 
-	spin_lock_irq(&dev->power.lock);
 	ws = dev->power.wakeup;
 	if (!ws) {
 		dev_err(dev, "forgot to call call device_init_wakeup?\n");
-		ret = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
-	if (ws->wakeirq) {
-		ret = -EEXIST;
-		goto unlock;
-	}
+	if (ws->wakeirq)
+		return -EEXIST;
 
 	ws->wakeirq = wakeirq;
-
-unlock:
-	spin_unlock_irq(&dev->power.lock);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -314,20 +307,16 @@ unlock:
  * @dev: Device to handle
  *
  * Removes a device wakeirq from the wakeup source.
+ *
+ * Call under the device's power.lock lock.
  */
 void device_wakeup_detach_irq(struct device *dev)
 {
 	struct wakeup_source *ws;
 
-	spin_lock_irq(&dev->power.lock);
 	ws = dev->power.wakeup;
-	if (!ws)
-		goto unlock;
-
-	ws->wakeirq = NULL;
-
-unlock:
-	spin_unlock_irq(&dev->power.lock);
+	if (ws)
+		ws->wakeirq = NULL;
 }
 
 /**

