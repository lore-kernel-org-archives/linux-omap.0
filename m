From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/15] PM QoS: implement the per-device PM QoS constraints
Date: Tue, 16 Aug 2011 23:40:32 +0200
Message-ID: <201108162340.32357.rjw@sisk.pl>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com> <1313502198-9298-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45857 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab1HPVjC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 17:39:02 -0400
In-Reply-To: <1313502198-9298-7-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi,

On Tuesday, August 16, 2011, jean.pihet@newoldbits.com wrote:
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
> A global mutex protects the constraints users from the data being
> allocated and free'd.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/base/power/Makefile |    4 +-
>  drivers/base/power/main.c   |    3 +
>  drivers/base/power/qos.c    |  291 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h          |    9 ++
>  include/linux/pm_qos.h      |   42 ++++++
>  5 files changed, 347 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/base/power/qos.c
> 
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 2639ae7..b707447 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o
> +obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o qos.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
>  obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
> @@ -6,4 +6,4 @@ obj-$(CONFIG_PM_OPP)	+= opp.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o
>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
>  
> -ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> \ No newline at end of file
> +ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a854591..956443f 100644
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
> index 0000000..304d68d
> --- /dev/null
> +++ b/drivers/base/power/qos.c
> @@ -0,0 +1,291 @@
> +/*

Please add a copyright notice.

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
> + *  . A global mutex protects the constraints users from the data being
> + *     allocated and free'd.
> + */
> +
> +#include <linux/pm_qos.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +
> +
> +static DEFINE_MUTEX(dev_pm_qos_mtx);
> +static void dev_pm_qos_constraints_allocate(struct device *dev);

This header wouldn't be necessary if you put the definition of
dev_pm_qos_constraints_allocate() before dev_pm_qos_add_request().

> +
> +/**
> + * dev_pm_qos_add_request - inserts new qos request into the list
> + * @dev: target device for the constraint
> + * @req: pointer to a preallocated handle
> + * @value: defines the qos request
> + *
> + * This function inserts a new entry in the device constraints list of
> + * requested qos performance characteristics. It recomputes the aggregate
> + * QoS expectations of parameters and initializes the dev_pm_qos_request
> + * handle.  Caller needs to save this handle for later use in updates and
> + * removal.
> + */
> +void dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
> +			    s32 value)
> +{
> +	if (!dev || !req) /*guard against callers passing in null */
> +		return;
> +
> +	if (dev_pm_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "dev_pm_qos_add_request() called for already "
> +			"added request\n");
> +		return;
> +	}
> +
> +	/* Allocate the constraints struct on the first call to add_request */
> +	dev_pm_qos_constraints_allocate(dev);

I would remove the locking from dev_pm_qos_constraints_allocate() and
put it under the lock below.  The code would be cleaner this way.

Also, the name is slightly misleading, because it suggests that the
allocation happens every time, so I'd move the condition from there
into the caller too.

The remaning part of the patch looks OK to me, but I'll have another
look at it tomorrow, when I'm less tired.

Thanks,
Rafael
