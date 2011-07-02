From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/11] PM QoS: support the dynamic devices insertion and removal
Date: Sat, 2 Jul 2011 23:14:21 +0200
Message-ID: <201107022314.21713.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com> <1309446685-17502-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50401 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab1GBVNS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 17:13:18 -0400
In-Reply-To: <1309446685-17502-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

Hi,

On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The devices wake-up latency constraints class of PM QoS is
> storing the constraints list using the device pm_info struct.
> 
> This patch adds the init and de-init of the per-device constraints
> list in order to support the dynamic insertion and removal
> of the devices in the system.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

The number of times this patch special cases PM_QOS_DEV_WAKEUP_LATENCY with
respect to the other PM QoS classes indicates a design issue, which kind of
corresponds with my comments on [3/11].

Thanks,
Rafael


> ---
>  drivers/base/power/main.c     |    8 +++--
>  include/linux/pm.h            |    1 +
>  include/linux/pm_qos_params.h |    2 +
>  kernel/pm_qos_params.c        |   70 ++++++++++++++++++++++++++++++++--------
>  4 files changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index b1fd96b..51f5526 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched.h>
>  #include <linux/async.h>
>  #include <linux/suspend.h>
> +#include <linux/pm_qos_params.h>
>  
>  #include "../base.h"
>  #include "power.h"
> @@ -96,8 +97,8 @@ void device_pm_add(struct device *dev)
>  			dev_name(dev->parent));
>  	list_add_tail(&dev->power.entry, &dpm_list);
>  	mutex_unlock(&dpm_list_mtx);
> -	/* ToDo: call PM QoS to init the per-device wakeup latency constraints */
> -	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
> +	/* Call PM QoS to init the per-device wakeup latency constraints */
> +	pm_qos_dev_wakeup_lat_init(dev);
>  }
>  
>  /**
> @@ -108,7 +109,8 @@ void device_pm_remove(struct device *dev)
>  {
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
> -	/* ToDo: call PM QoS to de-init the per-device wakeup latency constraints */
> +	/* Call PM QoS to de-init the per-device wakeup latency constraints */
> +	pm_qos_dev_wakeup_lat_deinit(dev);
>  	complete_all(&dev->power.completion);
>  	mutex_lock(&dpm_list_mtx);
>  	list_del_init(&dev->power.entry);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 35fe682..d9b6092 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -464,6 +464,7 @@ struct dev_pm_info {
>  	void			*subsys_data;  /* Owned by the subsystem. */
>  #endif
>  	struct plist_head	wakeup_lat_plist_head;
> +	int			wakeup_lat_init;
>  };
>  
>  extern void update_pm_runtime_accounting(struct device *dev);
> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
> index e6e16cb..5b6707a 100644
> --- a/include/linux/pm_qos_params.h
> +++ b/include/linux/pm_qos_params.h
> @@ -45,4 +45,6 @@ int pm_qos_add_notifier(int class, struct notifier_block *notifier);
>  int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
>  int pm_qos_request_active(struct pm_qos_request_list *req);
>  
> +void pm_qos_dev_wakeup_lat_init(struct device *dev);
> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev);
>  #endif
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index d61c8e5..6f25ccb 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -275,11 +275,21 @@ void pm_qos_add_request(struct pm_qos_request_list *pm_qos_req,
>  	struct pm_qos_object *o =  pm_qos_array[pm_qos_params->class];
>  	int new_value;
>  
> -	if ((pm_qos_params->class != PM_QOS_DEV_WAKEUP_LATENCY) &&
> -	    (pm_qos_request_active(pm_qos_req))) {
> -		WARN(1, KERN_ERR "pm_qos_add_request() called for already "
> -		     "added request\n");
> -		return;
> +	if (pm_qos_params->class == PM_QOS_DEV_WAKEUP_LATENCY) {
> +		if (!pm_qos_params->dev) {
> +			WARN(1, KERN_ERR "pm_qos_add_request() called for "
> +				"invalid device\n");
> +			return;
> +		}
> +		/* Silently return if the device is being released */
> +		if (!pm_qos_params->dev->power.wakeup_lat_init)
> +			return;
> +	} else {
> +		if (pm_qos_request_active(pm_qos_req)) {
> +			WARN(1, KERN_ERR "pm_qos_add_request() called for "
> +				"already added request\n");
> +			return;
> +		}
>  	}
>  
>  	if (pm_qos_params->value == PM_QOS_DEFAULT_VALUE)
> @@ -312,11 +322,16 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
>  	if (!pm_qos_req) /*guard against callers passing in null */
>  		return;
>  
> -	if ((pm_qos_req->class != PM_QOS_DEV_WAKEUP_LATENCY) &&
> -	    (!pm_qos_request_active(pm_qos_req))) {
> -		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown "
> -		     "object\n");
> -		return;
> +	if (pm_qos_req->class == PM_QOS_DEV_WAKEUP_LATENCY) {
> +		/* Silently return if the device is being released */
> +		if (!pm_qos_req->dev->power.wakeup_lat_init)
> +			return;
> +	} else {
> +		if (!pm_qos_request_active(pm_qos_req)) {
> +			WARN(1, KERN_ERR "pm_qos_update_request() called "
> +				"for unknown object\n");
> +			return;
> +		}
>  	}
>  
>  	if (new_value == PM_QOS_DEFAULT_VALUE)
> @@ -343,11 +358,16 @@ void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
>  		return;
>  		/* silent return to keep pcm code cleaner */
>  
> -	if ((pm_qos_req->class != PM_QOS_DEV_WAKEUP_LATENCY) &&
> -	    (!pm_qos_request_active(pm_qos_req))) {
> -		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown "
> -		     "object\n");
> +	if (pm_qos_req->class == PM_QOS_DEV_WAKEUP_LATENCY) {
> +		/* Silently return if the device is being released */
> +		if (!pm_qos_req->dev->power.wakeup_lat_init)
> +			return;
> +	} else {
> +		if (!pm_qos_request_active(pm_qos_req)) {
> +			WARN(1, KERN_ERR "pm_qos_remove_request() called "
> +				"for unknown object\n");
>  		return;
> +		}
>  	}
>  
>  	update_target(pm_qos_req, 1, PM_QOS_DEFAULT_VALUE);
> @@ -393,6 +413,28 @@ int pm_qos_remove_notifier(int class, struct notifier_block *notifier)
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
>  
> +/* Called from the device PM subsystem at device init */
> +void pm_qos_dev_wakeup_lat_init(struct device *dev)
> +{
> +	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
> +	dev->power.wakeup_lat_init = 1;
> +}
> +
> +/* Called from the device PM subsystem at device release */
> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev)
> +{
> +	struct pm_qos_request_list *req, *tmp;
> +
> +	dev->power.wakeup_lat_init = 0;
> +
> +	/* Flush the constraints list for the device */
> +	plist_for_each_entry_safe(req, tmp,
> +				  &dev->power.wakeup_lat_plist_head,
> +				  list)
> +		update_target(req, 1, PM_QOS_DEFAULT_VALUE);
> +	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
> +}
> +
>  static int pm_qos_power_open(struct inode *inode, struct file *filp)
>  {
>  	struct pm_qos_parameters pm_qos_params;
> 

