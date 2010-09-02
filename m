From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Thu, 2 Sep 2010 13:46:24 -0500
Message-ID: <4C7FF100.5090204@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>	<1282130412-12027-2-git-send-email-thara@ti.com>	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf>	<4C7F5DB4.70306@ti.com> <87aao082bb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------080804050009050506090306"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab0IBSqb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Sep 2010 14:46:31 -0400
In-Reply-To: <87aao082bb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

--------------080804050009050506090306
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman had written, on 09/02/2010 12:47 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Thomas Petazzoni had written, on 09/02/2010 02:43 AM, the following:
>>> Hello,
>>>
>>> On Wed, 01 Sep 2010 15:51:40 -0700
>>> Kevin Hilman <khilman@deeprootsystems.com> wrote:
>>>
>>>> Looking closer at this, keeping track of a list of devices and
>>>> constraints is what the regulator framework does as well.  
>>>>
>>>> Before we get too far down this path, we need to start working with
>>>> Thomas Petazzoni to better understand how we can use the regulator
>>>> framework for much of the management levels of the voltage layer.
>>> Yes, as discussed on IRC with Kevin, I think that some of this voltage
>>> layer mechanisms would benefit from using the existing kernel regulator
>>> framework.
>>>
>>> The regulator framework already keeps tracks of consumers (in your
>>> patch set called "vdd users"), and for each consumer, keeps track of
>>> the requested voltage. The maximum requested voltage is then applied to
>>> the regulator. It seems to fit quite well some of the mechanisms you're
>>> introducing in this patch set.
>> Just brainstorming -> if we use the regulator framework - there are
>> potential benefits - agreed. BUT, consider the cpuidle path ->
>> currently we disable SR while hitting off/ret for class3, this is done
>> in irq locked context while the regulator framework uses locks by
>> itself - we would probably have to evolve an entirely different
>> mechanism to handle this.
>>
>> SR by itself can easily be represented I believe and my thoughts  when
>> i initialy looked at that option had been:
>> a) latency overheads
>> b) flexibility we achieve vs complexity in s/w implementation
>> c) lock handling - esp impact on omap_sram_idle paths..
> 
> If you look at the current PM branch (specifically pm-sr), you'll see
> that with the updated SR layer, there is no SR enable/disable in the
> idle path because there is no voltage scaling during idle.
This is interesting and I wonder if it works in reality, class 3 operation:
you enable SR h/w monitoring loop as part of dvfs, and when you hit 
cpuidle and you discover that domain x is going to idle,
you'd do:
omap_sram_idle() {
	figureout a lot of stuff
	if (core_next_state == OFF)
		disable_sr(core);
	if (mpu_next_state == OFF)
		disable_sr(mpu);
	__omap_sram_idle()
	if (core_next_state == OFF)
		enable_sr(core);
	if (mpu_next_state == OFF)
		enable_sr(mpu);

}

disable_sr(domain){
disable hw loop
forceupdate to nominal voltage
}
enable_sr(domain){
enable hw loop
}

in the days of SRF, we used to have a patch as well.. see one of the 
first versions:
http://marc.info/?l=linux-omap&m=122000411826768&w=2


> 
> That being said, even if this is add later, the idle path can potentialy
> call the SR API directly if needed for the enable/disable.
not clean if it was directly implemented by regulator framework

> 
> The concern Thomas and I are raising is that we don't want to re-invent
> regulator framework functionality in the OMAP voltage layer.  Rather, we
> should keep the OMAP voltage layer as the part that touches the HW, but
> use the regulator framework for the higher-level management of users and
> constraints.
I completely like the idea of going down the regulator path for voltage 
management, only brainstorming on how to make that happen.


btw, I was playing around with something(attached) that "might" show how 
it might be done by enhancing the regulator framework for folks who may 
want to manage their own exclusivity.. e.g. see attachment..

note: I am not saying this is the way to do it, just that: we need to 
allow regulator operations in irq_locked context if we want to do SR 
operations (including voltage transitions)

