From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Added resource refresh to OPP unlock requests
Date: Thu, 14 May 2009 10:04:59 -0700
Message-ID: <87fxf7vcn8.fsf@deeprootsystems.com>
References: <1242302974-4060-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:29167 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZENRFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:05:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so867421wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:05:02 -0700 (PDT)
In-Reply-To: <1242302974-4060-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 14 May 2009 15\:09\:34 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> This will set the correct OPP after a lock has been released from sysfs.
>
> Applies on PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, pushing to PM branch today.

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index dde0af3..58ed520 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -166,6 +166,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		attr = &vdd1_opp_attr;
>  		if (vdd1_locked && value == 0) {
>  			resource_unlock_opp(VDD1_OPP);
> +			resource_refresh();
>  			vdd1_locked = 0;
>  			return n;
>  		}
> @@ -178,6 +179,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		attr = &vdd2_opp_attr;
>  		if (vdd2_locked && value == 0) {
>  			resource_unlock_opp(VDD2_OPP);
> +			resource_refresh();
>  			vdd2_locked = 0;
>  			return n;
>  		}
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
