From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device wake-up constraints
Date: Sat, 2 Jul 2011 23:10:49 +0200
Message-ID: <201107022310.50175.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <1309446685-17502-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50387 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab1GBVK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 17:10:29 -0400
In-Reply-To: <1309446685-17502-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

Hi,

On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> - add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
> constraints. Due to the per-device nature of the new class the constraints
> list is stored inside the device dev_pm_info struct instead of the internal
> per-class constraints lists.

I think PM_QOS_DEV_LATENCY might be a better name.

> The new class is only available from kernel drivers and so is not exported
> to user space.

It should be available to user space, however, because in many cases drivers
simply have no idea what values to use (after all, the use decides if he
wants to trade worse video playback quality for better battery life, for
example).

> The new class is used to put constraints on given devices in the system
> while the existing PM_QOS_CPU_DMA_LATENCY class is used by cpuidle to
> determine the next MPU subsystem state.
> 
> - make the pm_qos_add_request API more generic by using a struct
> pm_qos_parameters parameter
> 
> - the notification mechanism now passes the constraint request struct ptr
> in order for the notifier callback to have access to the full set of
> constraint data, e.g. the struct device ptr
> 
> - update the pm_qos_add_request callers to the generic API
> 
> - minor clean-ups and rename of struct fields
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Well, I think this patch attempts to do too many things at a time, which
makes it somewhat hard to comprehend at first glance.  I'd stronly suggest
splitting it into a series of patches that first modify the existing API
to make it suitable for the "real" changes and second introduce those
"real" chages in the most straightforward way possible.

> ---
>  arch/arm/plat-omap/i2c.c               |   20 ----
>  drivers/i2c/busses/i2c-omap.c          |   35 ++++---
>  drivers/media/video/via-camera.c       |    5 +-
>  drivers/net/e1000e/netdev.c            |    9 +-
>  drivers/net/wireless/ipw2x00/ipw2100.c |    6 +-
>  include/linux/pm_qos_params.h          |   40 +++++---
>  kernel/pm_qos_params.c                 |  185 +++++++++++++++++++-------------

Hmm.  If you're at it, what about moving pm_qos_params.c to kernel/power
and changing its name to pm_qos.c beforehand?

The header might be called pm_qos.h too, BTW.