> 
> Performance issues can be addressed as we hit them, but at this level of
> the design, I want to make sure the frameworks make sense.
I agree.

> 
> Kevin
> 


-- 
Regards,
Nishanth Menon

--------------080804050009050506090306
Content-Type: text/x-patch;
	name="0001-regulator-core-change-exclusive-to-flags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-regulator-core-change-exclusive-to-flags.patch"

>From 296cd903f0ce5b70e23a052515d8de1ebb9a15cd Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 2 Sep 2010 13:24:35 -0500
Subject: {HACK}[PATCH 1/2] regulator: core: change exclusive to flags

we currently use an int for exclusivity, instead change it to
a flag based usage. this allows us to extend this to additional flags
as well

Signed-off-by: Nishanth Menon <nm@ti.com>
---
this patch is meant to be for demonstration purposes only.

 drivers/regulator/core.c         |    6 +++---
 include/linux/regulator/driver.h |    4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 422a709..0a1e199 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1127,7 +1127,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	return regulator;
 
 found:
-	if (rdev->exclusive) {
+	if (rdev->flags & REGULATOR_EXCLUSIVE_FLAG) {
 		regulator = ERR_PTR(-EPERM);
 		goto out;
 	}
@@ -1148,7 +1148,7 @@ found:
 
 	rdev->open_count++;
 	if (exclusive) {
-		rdev->exclusive = 1;
+		rdev->flags |= REGULATOR_EXCLUSIVE_FLAG;
 
 		ret = _regulator_is_enabled(rdev);
 		if (ret > 0)
@@ -1238,7 +1238,7 @@ void regulator_put(struct regulator *regulator)
 	kfree(regulator);
 
 	rdev->open_count--;
-	rdev->exclusive = 0;
+	rdev->flags &= ~REGULATOR_EXCLUSIVE_FLAG;
 
 	module_put(rdev->owner);
 	mutex_unlock(&regulator_list_mutex);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 592cd7c..6397ab3 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -156,6 +156,8 @@ struct regulator_desc {
 	struct module *owner;
 };
 
+#define REGULATOR_EXCLUSIVE_FLAG	(0x1 << 1)
+
 /*
  * struct regulator_dev
  *
@@ -170,7 +172,7 @@ struct regulator_dev {
 	struct regulator_desc *desc;
 	int use_count;
 	int open_count;
-	int exclusive;
+	unsigned int flags;
 
 	/* lists we belong to */
 	struct list_head list; /* list of all regulators */
-- 
1.6.3.3


--------------080804050009050506090306
Content-Type: text/x-patch;
	name="0002-regulator-core-introduce-unsafe-operations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0002-regulator-core-introduce-unsafe-operations.patch"

>From 3145fa45029fbdbfed2b2a2a6e335a72f8c47d36 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Thu, 2 Sep 2010 13:40:40 -0500
Subject: {HACK}[PATCH 2/2] regulator: core: introduce unsafe operations

introduce unsafe operations for consumers who can manage
their own operation sequencing and dont want core to bother
locking out multiple accesses exclusive of each other.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
this patch is for demonstration purpose only

 drivers/regulator/core.c           |  121 ++++++++++++++++++++++++++----------
 include/linux/regulator/consumer.h |    2 +
 include/linux/regulator/driver.h   |    1 +
 3 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0a1e199..c4c0e98 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -223,9 +223,11 @@ static ssize_t regulator_uV_show(struct device *dev,
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	ssize_t ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	ret = sprintf(buf, "%d\n", _regulator_get_voltage(rdev));
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 
 	return ret;
 }
@@ -288,9 +290,11 @@ static ssize_t regulator_state_show(struct device *dev,
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	ssize_t ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	ret = regulator_print_state(buf, _regulator_is_enabled(rdev));
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 
 	return ret;
 }
@@ -392,10 +396,12 @@ static ssize_t regulator_total_uA_show(struct device *dev,
 	struct regulator *regulator;
 	int uA = 0;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	list_for_each_entry(regulator, &rdev->consumer_list, list)
 		uA += regulator->uA_load;
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return sprintf(buf, "%d\n", uA);
 }
 static DEVICE_ATTR(requested_microamps, 0444, regulator_total_uA_show, NULL);
@@ -1078,7 +1084,7 @@ static int _regulator_get_enable_time(struct regulator_dev *rdev)
 
 /* Internal regulator request function */
 static struct regulator *_regulator_get(struct device *dev, const char *id,
-					int exclusive)
+					int exclusive, int unsafe)
 {
 	struct regulator_dev *rdev;
 	struct regulator_map *map;
@@ -1156,6 +1162,8 @@ found:
 		else
 			rdev->use_count = 0;
 	}
+	if (unsafe)
+		rdev->flags |= REGULATOR_UNSAFEOPS_FLAG;
 
 out:
 	mutex_unlock(&regulator_list_mutex);
@@ -1178,7 +1186,7 @@ out:
  */
 struct regulator *regulator_get(struct device *dev, const char *id)
 {
-	return _regulator_get(dev, id, 0);
+	return _regulator_get(dev, id, 0, 0);
 }
 EXPORT_SYMBOL_GPL(regulator_get);
 
@@ -1205,11 +1213,27 @@ EXPORT_SYMBOL_GPL(regulator_get);
  */
 struct regulator *regulator_get_exclusive(struct device *dev, const char *id)
 {
-	return _regulator_get(dev, id, 1);
+	return _regulator_get(dev, id, 1, 0);
 }
 EXPORT_SYMBOL_GPL(regulator_get_exclusive);
 
 /**
+ * regulator_get_exclusive_unsafe() - completely unsafe operations!
+ * @dev: device for regulator "consumer"
+ * @id: Supply name or regulator ID.
+ *
+ * Use of this function is strictly dangerous - caller should maintain
+ * exclusivity of access between operations, core will not take care of
+ * the same. this operation will fail unless the regulator can be
+ * exclusively openend
+ */
+struct regulator *regulator_get_exclusive_unsafe(struct device *dev,
+		const char *id)
+{
+	return _regulator_get(dev, id, 1, 1);
+}
+EXPORT_SYMBOL_GPL(regulator_get_exclusive);
+/**
  * regulator_put - "free" the regulator source
  * @regulator: regulator source
  *
@@ -1239,6 +1263,7 @@ void regulator_put(struct regulator *regulator)
 
 	rdev->open_count--;
 	rdev->flags &= ~REGULATOR_EXCLUSIVE_FLAG;
+	rdev->flags &= ~REGULATOR_UNSAFEOPS_FLAG;
 
 	module_put(rdev->owner);
 	mutex_unlock(&regulator_list_mutex);
@@ -1340,9 +1365,11 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -1409,9 +1436,11 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -1456,10 +1485,12 @@ int regulator_force_disable(struct regulator *regulator)
 {
 	int ret;
 
-	mutex_lock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&regulator->rdev->mutex);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&regulator->rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_force_disable);
@@ -1489,9 +1520,11 @@ int regulator_is_enabled(struct regulator *regulator)
 {
 	int ret;
 
-	mutex_lock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&regulator->rdev->mutex);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&regulator->rdev->mutex);
 
 	return ret;
 }
@@ -1532,9 +1565,11 @@ int regulator_list_voltage(struct regulator *regulator, unsigned selector)
 	if (!ops->list_voltage || selector >= rdev->desc->n_voltages)
 		return -EINVAL;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 	ret = ops->list_voltage(rdev, selector);
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 
 	if (ret > 0) {
 		if (ret < rdev->constraints->min_uV)
@@ -1599,7 +1634,8 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	/* sanity check */
 	if (!rdev->desc->ops->set_voltage) {
@@ -1617,7 +1653,8 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 
 out:
 	_notifier_call_chain(rdev, REGULATOR_EVENT_VOLTAGE_CHANGE, NULL);
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage);
@@ -1644,11 +1681,13 @@ int regulator_get_voltage(struct regulator *regulator)
 {
 	int ret;
 
-	mutex_lock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&regulator->rdev->mutex);
 
 	ret = _regulator_get_voltage(regulator->rdev);
 
-	mutex_unlock(&regulator->rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&regulator->rdev->mutex);
 
 	return ret;
 }
