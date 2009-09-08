From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: resource: Fix race in register_resource()
Date: Tue, 08 Sep 2009 15:39:05 -0700
Message-ID: <87k509kqnq.fsf@deeprootsystems.com>
References: <1252006638-1697-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:53829 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZIHWjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 18:39:06 -0400
Received: by pxi7 with SMTP id 7so3698077pxi.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2009 15:39:08 -0700 (PDT)
In-Reply-To: <1252006638-1697-1-git-send-email-mike@android.com> (Mike Chan's message of "Thu\,  3 Sep 2009 12\:37\:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> Checking if the resource is already registered and adding to the list
> must be atomic or bad things can happen.
>
> Signed-off-by: Mike Chan <mike@android.com>

Functionally, this looks fine.  Some procedural details still to work
out:

Are you the original author of this?  or was it Chunqiu or Limei?  The
changelog should be prefixed with a From: line of the original author
(handled by git-format-patch) if it was not you.  Also add the other's
signoffs if appropriate.

What tree does this apply to?  It's not specified, and does not apply
to either current PM branch or pm-2.6.29. 

Kevin

> ---
>  arch/arm/plat-omap/resource.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
> index e9ace13..9d20249 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -253,6 +253,7 @@ int resource_refresh(void)
>   */
>  int resource_register(struct shared_resource *resp)
>  {
> +	int ret = 0;
>  	if (!resp)
>  		return -EINVAL;
>  
> @@ -260,13 +261,15 @@ int resource_register(struct shared_resource *resp)
>  		return -EINVAL;
>  
>  	/* Verify that the resource is not already registered */
> -	if (resource_lookup(resp->name))
> -		return -EEXIST;
> +	down(&res_mutex);
> +	if (_resource_lookup(resp->name)) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
>  
>  	INIT_LIST_HEAD(&resp->users_list);
>  	mutex_init(&resp->resource_mutex);
>  
> -	down(&res_mutex);
>  	/* Add the resource to the resource list */
>  	list_add(&resp->node, &res_list);
>  
> @@ -274,10 +277,11 @@ int resource_register(struct shared_resource *resp)
>  	if (resp->ops->init)
>  		resp->ops->init(resp);
>  
> -	up(&res_mutex);
>  	pr_debug("resource: registered %s\n", resp->name);
>  
> -	return 0;
> +out:
> +	up(&res_mutex);
> +	return ret;
>  }
>  EXPORT_SYMBOL(resource_register);
>  
> -- 
> 1.5.4.5
