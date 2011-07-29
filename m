From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/13] PM: QoS: extend the in-kernel API with per-device latency constraints
Date: Sat, 30 Jul 2011 00:55:49 +0200
Message-ID: <201107300055.49468.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com> <1311841821-10252-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34944 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab1G2Wyp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 18:54:45 -0400
In-Reply-To: <1311841821-10252-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Extend the PM QoS kernel API:
> - add a new PM QoS class PM_QOS_DEV_LATENCY for device wake-up latency
> constraints
> - make the pm_qos_add_request API more generic by using a parameter of
> type struct pm_qos_parameters
> - minor clean-ups and rename of struct fields:
>   . rename pm_qos_class to class and pm_qos_req to req in internal code
>   . consistenly use req and params as the API parameters
>   . rename struct pm_qos_request_list to struct pm_qos_request
> - update the in-kernel API callers to the new API

There should be more about the motivation in the changelog.  It says
what the patch is doing, but it doesn't say a word of _why_ it is done in
the first place.

Second, you're renaming a lot of things in the same patch that makes
functional changes.  This is confusing and makes it very difficult to
understand what's going on.  Please use separate patches to rename
things, when possible, and avoid renaming things that don't need to be
renamed.

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/plat-omap/i2c.c               |   20 -----
>  drivers/i2c/busses/i2c-omap.c          |   35 ++++++---
>  drivers/media/video/via-camera.c       |    7 +-
>  drivers/net/e1000e/netdev.c            |    9 ++-
>  drivers/net/wireless/ipw2x00/ipw2100.c |    8 +-
>  include/linux/netdevice.h              |    2 +-
>  include/linux/pm_qos.h                 |   39 ++++++----
>  include/sound/pcm.h                    |    2 +-
>  kernel/pm_qos.c                        |  130 +++++++++++++++++--------------
>  sound/core/pcm_native.c                |    8 ++-
>  10 files changed, 141 insertions(+), 119 deletions(-)

I'm going to comment the core changes this time.

...
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 9cc0224..a2e4409 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -8,31 +8,40 @@
>  #include <linux/notifier.h>
>  #include <linux/miscdevice.h>
>  
> -#define PM_QOS_RESERVED 0
> -#define PM_QOS_CPU_DMA_LATENCY 1
> -#define PM_QOS_NETWORK_LATENCY 2
> -#define PM_QOS_NETWORK_THROUGHPUT 3
> +#define PM_QOS_RESERVED			0
> +#define PM_QOS_CPU_DMA_LATENCY		1
> +#define PM_QOS_DEV_LATENCY		2
> +#define PM_QOS_NETWORK_LATENCY		3
> +#define PM_QOS_NETWORK_THROUGHPUT	4
>  
> -#define PM_QOS_NUM_CLASSES 4
> +#define PM_QOS_NUM_CLASSES 5
>  #define PM_QOS_DEFAULT_VALUE -1
>  
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
>  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
>  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
>  
> -struct pm_qos_request_list {
> +struct pm_qos_request {

This renaming should go in a separate patch, really.

>  	struct plist_node list;
> -	int pm_qos_class;
> +	int class;

This renaming doesn't seem to be necessary.  Moreover, it's confusing,
because there already is struct class (for device classes) and a member
called "class" in struct device and they aren't related to this one.

> +	struct device *dev;
>  };
>  
> -void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
> -void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> -		s32 new_value);
> -void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
> +struct pm_qos_parameters {
> +	int class;
> +	struct device *dev;
> +	s32 value;
> +};

What exactly is the "dev" member needed for?

