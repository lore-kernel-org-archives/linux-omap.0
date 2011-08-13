From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 04/15] PM QoS: re-organize data structs
Date: Fri, 12 Aug 2011 19:56:29 -0700
Message-ID: <20110813025629.GD639@gvim.org>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
 <1313075212-8366-5-git-send-email-j-pihet@ti.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63956 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab1HMC4g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 22:56:36 -0400
Received: by gya6 with SMTP id 6so2359793gya.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 19:56:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313075212-8366-5-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Aug 11, 2011 at 05:06:41PM +0200, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> In preparation for the per-device constratins support, re-organize
> the data strctures:
> - add a struct pm_qos_constraints which contains the constraints
> related data
> - update struct pm_qos_object contents to the PM QoS internal object
> data. Add a pointer to struct pm_qos_constraints
> - update the internal code to use the new data structs.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  include/linux/pm_qos.h |   19 ++++++++++
>  kernel/power/qos.c     |   90 ++++++++++++++++++++++-------------------------
>  2 files changed, 61 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6b0968f..9772311 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -25,6 +25,25 @@ struct pm_qos_request {
>  	int pm_qos_class;
>  };
>  
> +enum pm_qos_type {
> +	PM_QOS_UNITIALIZED,
what is this for?

> +	PM_QOS_MAX,		/* return the largest value */
> +	PM_QOS_MIN		/* return the smallest value */
> +};
> +
> +/*
> + * Note: The lockless read path depends on the CPU accessing
> + * target_value atomically.  Atomic access is only guaranteed on all CPU
> + * types linux supports for 32 bit quantites
> + */
> +struct pm_qos_constraints {
> +	struct plist_head list;
> +	s32 target_value;	/* Do not change to 64 bit */
> +	s32 default_value;
> +	enum pm_qos_type type;
> +	struct blocking_notifier_head *notifiers;
> +};
> +
>  #ifdef CONFIG_PM
>  void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
>  			s32 value);
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index fa9a090..66e8d6f 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -49,62 +49,54 @@
>   * or pm_qos_object list and pm_qos_objects need to happen with pm_qos_lock
>   * held, taken with _irqsave.  One lock to rule them all
>   */
> -enum pm_qos_type {
> -	PM_QOS_MAX,		/* return the largest value */
> -	PM_QOS_MIN		/* return the smallest value */
> -};
> -
> -/*
> - * Note: The lockless read path depends on the CPU accessing
> - * target_value atomically.  Atomic access is only guaranteed on all CPU
> - * types linux supports for 32 bit quantites
> - */
>  struct pm_qos_object {
> -	struct plist_head constraints;
> -	struct blocking_notifier_head *notifiers;
> +	struct pm_qos_constraints *constraints;
>  	struct miscdevice pm_qos_power_miscdev;
>  	char *name;
> -	s32 target_value;	/* Do not change to 64 bit */
> -	s32 default_value;
> -	enum pm_qos_type type;
>  };
>  
>  static DEFINE_SPINLOCK(pm_qos_lock);
>  
>  static struct pm_qos_object null_pm_qos;
> +
>  static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> -static struct pm_qos_object cpu_dma_pm_qos = {
> -	.constraints = PLIST_HEAD_INIT(cpu_dma_pm_qos.constraints, pm_qos_lock),
> -	.notifiers = &cpu_dma_lat_notifier,
> -	.name = "cpu_dma_latency",
> +static struct pm_qos_constraints cpu_dma_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list, pm_qos_lock),
>  	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>  	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>  	.type = PM_QOS_MIN,
> +	.notifiers = &cpu_dma_lat_notifier,
> +};
> +static struct pm_qos_object cpu_dma_pm_qos = {
> +	.constraints = &cpu_dma_constraints,
> +	.name = "cpu_dma_latency",
>  };
>  
>  static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> -static struct pm_qos_object network_lat_pm_qos = {
> -	.constraints = PLIST_HEAD_INIT(network_lat_pm_qos.constraints,
> -				       pm_qos_lock),
> -	.notifiers = &network_lat_notifier,
> -	.name = "network_latency",
> +static struct pm_qos_constraints network_lat_constraints = {
> +	.list = PLIST_HEAD_INIT(network_lat_constraints.list, pm_qos_lock),
>  	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>  	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -	.type = PM_QOS_MIN
> +	.type = PM_QOS_MIN,
> +	.notifiers = &network_lat_notifier,
> +};
> +static struct pm_qos_object network_lat_pm_qos = {
> +	.constraints = &network_lat_constraints,
> +	.name = "network_latency",
>  };
> -
>  
>  static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> -static struct pm_qos_object network_throughput_pm_qos = {
> -	.constraints = PLIST_HEAD_INIT(network_throughput_pm_qos.constraints,
> -				       pm_qos_lock),
> -	.notifiers = &network_throughput_notifier,
> -	.name = "network_throughput",
> +static struct pm_qos_constraints network_tput_constraints = {
> +	.list = PLIST_HEAD_INIT(network_tput_constraints.list, pm_qos_lock),
>  	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>  	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>  	.type = PM_QOS_MAX,
> +	.notifiers = &network_throughput_notifier,
> +};
> +static struct pm_qos_object network_throughput_pm_qos = {
> +	.constraints = &network_tput_constraints,
> +	.name = "network_throughput",
>  };
> -
>  
>  static struct pm_qos_object *pm_qos_array[] = {
>  	&null_pm_qos,
> @@ -131,15 +123,15 @@ static const struct file_operations pm_qos_power_fops = {
>  /* unlocked internal variant */
>  static inline int pm_qos_get_value(struct pm_qos_object *o)
>  {
> -	if (plist_head_empty(&o->constraints))
> -		return o->default_value;
> +	if (plist_head_empty(&o->constraints->list))
> +		return o->constraints->default_value;
>  
> -	switch (o->type) {
> +	switch (o->constraints->type) {
>  	case PM_QOS_MIN:
> -		return plist_first(&o->constraints)->prio;
> +		return plist_first(&o->constraints->list)->prio;
>  
>  	case PM_QOS_MAX:
> -		return plist_last(&o->constraints)->prio;
> +		return plist_last(&o->constraints->list)->prio;
>  
>  	default:
>  		/* runtime check for not using enum */
> @@ -149,12 +141,12 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
>  
>  static inline s32 pm_qos_read_value(struct pm_qos_object *o)
>  {
> -	return o->target_value;
> +	return o->constraints->target_value;
>  }
>  
>  static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
>  {
> -	o->target_value = value;
> +	o->constraints->target_value = value;
>  }
>  
>  static void update_target(struct pm_qos_object *o, struct plist_node *node,
> @@ -172,20 +164,20 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
>  		 * with new value and add, then see if the extremal
>  		 * changed
>  		 */
> -		plist_del(node, &o->constraints);
> +		plist_del(node, &o->constraints->list);
>  		plist_node_init(node, value);
> -		plist_add(node, &o->constraints);
> +		plist_add(node, &o->constraints->list);
>  	} else if (del) {
> -		plist_del(node, &o->constraints);
> +		plist_del(node, &o->constraints->list);
>  	} else {
> -		plist_add(node, &o->constraints);
> +		plist_add(node, &o->constraints->list);
>  	}
>  	curr_value = pm_qos_get_value(o);
>  	pm_qos_set_value(o, curr_value);
>  	spin_unlock_irqrestore(&pm_qos_lock, flags);
>  
>  	if (prev_value != curr_value)
> -		blocking_notifier_call_chain(o->notifiers,
> +		blocking_notifier_call_chain(o->constraints->notifiers,
>  					     (unsigned long)curr_value,
>  					     NULL);
>  }
> @@ -232,7 +224,7 @@ void pm_qos_add_request(struct pm_qos_request *req,
>  		return;
>  	}
>  	if (value == PM_QOS_DEFAULT_VALUE)
> -		new_value = o->default_value;
> +		new_value = o->constraints->default_value;
>  	else
>  		new_value = value;
>  	plist_node_init(&req->node, new_value);
> @@ -268,7 +260,7 @@ void pm_qos_update_request(struct pm_qos_request *req,
>  	o = pm_qos_array[req->pm_qos_class];
>  
>  	if (new_value == PM_QOS_DEFAULT_VALUE)
> -		temp = o->default_value;
> +		temp = o->constraints->default_value;
>  	else
>  		temp = new_value;
>  
> @@ -317,7 +309,8 @@ int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
>  	int retval;
>  
>  	retval = blocking_notifier_chain_register(
> -			pm_qos_array[pm_qos_class]->notifiers, notifier);
> +			pm_qos_array[pm_qos_class]->constraints->notifiers,
> +			notifier);
>  
>  	return retval;
>  }
> @@ -336,7 +329,8 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
>  	int retval;
>  
>  	retval = blocking_notifier_chain_unregister(
> -			pm_qos_array[pm_qos_class]->notifiers, notifier);
> +			pm_qos_array[pm_qos_class]->constraints->notifiers,
> +			notifier);
>  
>  	return retval;
>  }
> -- 
> 1.7.2.5
>

looks ok but I'm wondering what the uninititalized qos type is for.

--mark

