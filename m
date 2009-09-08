From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [ARM] omap: resource: Make resource_refresh() thread safe.
Date: Tue, 08 Sep 2009 15:45:50 -0700
Message-ID: <87eiqhkqch.fsf@deeprootsystems.com>
References: <1252019887-4463-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:53882 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZIHWpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 18:45:50 -0400
Received: by pzk39 with SMTP id 39so3548972pzk.15
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2009 15:45:53 -0700 (PDT)
In-Reply-To: <1252019887-4463-1-git-send-email-mike@android.com> (Mike Chan's message of "Thu\,  3 Sep 2009 16\:18\:07 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

Mike Chan <mike@android.com> writes:

> Need to lock the res_mutex when traversing the res_list.
>
> Signed-off-by: Mike Chan <mike@android.com>

Looks good, thanks.

Pushed to PM branch and pm-2.6.29.

Kevin

> ---
>  arch/arm/plat-omap/resource.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
> index 25072cd..4631912 100644
> --- a/arch/arm/plat-omap/resource.c
> +++ b/arch/arm/plat-omap/resource.c
> @@ -234,11 +234,13 @@ int resource_refresh(void)
>  	struct shared_resource *resp = NULL;
>  	int ret = 0;
>  
> +	down(&res_mutex);
>  	list_for_each_entry(resp, &res_list, node) {
>  		ret = update_resource_level(resp);
>  		if (ret)
>  			break;
>  	}
> +	up(&res_mutex);
>  	return ret;
>  }
>  
> -- 
> 1.5.4.5