@@ -1676,7 +1715,8 @@ int regulator_set_current_limit(struct regulator *regulator,
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	/* sanity check */
 	if (!rdev->desc->ops->set_current_limit) {
@@ -1691,7 +1731,8 @@ int regulator_set_current_limit(struct regulator *regulator,
 
 	ret = rdev->desc->ops->set_current_limit(rdev, min_uA, max_uA);
 out:
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_current_limit);
@@ -1700,7 +1741,8 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
 {
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	/* sanity check */
 	if (!rdev->desc->ops->get_current_limit) {
@@ -1710,7 +1752,8 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
 
 	ret = rdev->desc->ops->get_current_limit(rdev);
 out:
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 
@@ -1746,7 +1789,8 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	int ret;
 	int regulator_curr_mode;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	/* sanity check */
 	if (!rdev->desc->ops->set_mode) {
@@ -1770,7 +1814,8 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 
 	ret = rdev->desc->ops->set_mode(rdev, mode);
 out:
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_mode);
@@ -1779,7 +1824,8 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 {
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	/* sanity check */
 	if (!rdev->desc->ops->get_mode) {
@@ -1789,7 +1835,8 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 
 	ret = rdev->desc->ops->get_mode(rdev);
 out:
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 
@@ -1838,7 +1885,8 @@ int regulator_set_optimum_mode(struct regulator *regulator, int uA_load)
 	int ret, output_uV, input_uV, total_uA_load = 0;
 	unsigned int mode;
 
-	mutex_lock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_lock(&rdev->mutex);
 
 	regulator->uA_load = uA_load;
 	ret = regulator_check_drms(rdev);
@@ -1892,7 +1940,8 @@ int regulator_set_optimum_mode(struct regulator *regulator, int uA_load)
 	}
 	ret = mode;
 out:
-	mutex_unlock(&rdev->mutex);
+	if (!(rdev->flags & REGULATOR_UNSAFEOPS_FLAG))
+		mutex_unlock(&rdev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_optimum_mode);
@@ -1934,6 +1983,9 @@ static void _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
 	struct regulator_dev *_rdev;
+	/* We will not have notifiers in this mode */
+	if (rdev->flags & REGULATOR_UNSAFEOPS_FLAG)
+		return;
 
 	/* call rdev chain first */
 	blocking_notifier_call_chain(&rdev->notifier, event, NULL);
@@ -2423,6 +2475,9 @@ int regulator_suspend_prepare(suspend_state_t state)
 	/* ON is handled by regulator active state */
 	if (state == PM_SUSPEND_ON)
 		return -EINVAL;
+	/* we will not suspend if we are opened unsafe */
+	if (rdev->flags & REGULATOR_UNSAFEOPS_FLAG)
+		return -EINVAL;
 
 	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(rdev, &regulator_list, list) {
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index ebd7472..c071992 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -131,6 +131,8 @@ struct regulator *__must_check regulator_get(struct device *dev,
 					     const char *id);
 struct regulator *__must_check regulator_get_exclusive(struct device *dev,
 						       const char *id);
+struct regulator *__must_check regulator_get_exclusive_unsafe(struct device *dev,
+						       const char *id);
 void regulator_put(struct regulator *regulator);
 
 /* regulator output control and status */
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 6397ab3..6d117d9 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -157,6 +157,7 @@ struct regulator_desc {
 };
 
 #define REGULATOR_EXCLUSIVE_FLAG	(0x1 << 1)
+#define REGULATOR_UNSAFEOPS_FLAG	(0x2 << 1)
 
 /*
  * struct regulator_dev
-- 
1.6.3.3


--------------080804050009050506090306--
