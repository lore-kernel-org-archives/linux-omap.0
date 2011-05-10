From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Tue, 10 May 2011 15:47:30 +0200
Message-ID: <20110510134730.GB25877@opensource.wolfsonmicro.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
 <20110505130204.GK11744@opensource.wolfsonmicro.com>
 <1304955274.2215.26.camel@deskari>
 <20110509191912.GA6546@opensource.wolfsonmicro.com>
 <1305030652.2045.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48505 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756380Ab1EJNr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 09:47:26 -0400
Content-Disposition: inline
In-Reply-To: <1305030652.2045.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Tue, May 10, 2011 at 03:30:52PM +0300, Tomi Valkeinen wrote:

> This sounds just the thing we need here. Do you think there's a chance
> the code could get merged in the next window? And I'm also happy to test
> the code with omapdss, whenever you have something ready.

Patch is below, tested with my "hey look, this compiles!" test plan -
I'd be a bit surprised if it ran straight off.

>From 819cc21f22b1f570f7d5d8fe981bbb03e28bdb9d Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 9 May 2011 13:07:41 +0200
Subject: [PATCH] regulator: Refactor supply implementation to work as regular consumers

Currently the regulator supply implementation is somewhat complex and
fragile as it doesn't look like standard consumers but is instead a
parallel implementation. This causes issues with locking and reference
counting.

Move the implementation over to using standard consumers to address this.
Rather than only notifying the supply on the first enable/disable we do so
every time the regulator is enabled or disabled, simplifying locking as we
don't need to hold a lock on the consumer we are about to enable.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c         |   99 +++++++++++++-------------------------
 include/linux/regulator/driver.h |    4 +-
 2 files changed, 35 insertions(+), 68 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 58452ac..38bb499 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -81,8 +81,7 @@ struct regulator {
 };
 
 static int _regulator_is_enabled(struct regulator_dev *rdev);
-static int _regulator_disable(struct regulator_dev *rdev,
-		struct regulator_dev **supply_rdev_ptr);
+static int _regulator_disable(struct regulator_dev *rdev);
 static int _regulator_get_voltage(struct regulator_dev *rdev);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev);
