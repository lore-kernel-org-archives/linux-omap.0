From: "Wang Limei-E12499" <E12499@motorola.com>
Subject: RE: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Thu, 13 Aug 2009 11:24:17 +0800
Message-ID: <DF4DCBD3DB270B419320B577AC0C3C8602F94E6B@zmy16exm62.ds.mot.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com><DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com> <87ws5bk58n.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:49406 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbZHMDYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 23:24:42 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate2.mot.com (8.14.3/8.14.3) with ESMTP id n7D3Ohqn015714
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 20:24:43 -0700 (MST)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n7D3Ofef006584
	for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 22:24:42 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87ws5bk58n.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Romit Dasgupta <romit@ti.com>
Cc: linux-omap@vger.kernel.org, Wang Sawsd-A24013 <cqwang@motorola.com>, Wang Limei-E12499 <E12499@motorola.com>

 
Kevin and Romit, 

I agreed with you, thanks Kevin and Romit for the comments!   Chunqiu
Wang coded resource-based mutex, below is the patch. Pls review and let
us know your feedback. 


>From 31f87ffb8eb1f854a9adb7fd96011d490f4655fa Mon Sep 17 00:00:00 2001
From: Chunqiu Wang <cqwang@motorola.com>
Date: Wed, 12 Aug 2009 16:22:09 +0800
Subject: [PATCH] Fix resource framework mutex lock issue when
 resource_get or resource_release are called nestedly.


Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
---
 arch/arm/plat-omap/include/mach/resource.h |    2 +
 arch/arm/plat-omap/resource.c              |   38
+++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/resource.h
b/arch/arm/plat-omap/include/mach/resource.h
index f91d8ce..389cb67 100644
--- a/arch/arm/plat-omap/include/mach/resource.h
+++ b/arch/arm/plat-omap/include/mach/resource.h
@@ -22,6 +22,7 @@
 
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/semaphore.h>
 #include <linux/device.h>
 #include <mach/cpu.h>
 
