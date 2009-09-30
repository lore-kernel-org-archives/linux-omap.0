From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: resource: Fix race in register_resource()
Date: Wed, 30 Sep 2009 16:49:26 -0700
Message-ID: <874oqkj8mx.fsf@deeprootsystems.com>
References: <1253230331-701-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:49726 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbZI3XtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 19:49:25 -0400
Received: by pxi32 with SMTP id 32so5909014pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 16:49:29 -0700 (PDT)
In-Reply-To: <1253230331-701-1-git-send-email-mike@android.com> (Mike Chan's message of "Thu\, 17 Sep 2009 16\:32\:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> Checking if the resource is already registered and adding to the list
> must be atomic or bad things can happen.
>
> Signed-off-by: Mike Chan <mike@android.com>
> ---
>  arch/arm/plat-omap/resource.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
> index 111020a..4631912 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -255,6 +255,7 @@ int resource_refresh(void)
>   */
>  int resource_register(struct shared_resource *resp)
>  {
> +	int ret = 0;
>  	if (!resp)
>  		return -EINVAL;
>  
> @@ -262,12 +263,13 @@ int resource_register(struct shared_resource *resp)
>  		return -EINVAL;
>  
>  	/* Verify that the resource is not already registered */
> -	if (resource_lookup(resp->name))
> -		return -EEXIST;
> +	down(&res_mutex);
> +	if (_resource_lookup(resp->name))
> +		ret = -EEXIST;
> +		goto out;

Ahem, you're rebased version has a little problem.  Missing {} block
mans this goto is always executed and no resources are ever added.

I'll fix this up manually before applying, but some more testing next
time would be helpful

Thanks,

Kevin


>  	INIT_LIST_HEAD(&resp->users_list);
>  
> -	down(&res_mutex);
>  	/* Add the resource to the resource list */
>  	list_add(&resp->node, &res_list);
>  
> @@ -275,10 +277,11 @@ int resource_register(struct shared_resource *resp)
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
