From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Mon, 14 Nov 2016 12:52:43 -0800
Message-ID: <20161114205243.GU7138@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
 <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161111202650.GI7138@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161111 12:27]:
> * Linus Walleij <linus.walleij@linaro.org> [161111 12:17]:
> > On Tue, Oct 25, 2016 at 11:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > I don't see why this is necessary?
> 
> It's needed because the pin controller driver has not yet
> finished it's probe at this point. We end up calling functions
> in the device driver where no struct pinctrl_dev is yet known
> to the driver. Asking a device driver to do something before
> it's probe is done does not quite follow the Linux driver model :)
> 
> > The hogging was placed inside pinctrl_register() so that any hogs
> > would be taken before it returns, so nothing else can take it
> > before the controller itself has the first chance. This semantic
> > needs to be preserved I think.
> > 
> > > +       schedule_delayed_work(&pctldev->hog_work,
> > > +                                     msecs_to_jiffies(100));
> > 
> > If we arbitrarily delay, something else can go in and take the
> > pins used by the hogs before the pinctrl core? That is what
> > we want to avoid.
> > 
> > Hm, 100ms seems arbitrarily chosen BTW. Can it be 1 ms?
> > 1 ns?
> 
> Yeah well seems like it should not matter but the race we need
> to remove somehow.
> 
> > I'm pretty sure that whatever it is that needs to happen before
> > the hog work runs can race with this delayed work under
> > some circumstances (such as slow external expanders
> > on i2c). It should be impossible for that to happen
> > and I don't think it is?
> 
> Yes it's totally possible even with delay set to 0.
> 
> Maybe we could add some trigger on the first consumer request
> and if that does not happen use the timer?

Below is what I came up with for removing the race for hogs. We
can do it by not registering the pctldev until in the deferred
work, does that seem OK to you?

Regards,

Tony

8<-----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 25 Oct 2016 08:33:35 -0700
Subject: [PATCH] pinctrl: core: Use delayed work for hogs

Having the pin control framework call pin controller functions
before it's probe has finished is not nice as the pin controller
device driver does not yet have struct pinctrl_dev handle.

Let's fix this issue by adding deferred work for late init. This is
needed to be able to add pinctrl generic helper functions that expect
to know struct pinctrl_dev handle. Note that we now need to call
create_pinctrl() directly as we don't want to add the pin controller
to the list of controllers until the hogs are claimed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.c | 66 ++++++++++++++++++++++++++++++--------------------
 drivers/pinctrl/core.h |  2 ++
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1911,6 +1911,43 @@ static int pinctrl_check_ops(struct pinctrl_dev *pctldev)
 }
 
 /**
+ * pinctrl_late_init() - finish pin controller device registration
+ * @work: work struct
+ */
+static void pinctrl_late_init(struct work_struct *work)
+{
+	struct pinctrl_dev *pctldev;
+
+	pctldev = container_of(work, struct pinctrl_dev, late_init.work);
+
+	pctldev->p = create_pinctrl(pctldev->dev);
+	if (IS_ERR(pctldev->p))
+		return;
+
+	kref_get(&pctldev->p->users);
+
+	pctldev->hog_default =
+		pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(pctldev->hog_default)) {
+		dev_dbg(pctldev->dev, "failed to lookup the default state\n");
+	} else {
+		if (pinctrl_select_state(pctldev->p, pctldev->hog_default))
+			dev_err(pctldev->dev, "failed to select default state\n");
+	}
+
+	pctldev->hog_sleep = pinctrl_lookup_state(pctldev->p,
+						  PINCTRL_STATE_SLEEP);
+	if (IS_ERR(pctldev->hog_sleep))
+		dev_dbg(pctldev->dev, "failed to lookup the sleep state\n");
+
+	mutex_lock(&pinctrldev_list_mutex);
+	list_add_tail(&pctldev->node, &pinctrldev_list);
+	mutex_unlock(&pinctrldev_list_mutex);
+
+	pinctrl_init_device_debugfs(pctldev);
+}
+
+/**
  * pinctrl_register() - register a pin controller device
  * @pctldesc: descriptor for this pin controller
  * @dev: parent device for this pin controller
@@ -1941,6 +1978,7 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	INIT_RADIX_TREE(&pctldev->pin_group_tree, GFP_KERNEL);
 	INIT_RADIX_TREE(&pctldev->pin_function_tree, GFP_KERNEL);
 	INIT_LIST_HEAD(&pctldev->gpio_ranges);
+	INIT_DELAYED_WORK(&pctldev->late_init, pinctrl_late_init);
 	pctldev->dev = dev;
 	mutex_init(&pctldev->mutex);
 
@@ -1975,32 +2013,7 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 		goto out_err;
 	}
 
-	mutex_lock(&pinctrldev_list_mutex);
-	list_add_tail(&pctldev->node, &pinctrldev_list);
-	mutex_unlock(&pinctrldev_list_mutex);
-
-	pctldev->p = pinctrl_get(pctldev->dev);
-
-	if (!IS_ERR(pctldev->p)) {
-		pctldev->hog_default =
-			pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
-		if (IS_ERR(pctldev->hog_default)) {
-			dev_dbg(dev, "failed to lookup the default state\n");
-		} else {
-			if (pinctrl_select_state(pctldev->p,
-						pctldev->hog_default))
-				dev_err(dev,
-					"failed to select default state\n");
-		}
-
-		pctldev->hog_sleep =
-			pinctrl_lookup_state(pctldev->p,
-						    PINCTRL_STATE_SLEEP);
-		if (IS_ERR(pctldev->hog_sleep))
-			dev_dbg(dev, "failed to lookup the sleep state\n");
-	}
-
-	pinctrl_init_device_debugfs(pctldev);
+	schedule_delayed_work(&pctldev->late_init, 0);
 
 	return pctldev;
 
@@ -2023,6 +2036,7 @@ void pinctrl_unregister(struct pinctrl_dev *pctldev)
 	if (pctldev == NULL)
 		return;
 
+	cancel_delayed_work_sync(&pctldev->late_init);
 	mutex_lock(&pctldev->mutex);
 	pinctrl_remove_device_debugfs(pctldev);
 	mutex_unlock(&pctldev->mutex);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -37,6 +37,7 @@ struct pinctrl_gpio_range;
  * @p: result of pinctrl_get() for this device
  * @hog_default: default state for pins hogged by this device
  * @hog_sleep: sleep state for pins hogged by this device
+ * @late_init: delayed work for pin controller to finish registration
  * @mutex: mutex taken on each pin controller specific action
  * @device_root: debugfs root for this device
  */
@@ -55,6 +56,7 @@ struct pinctrl_dev {
 	struct pinctrl *p;
 	struct pinctrl_state *hog_default;
 	struct pinctrl_state *hog_sleep;
+	struct delayed_work late_init;
 	struct mutex mutex;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *device_root;
-- 
2.10.2