>  sound/core/pcm_native.c                |    8 +-
>  8 files changed, 177 insertions(+), 131 deletions(-)
> 
...
> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
> index a7d87f9..e6e16cb 100644
> --- a/include/linux/pm_qos_params.h
> +++ b/include/linux/pm_qos_params.h
> @@ -8,31 +8,41 @@
>  #include <linux/notifier.h>
>  #include <linux/miscdevice.h>
>  
> -#define PM_QOS_RESERVED 0
> -#define PM_QOS_CPU_DMA_LATENCY 1
> -#define PM_QOS_NETWORK_LATENCY 2
> -#define PM_QOS_NETWORK_THROUGHPUT 3
> +#define	PM_QOS_RESERVED			0
> +#define	PM_QOS_CPU_DMA_LATENCY		1
> +#define	PM_QOS_DEV_WAKEUP_LATENCY	2
> +#define	PM_QOS_NETWORK_LATENCY		3
> +#define	PM_QOS_NETWORK_THROUGHPUT	4
>  
> -#define PM_QOS_NUM_CLASSES 4
> -#define PM_QOS_DEFAULT_VALUE -1
> +#define PM_QOS_NUM_CLASSES		5
> +#define PM_QOS_DEFAULT_VALUE		-1
>  
> -#define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
> +#define	PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define	PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE	0
> +#define	PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define	PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
>  
>  struct pm_qos_request_list {
>  	struct plist_node list;
> -	int pm_qos_class;
> +	int class;
> +	struct device *dev;
>  };
>  
> -void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
> +struct pm_qos_parameters {
> +	int class;
> +	struct device *dev;
> +	s32 value;
> +};
> +
> +void pm_qos_add_request(struct pm_qos_request_list *l,
> +			struct pm_qos_parameters *params);
>  void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> -		s32 new_value);
> +			   s32 new_value);
>  void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
>  
> -int pm_qos_request(int pm_qos_class);
> -int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
> -int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
> +int pm_qos_request(int class);
> +int pm_qos_add_notifier(int class, struct notifier_block *notifier);
> +int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
>  int pm_qos_request_active(struct pm_qos_request_list *req);
>  
>  #endif
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index 6824ca7..d61c8e5 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -60,7 +60,7 @@ enum pm_qos_type {
>   * types linux supports for 32 bit quantites
>   */
>  struct pm_qos_object {
> -	struct plist_head requests;
> +	struct plist_head *requests;
>  	struct blocking_notifier_head *notifiers;
>  	struct miscdevice pm_qos_power_miscdev;
>  	char *name;

So, I gather the idea is to have "requests" point to the device's private
list of latency constraints.  [BTW, there seems to be a naming confusion,
because you tend to call those things "constraints" rather that "requests".]
If so, doesn't that mean we'll need a per-device struct pm_qos_object too?
In which case why not to make the device object point to that pm_qos_object
object instead?

> @@ -72,9 +72,12 @@ struct pm_qos_object {
>  static DEFINE_SPINLOCK(pm_qos_lock);
>  
>  static struct pm_qos_object null_pm_qos;
> +
>  static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> +static struct plist_head _cpu_dma_reqs =
> +			PLIST_HEAD_INIT(_cpu_dma_reqs, pm_qos_lock);
>  static struct pm_qos_object cpu_dma_pm_qos = {
> -	.requests = PLIST_HEAD_INIT(cpu_dma_pm_qos.requests, pm_qos_lock),
> +	.requests = &_cpu_dma_reqs,
>  	.notifiers = &cpu_dma_lat_notifier,
>  	.name = "cpu_dma_latency",
>  	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> @@ -82,9 +85,20 @@ static struct pm_qos_object cpu_dma_pm_qos = {
>  	.type = PM_QOS_MIN,
>  };
>  
> +static BLOCKING_NOTIFIER_HEAD(dev_wakeup_lat_notifier);
> +static struct pm_qos_object dev_wakeup_lat_pm_qos = {
> +	.notifiers = &dev_wakeup_lat_notifier,
> +	.name = "dev_wakeup_latency",
> +	.target_value = PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
> +	.default_value = PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
> +	.type = PM_QOS_MIN,
> +};
> +
>  static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> +static struct plist_head _network_lat_reqs =
> +			PLIST_HEAD_INIT(_network_lat_reqs, pm_qos_lock);
>  static struct pm_qos_object network_lat_pm_qos = {
> -	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
> +	.requests = &_network_lat_reqs,
>  	.notifiers = &network_lat_notifier,
>  	.name = "network_latency",
>  	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> @@ -94,8 +108,10 @@ static struct pm_qos_object network_lat_pm_qos = {
>  
>  
>  static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> +static struct plist_head _network_throughput_reqs =
> +			PLIST_HEAD_INIT(_network_throughput_reqs, pm_qos_lock);
>  static struct pm_qos_object network_throughput_pm_qos = {
> -	.requests = PLIST_HEAD_INIT(network_throughput_pm_qos.requests, pm_qos_lock),
> +	.requests = &_network_throughput_reqs,
>  	.notifiers = &network_throughput_notifier,
>  	.name = "network_throughput",
>  	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> @@ -107,6 +123,7 @@ static struct pm_qos_object network_throughput_pm_qos = {
>  static struct pm_qos_object *pm_qos_array[] = {
>  	&null_pm_qos,
>  	&cpu_dma_pm_qos,
> +	&dev_wakeup_lat_pm_qos,
>  	&network_lat_pm_qos,
>  	&network_throughput_pm_qos
>  };
> @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_power_fops = {
>  /* unlocked internal variant */
>  static inline int pm_qos_get_value(struct pm_qos_object *o)
>  {
> -	if (plist_head_empty(&o->requests))
> +	if (plist_head_empty(o->requests))
>  		return o->default_value;
>  
>  	switch (o->type) {
> -	case PM_QOS_MIN:
> -		return plist_first(&o->requests)->prio;
> +		case PM_QOS_MIN:
> +			return plist_first(o->requests)->prio;
>  
> -	case PM_QOS_MAX:
> -		return plist_last(&o->requests)->prio;
> +		case PM_QOS_MAX:
> +			return plist_last(o->requests)->prio;
>  
> -	default:
> -		/* runtime check for not using enum */
> -		BUG();
> +		default:
> +			/* runtime check for not using enum */
> +			BUG();
>  	}
>  }
>  
> @@ -155,13 +172,22 @@ static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
>  	o->target_value = value;
>  }
>  
> -static void update_target(struct pm_qos_object *o, struct plist_node *node,
> -			  int del, int value)
> +static void update_target(struct pm_qos_request_list *req, int del, int value)
>  {
>  	unsigned long flags;
>  	int prev_value, curr_value;
> +	struct pm_qos_object *o = pm_qos_array[req->class];
> +	struct plist_node *node = &req->list;
>  
>  	spin_lock_irqsave(&pm_qos_lock, flags);
> +	/*
> +	 * PM_QOS_DEV_WAKEUP_LATENCY:
> +	 * Use the per-device wake-up latency constraints list for
> +	 * constraints storage
> +	 */
> +	if (req->class == PM_QOS_DEV_WAKEUP_LATENCY)
> +		o->requests = &req->dev->power.wakeup_lat_plist_head;

Ah, I see what the idea is and quite frankly I don't like it.

Changing the requests field on the fly in every second (or so) invocation of
update_target() for PM_QOS_DEV_WAKEUP_LATENCY class is beyond ugly.  Moreover,
it makes all devices share the default_value field which I don't think is
correct (the target_value field is shared too, which may lead to all sorts of
problems).

I wouldn't even try to use struct pm_qos_object as it is.  Instead, I'd
introduce something like

struct pm_qos_constraits {
	struct plist_head requests;
	unsigned int current_val;
	unsigned int default_val;
	unsigned int floor_val;  /* for adding new requests */
	unsigned int ceiling_val;  /* ditto */
	enum pm_qos_type type;
};

Where I'm not sure if the "type" field is really necessary, but that should
work out at one point and "unsigned int" is on purpose (it should have been
that way from day one in the first place).  That's what is needed for device
IMO, the other fields in struct pm_qos_object are simply redundant for this
use case.

Now, for the compatibility with the existing code I'd redefine struct
pm_qos_object as:

struct pm_qos_object {
	struct pm_qos_constraints constraints;
	struct blocking_notifier *notifiers;
	struct miscdevice pm_qos_power_miscdev;
	char *name;
};

and I'd change the code to operate on struct pm_qos_constraits in the first
place, with a compatibility layer using struct pm_qos_object on top of that.

Then, each device may have its own struct pm_qos_constraits object that will
be operated on by the PM QoS functions.  [There is the problem of whether or
not those object should be embedded in struct dev_pm_info, it may be better
to use pointers to them.  That may be used for sharing of constraints, for
example, in which case it will be necessary to add a refcount to struct
pm_qos_constraits.]

Thanks,
Rafael
