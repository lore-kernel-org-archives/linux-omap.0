From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Tue, 18 Aug 2009 17:03:15 +0200
Message-ID: <87vdkli2q4.fsf@deeprootsystems.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
	<DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com>
	<87ws5bk58n.fsf@deeprootsystems.com>
	<DF4DCBD3DB270B419320B577AC0C3C8602F94E6B@zmy16exm62.ds.mot.com>
	<87d46zoojb.fsf@deeprootsystems.com>
	<DF4DCBD3DB270B419320B577AC0C3C8602F95260@zmy16exm62.ds.mot.com>
	<DF4DCBD3DB270B419320B577AC0C3C8602F95518@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:44047 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758653AbZHRPDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 11:03:23 -0400
Received: by pxi34 with SMTP id 34so1846546pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 08:03:23 -0700 (PDT)
In-Reply-To: <DF4DCBD3DB270B419320B577AC0C3C8602F95518@zmy16exm62.ds.mot.com> (Wang Limei-E's message of "Tue\, 18 Aug 2009 00\:50\:25 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Limei-E12499 <E12499@motorola.com>
Cc: linux-omap@vger.kernel.org, Chunqiu Wang <cqwang@motorola.com>

"Wang Limei-E12499" <E12499@motorola.com> writes:

> Seems like I did not submit the patch in the right way, before I setup
> my mail correctly, attach the patches in the mail. 

You're patches are still line-wrapped.

I strongly recommend using git-format-patch and git-send-email to
submit patches. Chunqiu was able to do this.  Please consult him.

Also, no need to CC linux-omap-owner.  linux-omap is all that is needed.

Thanks,

Kevin


> PATCH1:0001-Add-per-resource-mutex-for-OMAP-resource-framework.patch
>
> From b4e9cc01f9d1aaeec39cc1ee794e5efaec61c781 Mon Sep 17 00:00:00 2001
> From: Chunqiu Wang <cqwang@motorola.com>
> Date: Fri, 14 Aug 2009 17:34:32 +0800
> Subject: [PATCH] Add per-resource mutex for OMAP resource framework
>
> Current OMAP resource fwk uses a global res_mutex
> for resource_request and resource_release calls
> for all the available resources.It may cause dead 
> lock if resource_request/resource_release is called
> recursively. 
>
> For current OMAP3 VDD1/VDD2 resource, the change_level
> implementation is mach-omap2/resource34xx.c/set_opp(),
> when using resource_release to remove vdd1 constraint,
> this function may call resource_release again to release
> Vdd2 constrait if target vdd1 level is less than OPP3.
> in this scenario, the global res_mutex down operation
> will be called again, this will cause the second
> down operation hang there.
>
> To fix the problem, per-resource mutex is added
> to avoid hangup when resource_request/resource_release
> is called recursively.
>
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> ---
>  arch/arm/plat-omap/include/mach/resource.h |    2 ++
>  arch/arm/plat-omap/resource.c              |   27
> +++++++++++++++------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/resource.h
> b/arch/arm/plat-omap/include/mach/resource.h
> index f91d8ce..d482fb8 100644
> --- a/arch/arm/plat-omap/include/mach/resource.h
> +++ b/arch/arm/plat-omap/include/mach/resource.h
> @@ -46,6 +46,8 @@ struct shared_resource {
>  	/* Shared resource operations */
>  	struct shared_resource_ops *ops;
>  	struct list_head node;
> +	/* Protect each resource */
> +	struct mutex resource_mutex;
>  };
>  
>  struct shared_resource_ops {
> diff --git a/arch/arm/plat-omap/resource.c
> b/arch/arm/plat-omap/resource.c
> index ec31727..5eae4e8 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource *resp)
>  		return -EEXIST;
>  
>  	INIT_LIST_HEAD(&resp->users_list);
> +	mutex_init(&resp->resource_mutex);
>  
>  	down(&res_mutex);
>  	/* Add the resource to the resource list */
> @@ -326,14 +327,14 @@ int resource_request(const char *name, struct
> device *dev,
>  	struct  users_list *user;
>  	int 	found = 0, ret = 0;
>  
> -	down(&res_mutex);
> -	resp = _resource_lookup(name);
> +	resp = resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_request: Invalid resource
> name\n");
>  		ret = -EINVAL;
> -		goto res_unlock;
> +		goto ret;
>  	}
>  
> +	mutex_lock(&resp->resource_mutex);
>  	/* Call the resource specific validate function */
>  	if (resp->ops->validate_level) {
>  		ret = resp->ops->validate_level(resp, level);
> @@ -362,7 +363,7 @@ int resource_request(const char *name, struct device
> *dev,
>  	user->level = level;
>  
>  res_unlock:
> -	up(&res_mutex);
> +	mutex_unlock(&resp->resource_mutex);
>  	/*
>  	 * Recompute and set the current level for the resource.
>  	 * NOTE: update_resource level moved out of spin_lock, as it may
> call
> @@ -371,6 +372,7 @@ res_unlock:
>  	 */
>  	if (!ret)
>  		ret = update_resource_level(resp);
> +ret:
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_request);
> @@ -393,14 +395,14 @@ int resource_release(const char *name, struct
> device *dev)
>  	struct users_list *user;
>  	int found = 0, ret = 0;
>  
> -	down(&res_mutex);
> -	resp = _resource_lookup(name);
> +	resp = resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_release: Invalid resource
> name\n");
>  		ret = -EINVAL;
> -		goto res_unlock;
> +		goto ret;
>  	}
>  
> +	mutex_lock(&resp->resource_mutex);
>  	list_for_each_entry(user, &resp->users_list, node) {
>  		if (user->dev == dev) {
>  			found = 1;
> @@ -421,7 +423,9 @@ int resource_release(const char *name, struct device
> *dev)
>  	/* Recompute and set the current level for the resource */
>  	ret = update_resource_level(resp);
>  res_unlock:
> -	up(&res_mutex);
> +	mutex_unlock(&resp->resource_mutex);
> +
> +ret:
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_release);
> @@ -438,15 +442,14 @@ int resource_get_level(const char *name)
>  	struct shared_resource *resp;
>  	u32 ret;
>  
> -	down(&res_mutex);
> -	resp = _resource_lookup(name);
> +	resp = resource_lookup(name);
>  	if (!resp) {
>  		printk(KERN_ERR "resource_release: Invalid resource
> name\n");
> -		up(&res_mutex);
>  		return -EINVAL;
>  	}
> +	mutex_lock(&resp->resource_mutex);
>  	ret = resp->curr_level;
> -	up(&res_mutex);
> +	mutex_unlock(&resp->resource_mutex);
>  	return ret;
>  }
>  EXPORT_SYMBOL(resource_get_level);
> -- 
> 1.5.4.3
>
> PATCH2:0002-Move-the-resource-level-update-into-mutex_lock-block.patch
>
>
> From 9cc371b5d7f2e049fe72bc946dcb8ec8e1de826c Mon Sep 17 00:00:00 2001
> From: Chunqiu Wang <cqwang@motorola.com>
> Date: Fri, 14 Aug 2009 17:43:13 +0800
> Subject: [PATCH] Move the resource level update into mutex_lock block.
>
> The update_resource_level is called outside of
> the mutex lock protection block due to an out of date
> spin lock mechanism, now mutex is used, so move
> the update_resource_level into mutex protection block.
>
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> ---
>  arch/arm/plat-omap/resource.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/plat-omap/resource.c
> b/arch/arm/plat-omap/resource.c
> index 5eae4e8..e2a003a 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -362,16 +362,11 @@ int resource_request(const char *name, struct
> device *dev,
>  	}
>  	user->level = level;
>  
> +	/* Recompute and set the current level for the resource */
> +	ret = update_resource_level(resp);
> +
>  res_unlock:
>  	mutex_unlock(&resp->resource_mutex);
> -	/*
> -	 * Recompute and set the current level for the resource.
> -	 * NOTE: update_resource level moved out of spin_lock, as it may
> call
> -	 * pm_qos_add_requirement, which does a kzmalloc. This won't be
> allowed
> -	 * in iterrupt context. The spin_lock still protects add/remove
> users.
> -	 */
> -	if (!ret)
> -		ret = update_resource_level(resp);
>  ret:
>  	return ret;
>  }
> -- 
> 1.5.4.3
>
>
> -----Original Message-----
> From: Wang Limei-E12499 
> Sent: Monday, August 17, 2009 11:13 AM
> To: 'khilman@deeprootsystems.com'
> Cc: Wang Limei-E12499; Wang Sawsd-A24013
> Subject: RE: Linux-omap PM: Fix dead lock condition in
> resource_release(vdd1_opp)
>
>  
> Kevin, 
>
> Seems like I did not submit the patch in the recommended way,I will try
> to be better in the future.
>
> If you can review  the patch and feedback, I will apperciate it. 
>
> Thanks,
> Limei
>
> -----Original Message-----
> From: Wang Limei-E12499
> Sent: Friday, August 14, 2009 5:44 PM
> To: Kevin Hilman
> Cc: Romit Dasgupta; linux-omap@vger.kernel.org; Wang Sawsd-A24013; Wang
> Limei-E12499
> Subject: RE: Linux-omap PM: Fix dead lock condition in
> resource_release(vdd1_opp)
>
>  
> Kevin, 
>
> Thanks for reviewing the patch. 
>
> Chunqiu and I revised the patch. Pls see the attachment. 
>
>
> Thanks,
> Limei,chunqiu
>
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, August 13, 2009 8:02 AM
> To: Wang Limei-E12499
> Cc: Romit Dasgupta; linux-omap@vger.kernel.org; Wang Sawsd-A24013
> Subject: Re: Linux-omap PM: Fix dead lock condition in
> resource_release(vdd1_opp)
>
> "Wang Limei-E12499" <E12499@motorola.com> writes:
>
>>  
>> Kevin and Romit,
>>
>> I agreed with you, thanks Kevin and Romit for the comments!   Chunqiu
>> Wang coded resource-based mutex, below is the patch. Pls review and 
>> let us know your feedback.
>>
>>
>> From 31f87ffb8eb1f854a9adb7fd96011d490f4655fa Mon Sep 17 00:00:00 2001
>> From: Chunqiu Wang <cqwang@motorola.com>
>> Date: Wed, 12 Aug 2009 16:22:09 +0800
>> Subject: [PATCH] Fix resource framework mutex lock issue when 
>> resource_get or resource_release are called nestedly.
>>
>
> Could use a shorter summary (subject) and a more detailed changelog.
>
> This patch is doing too many things in a single patch without enough
> explanation.
>
> Not only does it convert the global semaphore to a resource-specific
> semaphore, but it also changing the locking slightly by moving some
> things in/out of lock protection.  That should be described in the
> changelog as well.  
>
> Even better would be a first patch that simply converts the semaphore to
> a resource-specific *mutex* (not resource-specific semaphore.)  IOW, use
> mutex API in <linux/mutex.h>:
>
>   struct mutex;
>   init_mutex()
>   mutex_lock()
>   mutex_unlock()
>   mutex_is_lockec()
>   ...
>
> Then, add a 2nd patch which does any reworking of the critical sections.
>
> Kevin
>
>
>> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>> ---
>>  arch/arm/plat-omap/include/mach/resource.h |    2 +
>>  arch/arm/plat-omap/resource.c              |   38
>> +++++++++++++--------------
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/resource.h
>> b/arch/arm/plat-omap/include/mach/resource.h
>> index f91d8ce..389cb67 100644
>> --- a/arch/arm/plat-omap/include/mach/resource.h
>> +++ b/arch/arm/plat-omap/include/mach/resource.h
>> @@ -22,6 +22,7 @@
>>  
>>  #include <linux/list.h>
>>  #include <linux/mutex.h>
>> +#include <linux/semaphore.h>
>>  #include <linux/device.h>
>>  #include <mach/cpu.h>
>>  
>> @@ -46,6 +47,7 @@ struct shared_resource {
>>  	/* Shared resource operations */
>>  	struct shared_resource_ops *ops;
>>  	struct list_head node;
>> +	struct semaphore resource_mutex;
>>  };
>>  
>>  struct shared_resource_ops {
>> diff --git a/arch/arm/plat-omap/resource.c 
>> b/arch/arm/plat-omap/resource.c index ec31727..758a138 100644
>> --- a/arch/arm/plat-omap/resource.c
>> +++ b/arch/arm/plat-omap/resource.c
>> @@ -264,6 +264,7 @@ int resource_register(struct shared_resource
> *resp)
>>  		return -EEXIST;
>>  
>>  	INIT_LIST_HEAD(&resp->users_list);
>> +	sema_init(&resp->resource_mutex, 1);
>>  
>>  	down(&res_mutex);
>>  	/* Add the resource to the resource list */ @@ -326,14 +327,14
> @@ 
>> int resource_request(const char *name, struct device *dev,
>>  	struct  users_list *user;
>>  	int 	found = 0, ret = 0;
>>  
>> -	down(&res_mutex);
>> -	resp = _resource_lookup(name);
>> +	resp = resource_lookup(name);
>>  	if (!resp) {
>>  		printk(KERN_ERR "resource_request: Invalid resource
> name\n");
>>  		ret = -EINVAL;
>> -		goto res_unlock;
>> +		goto ret;
>>  	}
>>  
>> +	down(&resp->resource_mutex);
>>  	/* Call the resource specific validate function */
>>  	if (resp->ops->validate_level) {
>>  		ret = resp->ops->validate_level(resp, level); @@ -361,16
> +362,12 @@ 
>> int resource_request(const char *name, struct device *dev,
>>  	}
>>  	user->level = level;
>>  
>> +	/* Recompute and set the current level for the resource */
>> +	ret = update_resource_level(resp);
>>  res_unlock:
>> -	up(&res_mutex);
>> -	/*
>> -	 * Recompute and set the current level for the resource.
>> -	 * NOTE: update_resource level moved out of spin_lock, as it may
>> call
>> -	 * pm_qos_add_requirement, which does a kzmalloc. This won't be
>> allowed
>> -	 * in iterrupt context. The spin_lock still protects add/remove
>> users.
>> -	 */
>> -	if (!ret)
>> -		ret = update_resource_level(resp);
>> +	up(&resp->resource_mutex);
>> +
>> +ret:
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(resource_request);
>> @@ -393,14 +390,14 @@ int resource_release(const char *name, struct 
>> device *dev)
>>  	struct users_list *user;
>>  	int found = 0, ret = 0;
>>  
>> -	down(&res_mutex);
>> -	resp = _resource_lookup(name);
>> +	resp = resource_lookup(name);
>>  	if (!resp) {
>>  		printk(KERN_ERR "resource_release: Invalid resource
> name\n");
>>  		ret = -EINVAL;
>> -		goto res_unlock;
>> +		goto ret;
>>  	}
>>  
>> +	down(&resp->resource_mutex);
>>  	list_for_each_entry(user, &resp->users_list, node) {
>>  		if (user->dev == dev) {
>>  			found = 1;
>> @@ -421,7 +418,9 @@ int resource_release(const char *name, struct 
>> device
>> *dev)
>>  	/* Recompute and set the current level for the resource */
>>  	ret = update_resource_level(resp);
>>  res_unlock:
>> -	up(&res_mutex);
>> +	up(&resp->resource_mutex);
>> +
>> +ret:
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(resource_release);
>> @@ -438,15 +437,14 @@ int resource_get_level(const char *name)
>>  	struct shared_resource *resp;
>>  	u32 ret;
>>  
>> -	down(&res_mutex);
>> -	resp = _resource_lookup(name);
>> +	resp = resource_lookup(name);
>>  	if (!resp) {
>>  		printk(KERN_ERR "resource_release: Invalid resource
> name\n");
>> -		up(&res_mutex);
>>  		return -EINVAL;
>>  	}
>> +	down(&resp->resource_mutex);
>>  	ret = resp->curr_level;
>> -	up(&res_mutex);
>> +	up(&resp->resource_mutex);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(resource_get_level);
>> --
>> 1.5.4.3
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Monday, August 10, 2009 11:23 AM
>> To: Wang Limei-E12499
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Linux-omap PM: Fix dead lock condition in
>> resource_release(vdd1_opp)
>>
>> "Wang Limei-E12499" <E12499@motorola.com> writes:
>>
>>> I am using linux-omap pm-2.6.29
>>> <http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;
>>> a =s hortlog;h=pm-2.6.29>  branch,found a dead lock condition in:
>>> arch/arm/plat-omap/resource.c->resource_release().   
>>>  
>>> The dead lock happens when using
>>> resource_request("vdd1_opp",&dev,...)
>>> and resource_release("vdd1_opp", &dev) to set and release vdd1 opp 
>>> constraint. The  scenario is:
>>>  
>>> plat-omap/resource.c/resource_release("vdd1_opp",
>>> &dev)==>resource.c/update_resource_level()=>mach-omap2/resource34xx.c
>>> / se t_opp().  In set_opp(),  if the target_level of vdd1 is less 
>>> than OPP3,will release the constraint set on VDD2 by calling 
>>> resource_release(), but it will never return because can not get the 
>>> mutex which is holding  by the previous caller.
>>>  
>>> int resource_release(const char *name, struct device *dev)
>>> {           .......
>>> 	down(&res_mutex);
>>> 	........
>>> 	/* Recompute and set the current level for the resource */
>>> 	ret = update_resource_level(resp);
>>> res_unlock:
>>> 	up(&res_mutex);
>>> 	return ret;
>>> }
>>>
>>> int set_opp(struct shared_resource *resp, u32 target_level) {
>>> 	.....
>>>  if (resp == vdd1_resp) {
>>>       if (target_level < 3)
>>>            resource_release("vdd2_opp", &vdd2_dev); }
>>>  
>>> The patch to fix this issue is below, will you pls review it and let 
>>> me know your feedback?
>>>  
>>> From: Limei Wang <e12499@motorola.com>
>>> Date: Fri, 7 Aug 2009 11:40:35 -0500
>>> Subject: [PATCH] OMAP PM: Fix dead lock bug in 
>>> resourc_release(vdd1_opp).
>>>  
>>>
>>> Signed-off-by: Limei Wang <e12499@motorola.com>
>>> ---
>>>  arch/arm/plat-omap/resource.c |    6 ++++--
>>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>>  
>>> diff --git a/arch/arm/plat-omap/resource.c 
>>> b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
>>> --- a/arch/arm/plat-omap/resource.c
>>> +++ b/arch/arm/plat-omap/resource.c
>>> @@ -418,10 +418,12 @@ int resource_release(const char *name, struct 
>>> device *dev)
>>>     list_del(&user->node);
>>>     free_user(user);
>>>  
>>> -   /* Recompute and set the current level for the resource */
>>> -   ret = update_resource_level(resp);
>>>  res_unlock:
>>>     up(&res_mutex);
>>> +
>>> +   /* Recompute and set the current level for the resource */
>>> +   if (!ret)
>>> +       ret = update_resource_level(resp);
>>>     return ret;
>>>  }
>>>  EXPORT_SYMBOL(resource_release);
>>> --
>>> 1.5.6.3
>>
>> This is wrong for several reasons.
>>
>> First, you're not fixing the problem, you're just moving the call 
>> outside of the lock, thus creating other locking problems.
>>
>> Second, the various error paths would break because
>> update_resource_level() would be called on the 'res_unlock' error path
>
>> where it is not currently being called.
>>
>> A per-resource mutex as suggest by Romit seems like the right approach
>
>> to fixing this problem.
>>
>> Kevin