> +
> +void pm_qos_add_request(struct pm_qos_request *req,
> +			struct pm_qos_parameters *params);
> +void pm_qos_update_request(struct pm_qos_request *req, s32 new_value);
> +void pm_qos_remove_request(struct pm_qos_request *req);
>  
> -int pm_qos_request(int pm_qos_class);
> -int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
> -int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
> -int pm_qos_request_active(struct pm_qos_request_list *req);
> +int pm_qos_request(int class);
> +int pm_qos_add_notifier(int class, struct notifier_block *notifier);
> +int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
> +int pm_qos_request_active(struct pm_qos_request *req);
>  
>  #endif
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 1204f17..d3b068f 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -373,7 +373,7 @@ struct snd_pcm_substream {
>  	int number;
>  	char name[32];			/* substream name */
>  	int stream;			/* stream (direction) */
> -	struct pm_qos_request_list latency_pm_qos_req; /* pm_qos request */
> +	struct pm_qos_request latency_pm_qos_req; /* pm_qos request */
>  	size_t buffer_bytes_max;	/* limit ring buffer size */
>  	struct snd_dma_buffer dma_buffer;
>  	unsigned int dma_buf_id;
> diff --git a/kernel/pm_qos.c b/kernel/pm_qos.c
> index 3bf69f1..4ede3cd 100644
> --- a/kernel/pm_qos.c
> +++ b/kernel/pm_qos.c
> @@ -82,6 +82,16 @@ static struct pm_qos_object cpu_dma_pm_qos = {
>  	.type = PM_QOS_MIN,
>  };
>  
> +static BLOCKING_NOTIFIER_HEAD(dev_lat_notifier);
> +static struct pm_qos_object dev_pm_qos = {
> +	.requests = PLIST_HEAD_INIT(dev_pm_qos.requests, pm_qos_lock),
> +	.notifiers = &dev_lat_notifier,
> +	.name = "dev_latency",
> +	.target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
> +	.default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
> +	.type = PM_QOS_MIN,
> +};
> +

You seem to be confusing things here.  Since devices will have their own lists
of requests now (as per the previous patch), the .requests member above is not
necessary.  Moreover, it seems to be used incorrectly below.

>  static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
>  static struct pm_qos_object network_lat_pm_qos = {
>  	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
> @@ -107,6 +117,7 @@ static struct pm_qos_object network_throughput_pm_qos = {
>  static struct pm_qos_object *pm_qos_array[] = {
>  	&null_pm_qos,
>  	&cpu_dma_pm_qos,
> +	&dev_pm_qos,
>  	&network_lat_pm_qos,
>  	&network_throughput_pm_qos
>  };
> @@ -212,132 +223,132 @@ static int find_pm_qos_object_by_minor(int minor)
>  
>  /**
>   * pm_qos_request - returns current system wide qos expectation
> - * @pm_qos_class: identification of which qos value is requested
> + * @class: identification of which qos value is requested
>   *
>   * This function returns the current target value.
>   */
> -int pm_qos_request(int pm_qos_class)
> +int pm_qos_request(int class)
>  {
> -	return pm_qos_read_value(pm_qos_array[pm_qos_class]);
> +	return pm_qos_read_value(pm_qos_array[class]);
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request);

As I said, it is completely unnecessary (and confusing) to rename
"pm_qos_class" to "class".

> -int pm_qos_request_active(struct pm_qos_request_list *req)
> +int pm_qos_request_active(struct pm_qos_request *req)
>  {
> -	return req->pm_qos_class != 0;
> +	return req->class != 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request_active);
>  
>  /**
>   * pm_qos_add_request - inserts new qos request into the list
> - * @dep: pointer to a preallocated handle
> - * @pm_qos_class: identifies which list of qos request to use
> - * @value: defines the qos request
> + * @req: pointer to a preallocated handle
> + * @params: request parameters
>   *
> - * This function inserts a new entry in the pm_qos_class list of requested qos
> + * This function inserts a new entry in the class list of requested qos
>   * performance characteristics.  It recomputes the aggregate QoS expectations
> - * for the pm_qos_class of parameters and initializes the pm_qos_request_list
> + * for the class of parameters and initializes the pm_qos_request
>   * handle.  Caller needs to save this handle for later use in updates and
>   * removal.
>   */
>  
> -void pm_qos_add_request(struct pm_qos_request_list *dep,
> -			int pm_qos_class, s32 value)
> +void pm_qos_add_request(struct pm_qos_request *req,
> +			struct pm_qos_parameters *params)
>  {
> -	struct pm_qos_object *o =  pm_qos_array[pm_qos_class];
> +	struct pm_qos_object *o =  pm_qos_array[params->class];
>  	int new_value;
>  
> -	if (pm_qos_request_active(dep)) {
> -		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
> +	if (pm_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "pm_qos_add_request() called for already "
> +			"added request\n");
>  		return;
>  	}
> -	if (value == PM_QOS_DEFAULT_VALUE)
> +	if (params->value == PM_QOS_DEFAULT_VALUE)
>  		new_value = o->default_value;
>  	else
> -		new_value = value;
> -	plist_node_init(&dep->list, new_value);
> -	dep->pm_qos_class = pm_qos_class;
> -	update_target(o, &dep->list, 0, PM_QOS_DEFAULT_VALUE);
> +		new_value = params->value;
> +	plist_node_init(&req->list, new_value);
> +	req->class = params->class;
> +	req->dev = params->dev;
> +	update_target(o, &req->list, 0, PM_QOS_DEFAULT_VALUE);

This causes update_target() to use the .requests member of dev_pm_qos
as a list of requests for every device, which doesn't seem to be correct.

>  }
>  EXPORT_SYMBOL_GPL(pm_qos_add_request);
>  
>  /**
>   * pm_qos_update_request - modifies an existing qos request
> - * @pm_qos_req : handle to list element holding a pm_qos request to use
> + * @req : handle to list element holding a pm_qos request to use
>   * @value: defines the qos request
>   *
> - * Updates an existing qos request for the pm_qos_class of parameters along
> - * with updating the target pm_qos_class value.
> + * Updates an existing qos request for the class of parameters along
> + * with updating the target class value.
>   *
>   * Attempts are made to make this code callable on hot code paths.
>   */
> -void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> -			   s32 new_value)
> +void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
>  {
>  	s32 temp;
>  	struct pm_qos_object *o;
>  
> -	if (!pm_qos_req) /*guard against callers passing in null */
> +	if (!req) /*guard against callers passing in null */
>  		return;
>  
> -	if (!pm_qos_request_active(pm_qos_req)) {
> +	if (!pm_qos_request_active(req)) {
>  		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown object\n");
>  		return;
>  	}
>  
> -	o = pm_qos_array[pm_qos_req->pm_qos_class];
> +	o = pm_qos_array[req->class];
>  
>  	if (new_value == PM_QOS_DEFAULT_VALUE)
>  		temp = o->default_value;
>  	else
>  		temp = new_value;
>  
> -	if (temp != pm_qos_req->list.prio)
> -		update_target(o, &pm_qos_req->list, 0, temp);
> +	if (temp != req->list.prio)
> +		update_target(o, &req->list, 0, temp);

Same here.

>  }
>  EXPORT_SYMBOL_GPL(pm_qos_update_request);
>  
>  /**
>   * pm_qos_remove_request - modifies an existing qos request
> - * @pm_qos_req: handle to request list element
> + * @req: handle to request list element
>   *
>   * Will remove pm qos request from the list of requests and
> - * recompute the current target value for the pm_qos_class.  Call this
> + * recompute the current target value for the class.  Call this
>   * on slow code paths.
>   */
> -void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
> +void pm_qos_remove_request(struct pm_qos_request *req)
>  {
>  	struct pm_qos_object *o;
>  
> -	if (pm_qos_req == NULL)
> +	if (req == NULL)
>  		return;
>  		/* silent return to keep pcm code cleaner */
>  
> -	if (!pm_qos_request_active(pm_qos_req)) {
> +	if (!pm_qos_request_active(req)) {
>  		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown object\n");
>  		return;
>  	}
>  
> -	o = pm_qos_array[pm_qos_req->pm_qos_class];
> -	update_target(o, &pm_qos_req->list, 1, PM_QOS_DEFAULT_VALUE);
> -	memset(pm_qos_req, 0, sizeof(*pm_qos_req));
> +	o = pm_qos_array[req->class];
> +	update_target(o, &req->list, 1, PM_QOS_DEFAULT_VALUE);

Same here.

> +	memset(req, 0, sizeof(*req));
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_request);
>  
>  /**
>   * pm_qos_add_notifier - sets notification entry for changes to target value
> - * @pm_qos_class: identifies which qos target changes should be notified.
> + * @class: identifies which qos target changes should be notified.
>   * @notifier: notifier block managed by caller.
>   *
>   * will register the notifier into a notification chain that gets called
> - * upon changes to the pm_qos_class target value.
> + * upon changes to the class target value.
>   */
> -int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
> +int pm_qos_add_notifier(int class, struct notifier_block *notifier)
>  {
>  	int retval;
>  
>  	retval = blocking_notifier_chain_register(
> -			pm_qos_array[pm_qos_class]->notifiers, notifier);
> +			pm_qos_array[class]->notifiers, notifier);

Now, there's a question if we want to have one notifier chain for all
devices or if it's better to have a per-device notifier chain.  Both
approaches have their own advantages and drawbacks, but in the latter
case this code will have to be reworked.

Thanks,
Rafael
