From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/15] PM QoS: implement the per-device PM QoS constraints
Date: Sat, 13 Aug 2011 23:08:26 +0200
Message-ID: <201108132308.26265.rjw@sisk.pl>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com> <1313075212-8366-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39299 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab1HMVGt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Aug 2011 17:06:49 -0400
In-Reply-To: <1313075212-8366-7-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi,

Well, it looks like I should have reviewed this one more carefully.

On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Implement the per-device PM QoS constraints by creating a device
> PM QoS API, which calls the PM QoS constraints management core code.
> 
> The per-device latency constraints data strctures are stored
> in the device dev_pm_info struct.
> 
> The device PM code calls the init and destroy of the per-device constraints
> data struct in order to support the dynamic insertion and removal of the
> devices in the system.
> 
> To minimize the data usage by the per-device constraints, the data struct
> is only allocated at the first call to dev_pm_qos_add_request.
> The data is later free'd when the device is removed from the system.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/base/power/Makefile |    4 +-
>  drivers/base/power/main.c   |    3 +
>  drivers/base/power/qos.c    |  262 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h          |    9 ++
>  include/linux/pm_qos.h      |   39 +++++++
>  5 files changed, 315 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/base/power/qos.c
> 
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 3647e11..1a61f89 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -1,8 +1,8 @@
> -obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o
> +obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o qos.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
>  obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  obj-$(CONFIG_PM_OPP)	+= opp.o
>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
>  
> -ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> \ No newline at end of file
> +ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 06f09bf..f5c0e0e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -22,6 +22,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
>  #include <linux/resume-trace.h>
>  #include <linux/interrupt.h>
>  #include <linux/sched.h>
> @@ -97,6 +98,7 @@ void device_pm_add(struct device *dev)
>  			dev_name(dev->parent));
>  	list_add_tail(&dev->power.entry, &dpm_list);
>  	mutex_unlock(&dpm_list_mtx);
> +	dev_pm_qos_constraints_init(dev);
>  }
>  
>  /**
> @@ -107,6 +109,7 @@ void device_pm_remove(struct device *dev)
>  {
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
> +	dev_pm_qos_constraints_destroy(dev);
>  	complete_all(&dev->power.completion);
>  	mutex_lock(&dpm_list_mtx);
>  	list_del_init(&dev->power.entry);
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> new file mode 100644
> index 0000000..465e419
> --- /dev/null
> +++ b/drivers/base/power/qos.c
> @@ -0,0 +1,262 @@
> +/*
> + * This module exposes the interface to kernel space for specifying
> + * per-device PM QoS dependencies. It provides infrastructure for registration
> + * of:
> + *
> + * Dependents on a QoS value : register requests
> + * Watchers of QoS value : get notified when target QoS value changes
> + *
> + * This QoS design is best effort based. Dependents register their QoS needs.
> + * Watchers register to keep track of the current QoS needs of the system.
> + *
> + * Note about the per-device constraint data struct allocation:
> + * . The per-device constraints data struct ptr is tored into the device
> + *    dev_pm_info.
> + * . To minimize the data usage by the per-device constraints, the data struct
> + *   is only allocated at the first call to dev_pm_qos_add_request.
> + * . The data is later free'd when the device is removed from the system.
> + * . The constraints_state variable from dev_pm_info tracks the data struct
> + *    allocation state:
> + *    DEV_PM_QOS_NO_DEVICE: No device present or device removed, no data
> + *     allocated,
> + *    DEV_PM_QOS_DEVICE_PRESENT: Device present, data not allocated and will be
> + *     allocated at the first call to dev_pm_qos_add_request,
> + *    DEV_PM_QOS_ALLOCATED: Device present, data allocated. The per-device
> + *     PM QoS constraints framework is operational and constraints can be
> + *     added, updated or removed using the dev_pm_qos_* API.
> + */
> +
> +/*#define DEBUG*/

Please remove this.

> +
> +#include <linux/pm_qos.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>

Are you sure all of the headers are necessary?

> +
> +
> +static void dev_pm_qos_constraints_allocate(struct device *dev);
> +
> +int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
> +{
> +	return req->dev != 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_request_active);

That should be a static inline in a header.

> +
> +/**
> + * dev_pm_qos_add_request - inserts new qos request into the list
> + * @req: pointer to a preallocated handle
> + * @dev: target device for the constraint
> + * @value: defines the qos request
> + *
> + * This function inserts a new entry in the device constraints list of
> + * requested qos performance characteristics. It recomputes the aggregate
> + * QoS expectations of parameters and initializes the dev_pm_qos_request
> + * handle.  Caller needs to save this handle for later use in updates and
> + * removal.
> + */
> +void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
> +			    s32 value)

I'd use a different ordering of arguments, namely (dev, req, value).

> +{
> +	if (!req) /*guard against callers passing in null */
> +		return;

Why not to check for !dev too?

> +
> +	if (dev_pm_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "dev_pm_qos_add_request() called for already "
> +			"added request\n");
> +		return;
> +	}
> +	req->dev = dev;
> +
> +	/* Allocate the constraints struct on the first call to add_request */
> +	if (req->dev->power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT)
> +		dev_pm_qos_constraints_allocate(dev);

Why not to do

+	if (!req->dev->power.constraints)
+		dev_pm_qos_constraints_allocate(dev);

> +
> +	/* Silently return if the device has been removed */
> +	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> +		return;
> +

Hmm.  What will happen if two callers run dev_pm_qos_add_request()
concurrently for the same device?

