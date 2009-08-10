From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Linux-omap PM:  Fix dead lock condition in resource_release(vdd1_opp)
Date: Mon, 10 Aug 2009 09:23:20 -0700
Message-ID: <87ws5bk58n.fsf@deeprootsystems.com>
References: <DF4DCBD3DB270B419320B577AC0C3C8602F4801A@zmy16exm62.ds.mot.com>
	<DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:64381 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbZHJQXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 12:23:22 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1138715wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2009 09:23:23 -0700 (PDT)
In-Reply-To: <DF4DCBD3DB270B419320B577AC0C3C8602F48030@zmy16exm62.ds.mot.com> (Wang Limei-E's message of "Sat\, 8 Aug 2009 04\:55\:40 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Limei-E12499 <E12499@motorola.com>
Cc: linux-omap@vger.kernel.org

"Wang Limei-E12499" <E12499@motorola.com> writes:

> I am using linux-omap pm-2.6.29
> <http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=s
> hortlog;h=pm-2.6.29>  branch,found a dead lock condition in:
> arch/arm/plat-omap/resource.c->resource_release().   
>  
> The dead lock happens when using resource_request("vdd1_opp",&dev,...)
> and resource_release("vdd1_opp", &dev) to set and release vdd1 opp
> constraint. The  scenario is:  
>  
> plat-omap/resource.c/resource_release("vdd1_opp",
> &dev)==>resource.c/update_resource_level()=>mach-omap2/resource34xx.c/se
> t_opp().  In set_opp(),  if the target_level of vdd1 is less than
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
> The patch to fix this issue is below, will you pls review it and let me
> know your feedback?
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

