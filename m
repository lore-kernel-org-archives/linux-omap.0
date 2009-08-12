From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: pm: Fix error condition in _pwrdm_deps_lookup when pwrdm not found.
Date: Wed, 12 Aug 2009 15:53:16 -0700
Message-ID: <87skfwskyr.fsf@deeprootsystems.com>
References: <1250100755-29723-1-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:46219 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbZHLWxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 18:53:17 -0400
Received: by wf-out-1314.google.com with SMTP id 26so109086wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 15:53:18 -0700 (PDT)
In-Reply-To: <1250100755-29723-1-git-send-email-mike@android.com> (Mike Chan's message of "Wed\, 12 Aug 2009 11\:12\:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Mike Chan <mike@android.com> writes:

> Check pwrdm_name instead of the address of a null struct when at the
> end of pwrdm_dep array.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mike Chan <mike@android.com>

Thanks, to keep it all together, I'll revert the original and merge
this into a single patch.

Kevin

> ---
>  arch/arm/mach-omap2/powerdomain.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 0334609..02c1ef6 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -103,7 +103,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
>  
>  	}
>  
> -	if (!pd)
> +	if (!pd->pwrdm_name)
>  		return ERR_PTR(-ENOENT);
>  
>  	return pd->pwrdm;
> -- 
> 1.5.4.5