@@ -46,6 +47,7 @@ struct shared_resource {
 	/* Shared resource operations */
 	struct shared_resource_ops *ops;
 	struct list_head node;
+	struct semaphore resource_mutex;
 };
 
 struct shared_resource_ops {
diff --git a/arch/arm/plat-omap/resource.c
b/arch/arm/plat-omap/resource.c
index ec31727..758a138 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -264,6 +264,7 @@ int resource_register(struct shared_resource *resp)
 		return -EEXIST;
 
 	INIT_LIST_HEAD(&resp->users_list);
+	sema_init(&resp->resource_mutex, 1);
 
 	down(&res_mutex);
 	/* Add the resource to the resource list */
@@ -326,14 +327,14 @@ int resource_request(const char *name, struct
device *dev,
 	struct  users_list *user;
 	int 	found = 0, ret = 0;
 
-	down(&res_mutex);
-	resp = _resource_lookup(name);
+	resp = resource_lookup(name);
 	if (!resp) {
 		printk(KERN_ERR "resource_request: Invalid resource
name\n");
 		ret = -EINVAL;
-		goto res_unlock;
+		goto ret;
 	}
 
+	down(&resp->resource_mutex);
 	/* Call the resource specific validate function */
 	if (resp->ops->validate_level) {
 		ret = resp->ops->validate_level(resp, level);
@@ -361,16 +362,12 @@ int resource_request(const char *name, struct
device *dev,
 	}
 	user->level = level;
 
+	/* Recompute and set the current level for the resource */
+	ret = update_resource_level(resp);
 res_unlock:
-	up(&res_mutex);
-	/*
-	 * Recompute and set the current level for the resource.
-	 * NOTE: update_resource level moved out of spin_lock, as it may
call
-	 * pm_qos_add_requirement, which does a kzmalloc. This won't be
allowed
-	 * in iterrupt context. The spin_lock still protects add/remove
users.
-	 */
-	if (!ret)
-		ret = update_resource_level(resp);
+	up(&resp->resource_mutex);
+
+ret:
 	return ret;
 }
 EXPORT_SYMBOL(resource_request);
@@ -393,14 +390,14 @@ int resource_release(const char *name, struct
device *dev)
 	struct users_list *user;
 	int found = 0, ret = 0;
 
-	down(&res_mutex);
-	resp = _resource_lookup(name);
+	resp = resource_lookup(name);
 	if (!resp) {
 		printk(KERN_ERR "resource_release: Invalid resource
name\n");
 		ret = -EINVAL;
-		goto res_unlock;
+		goto ret;
 	}
 
+	down(&resp->resource_mutex);
 	list_for_each_entry(user, &resp->users_list, node) {
 		if (user->dev == dev) {
 			found = 1;
@@ -421,7 +418,9 @@ int resource_release(const char *name, struct device
*dev)
 	/* Recompute and set the current level for the resource */
 	ret = update_resource_level(resp);
 res_unlock:
-	up(&res_mutex);
+	up(&resp->resource_mutex);
+
+ret:
 	return ret;
 }
 EXPORT_SYMBOL(resource_release);
@@ -438,15 +437,14 @@ int resource_get_level(const char *name)
 	struct shared_resource *resp;
 	u32 ret;
 
-	down(&res_mutex);
-	resp = _resource_lookup(name);
+	resp = resource_lookup(name);
 	if (!resp) {
 		printk(KERN_ERR "resource_release: Invalid resource
name\n");
-		up(&res_mutex);
 		return -EINVAL;
 	}
+	down(&resp->resource_mutex);
 	ret = resp->curr_level;
-	up(&res_mutex);
+	up(&resp->resource_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(resource_get_level);
-- 
1.5.4.3





-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: Monday, August 10, 2009 11:23 AM
To: Wang Limei-E12499
Cc: linux-omap@vger.kernel.org
Subject: Re: Linux-omap PM: Fix dead lock condition in
resource_release(vdd1_opp)

"Wang Limei-E12499" <E12499@motorola.com> writes:

> I am using linux-omap pm-2.6.29
> <http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a
> =s hortlog;h=pm-2.6.29>  branch,found a dead lock condition in:
> arch/arm/plat-omap/resource.c->resource_release().   
>  
> The dead lock happens when using resource_request("vdd1_opp",&dev,...)
> and resource_release("vdd1_opp", &dev) to set and release vdd1 opp 
> constraint. The  scenario is:
>  
> plat-omap/resource.c/resource_release("vdd1_opp",
> &dev)==>resource.c/update_resource_level()=>mach-omap2/resource34xx.c/
> se t_opp().  In set_opp(),  if the target_level of vdd1 is less than 
> OPP3,will release the constraint set on VDD2 by calling 
> resource_release(), but it will never return because can not get the 
> mutex which is holding  by the previous caller.
>  
> int resource_release(const char *name, struct device *dev)
> {           .......
> 	down(&res_mutex);
> 	........
> 	/* Recompute and set the current level for the resource */
> 	ret = update_resource_level(resp);
> res_unlock:
> 	up(&res_mutex);
> 	return ret;
> }
>
> int set_opp(struct shared_resource *resp, u32 target_level) {
> 	.....
>  if (resp == vdd1_resp) {
>       if (target_level < 3)
>            resource_release("vdd2_opp", &vdd2_dev); }
>  
> The patch to fix this issue is below, will you pls review it and let 
> me know your feedback?
>  
> From: Limei Wang <e12499@motorola.com>
> Date: Fri, 7 Aug 2009 11:40:35 -0500
> Subject: [PATCH] OMAP PM: Fix dead lock bug in 
> resourc_release(vdd1_opp).
>  
>
> Signed-off-by: Limei Wang <e12499@motorola.com>
> ---
>  arch/arm/plat-omap/resource.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>  
> diff --git a/arch/arm/plat-omap/resource.c 
> b/arch/arm/plat-omap/resource.c index ec31727..876fd12 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -418,10 +418,12 @@ int resource_release(const char *name, struct 
> device *dev)
>     list_del(&user->node);
>     free_user(user);
>  
> -   /* Recompute and set the current level for the resource */
> -   ret = update_resource_level(resp);
>  res_unlock:
>     up(&res_mutex);
> +
> +   /* Recompute and set the current level for the resource */
> +   if (!ret)
> +       ret = update_resource_level(resp);
>     return ret;
>  }
>  EXPORT_SYMBOL(resource_release);
> --
> 1.5.6.3

This is wrong for several reasons.

First, you're not fixing the problem, you're just moving the call
outside of the lock, thus creating other locking problems.

Second, the various error paths would break because
update_resource_level() would be called on the 'res_unlock' error path
where it is not currently being called.

A per-resource mutex as suggest by Romit seems like the right approach
to fixing this problem.

Kevin