> +	pm_qos_update_target(dev->power.constraints,
> +			     &req->node, PM_QOS_ADD_REQ, value);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
> +
> +/**
> + * dev_pm_qos_update_request - modifies an existing qos request
> + * @req : handle to list element holding a dev_pm_qos request to use
> + * @value: defines the qos request
> + *
> + * Updates an existing dev PM qos request along with updating the
> + * target value.
> + *
> + * Attempts are made to make this code callable on hot code paths.
> + */
> +void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
> +			   s32 new_value)
> +{
> +	if (!req) /*guard against callers passing in null */
> +		return;
> +
> +	if (!dev_pm_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "dev_pm_qos_update_request() called for "
> +			"unknown object\n");
> +		return;
> +	}
> +
> +	/* Silently return if the device has been removed */
> +	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> +		return;
> +
> +	if (new_value != req->node.prio)
> +		pm_qos_update_target(
> +			req->dev->power.constraints,
> +			&req->node, PM_QOS_UPDATE_REQ, new_value);

I'm not sure what prevents dev_pm_qos_constraints_destroy() from removing
the list from under us while we're executing this?

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
> +
> +/**
> + * dev_pm_qos_remove_request - modifies an existing qos request
> + * @req: handle to request list element
> + *
> + * Will remove pm qos request from the list of constraints and
> + * recompute the current target value. Call this on slow code paths.
> + */
> +void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
> +{
> +	if (!req) /*guard against callers passing in null */
> +		return;
> +
> +	if (!dev_pm_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "dev_pm_qos_remove_request() called for "
> +			"unknown object\n");
> +		return;
> +	}
> +
> +	/* Silently return if the device has been removed */
> +	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> +		return;
> +
> +	pm_qos_update_target(req->dev->power.constraints,
> +			     &req->node, PM_QOS_REMOVE_REQ,
> +			     PM_QOS_DEFAULT_VALUE);

Same here.

> +	memset(req, 0, sizeof(*req));
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
> +
> +/**
> + * dev_pm_qos_add_notifier - sets notification entry for changes to target value
> + * of per-device PM QoS constraints
> + *
> + * @dev: target device for the constraint
> + * @notifier: notifier block managed by caller.
> + *
> + * Will register the notifier into a notification chain that gets called
> + * upon changes to the target value for the device.
> + */
> +int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
> +{
> +	int retval = 0;
> +
> +	/* Silently return if the device has been removed */
> +	if (dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> +		return retval;
> +
> +	retval = blocking_notifier_chain_register(
> +			dev->power.constraints->notifiers,
> +			notifier);

That may be racing with dev_pm_qos_constraints_destroy() too.

> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
> +
> +/**
> + * dev_pm_qos_remove_notifier - deletes notification for changes to target value
> + * of per-device PM QoS constraints
> + *
> + * @dev: target device for the constraint
> + * @notifier: notifier block to be removed.
> + *
> + * Will remove the notifier from the notification chain that gets called
> + * upon changes to the target value.
> + */
> +int dev_pm_qos_remove_notifier(struct device *dev,
> +			       struct notifier_block *notifier)
> +{
> +	int retval = 0;
> +
> +	/* Silently return if the device has been removed */
> +	if (dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
> +		return retval;
> +
> +	retval = blocking_notifier_chain_unregister(
> +			dev->power.constraints->notifiers,
> +			notifier);

Same here.

> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
> +
> +/* Called at the first call to add_request, for constraint data allocation */
> +static void dev_pm_qos_constraints_allocate(struct device *dev)
> +{
> +	struct pm_qos_constraints *c;
> +	struct blocking_notifier_head *n;
> +
> +	c = kzalloc(sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return;
> +
> +	n = kzalloc(sizeof(*n), GFP_KERNEL);
> +	if (!n) {
> +		kfree(c);
> +		return;
> +	}
> +	BLOCKING_INIT_NOTIFIER_HEAD(n);
> +
> +	dev->power.constraints = c;
> +	plist_head_init(&dev->power.constraints->list, &dev->power.lock);
> +	dev->power.constraints->target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +	dev->power.constraints->default_value =	PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +	dev->power.constraints->type = PM_QOS_MIN;
> +	dev->power.constraints->notifiers = n;
> +	dev->power.constraints_state = DEV_PM_QOS_ALLOCATED;
> +}
> +
> +/* Called from the device PM subsystem at device insertion */
> +void dev_pm_qos_constraints_init(struct device *dev)
> +{
> +	dev->power.constraints_state = DEV_PM_QOS_DEVICE_PRESENT;

Hmm.  Is it insufficient to check if "constraints" is not NULL?

> +}
> +
> +/* Called from the device PM subsystem at device removal */
> +void dev_pm_qos_constraints_destroy(struct device *dev)
> +{
> +	struct dev_pm_qos_request *req, *tmp;
> +	enum dev_pm_qos_state constraints_state = dev->power.constraints_state;
> +
> +	dev->power.constraints_state = DEV_PM_QOS_NO_DEVICE;

I'm not sure what the purpose of this is.  I'd simply check if "constraints"
is not NULL and I'd flush the list if not.

Moreover, that has to go under a lock so that it doesn't race with
the other functions above.  I think you can reuse power.lock for that.

> +	if (constraints_state == DEV_PM_QOS_ALLOCATED) {
> +		/* Flush the constraints list for the device */
> +		plist_for_each_entry_safe(req, tmp,
> +					  &dev->power.constraints->list,
> +					  node)
> +			/*
> +			 * Update constraints list and call the per-device
> +			 * callbacks if needed
> +			 */
> +			pm_qos_update_target(req->dev->power.constraints,
> +					     &req->node, PM_QOS_REMOVE_REQ,
> +					     PM_QOS_DEFAULT_VALUE);
> +
> +		kfree(dev->power.constraints->notifiers);
> +		kfree(dev->power.constraints);
> +		dev->power.constraints = NULL;
> +	}
> +}
> +

Thanks,
Rafael