@@ -90,6 +89,9 @@ static void _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static struct regulator *create_regulator(struct regulator_dev *rdev,
+					  struct device *dev,
+					  const char *supply_name);
 
 static const char *rdev_get_name(struct regulator_dev *rdev)
 {
@@ -922,21 +924,18 @@ out:
  * core if it's child is enabled.
  */
 static int set_supply(struct regulator_dev *rdev,
-	struct regulator_dev *supply_rdev)
+		      struct regulator_dev *supply_rdev)
 {
 	int err;
 
-	err = sysfs_create_link(&rdev->dev.kobj, &supply_rdev->dev.kobj,
-				"supply");
-	if (err) {
-		rdev_err(rdev, "could not add device link %s err %d\n",
-			 supply_rdev->dev.kobj.name, err);
-		       goto out;
+	rdev->supply = create_regulator(rdev, &rdev->dev, "SUPPLY");
+	if (IS_ERR(rdev->supply)) {
+		err = PTR_ERR(rdev->supply);
+		rdev->supply = NULL;
+		return err;
 	}
-	rdev->supply = supply_rdev;
-	list_add(&rdev->slist, &supply_rdev->supply_list);
-out:
-	return err;
+
+	return 0;
 }
 
 /**
@@ -1294,19 +1293,6 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret, delay;
 
-	if (rdev->use_count == 0) {
-		/* do we need to enable the supply regulator first */
-		if (rdev->supply) {
-			mutex_lock(&rdev->supply->mutex);
-			ret = _regulator_enable(rdev->supply);
-			mutex_unlock(&rdev->supply->mutex);
-			if (ret < 0) {
-				rdev_err(rdev, "failed to enable: %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
 	/* check voltage and requested load before enabling */
 	if (rdev->constraints &&
 	    (rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_DRMS))
@@ -1381,19 +1367,27 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	if (rdev->supply) {
+		ret = regulator_enable(rdev->supply);
+		if (ret != 0)
+			return ret;
+	}
+
 	mutex_lock(&rdev->mutex);
 	ret = _regulator_enable(rdev);
 	mutex_unlock(&rdev->mutex);
+
+	if (ret != 0)
+		regulator_disable(rdev->supply);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
 
 /* locks held by regulator_disable() */
-static int _regulator_disable(struct regulator_dev *rdev,
-		struct regulator_dev **supply_rdev_ptr)
+static int _regulator_disable(struct regulator_dev *rdev)
 {
 	int ret = 0;
-	*supply_rdev_ptr = NULL;
 
 	if (WARN(rdev->use_count <= 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
@@ -1420,9 +1414,6 @@ static int _regulator_disable(struct regulator_dev *rdev,
 					     NULL);
 		}
 
-		/* decrease our supplies ref count and disable if required */
-		*supply_rdev_ptr = rdev->supply;
-
 		rdev->use_count = 0;
 	} else if (rdev->use_count > 1) {
 
@@ -1433,6 +1424,7 @@ static int _regulator_disable(struct regulator_dev *rdev,
 
 		rdev->use_count--;
 	}
+
 	return ret;
 }
 
@@ -1451,29 +1443,21 @@ static int _regulator_disable(struct regulator_dev *rdev,
 int regulator_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
-	struct regulator_dev *supply_rdev = NULL;
 	int ret = 0;
 
 	mutex_lock(&rdev->mutex);
-	ret = _regulator_disable(rdev, &supply_rdev);
+	ret = _regulator_disable(rdev);
 	mutex_unlock(&rdev->mutex);
 
-	/* decrease our supplies ref count and disable if required */
-	while (supply_rdev != NULL) {
-		rdev = supply_rdev;
-
-		mutex_lock(&rdev->mutex);
-		_regulator_disable(rdev, &supply_rdev);
-		mutex_unlock(&rdev->mutex);
-	}
+	if (ret == 0 && rdev->supply)
+		regulator_disable(rdev->supply);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
 
 /* locks held by regulator_force_disable() */
-static int _regulator_force_disable(struct regulator_dev *rdev,
-		struct regulator_dev **supply_rdev_ptr)
+static int _regulator_force_disable(struct regulator_dev *rdev)
 {
 	int ret = 0;
 
@@ -1490,10 +1474,6 @@ static int _regulator_force_disable(struct regulator_dev *rdev,
 			REGULATOR_EVENT_DISABLE, NULL);
 	}
 
-	/* decrease our supplies ref count and disable if required */
-	*supply_rdev_ptr = rdev->supply;
-
-	rdev->use_count = 0;
 	return ret;
 }
 
@@ -1509,16 +1489,16 @@ static int _regulator_force_disable(struct regulator_dev *rdev,
 int regulator_force_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
-	struct regulator_dev *supply_rdev = NULL;
 	int ret;
 
 	mutex_lock(&rdev->mutex);
 	regulator->uA_load = 0;
-	ret = _regulator_force_disable(rdev, &supply_rdev);
+	ret = _regulator_force_disable(regulator->rdev);
 	mutex_unlock(&rdev->mutex);
 
-	if (supply_rdev)
-		regulator_disable(get_device_regulator(rdev_get_dev(supply_rdev)));
+	if (rdev->supply)
+		while (rdev->open_count--)
+			regulator_disable(rdev->supply);
 
 	return ret;
 }
@@ -2117,7 +2097,7 @@ int regulator_set_optimum_mode(struct regulator *regulator, int uA_load)
 	/* get input voltage */
 	input_uV = 0;
 	if (rdev->supply)
-		input_uV = _regulator_get_voltage(rdev->supply);
+		input_uV = regulator_get_voltage(rdev->supply);
 	if (input_uV <= 0)
 		input_uV = rdev->constraints->input_uV;
 	if (input_uV <= 0) {
@@ -2187,17 +2167,8 @@ EXPORT_SYMBOL_GPL(regulator_unregister_notifier);
 static void _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
-	struct regulator_dev *_rdev;
-
 	/* call rdev chain first */
 	blocking_notifier_call_chain(&rdev->notifier, event, NULL);
-
-	/* now notify regulator we supply */
-	list_for_each_entry(_rdev, &rdev->supply_list, slist) {
-		mutex_lock(&_rdev->mutex);
-		_notifier_call_chain(_rdev, event, data);
-		mutex_unlock(&_rdev->mutex);
-	}
 }
 
 /**
@@ -2570,9 +2541,7 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 	rdev->owner = regulator_desc->owner;
 	rdev->desc = regulator_desc;
 	INIT_LIST_HEAD(&rdev->consumer_list);
-	INIT_LIST_HEAD(&rdev->supply_list);
 	INIT_LIST_HEAD(&rdev->list);
-	INIT_LIST_HEAD(&rdev->slist);
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 
 	/* preform any regulator specific init */
@@ -2684,7 +2653,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	if (rdev->supply)
-		sysfs_remove_link(&rdev->dev.kobj, "supply");
+		regulator_put(rdev->supply);
 	device_unregister(&rdev->dev);
 	kfree(rdev->constraints);
 	mutex_unlock(&regulator_list_mutex);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 6c433b8..1a80bc7 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -188,18 +188,16 @@ struct regulator_dev {
 
 	/* lists we belong to */
 	struct list_head list; /* list of all regulators */
-	struct list_head slist; /* list of supplied regulators */
 
 	/* lists we own */
 	struct list_head consumer_list; /* consumers we supply */
-	struct list_head supply_list; /* regulators we supply */
 
 	struct blocking_notifier_head notifier;
 	struct mutex mutex; /* consumer lock */
 	struct module *owner;
 	struct device dev;
 	struct regulation_constraints *constraints;
-	struct regulator_dev *supply;	/* for tree */
+	struct regulator *supply;	/* for tree */
 
 	void *reg_data;		/* regulator_dev data */
 
-- 
1.7.4.1

