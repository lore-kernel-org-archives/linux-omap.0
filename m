From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]  OMAP3: PM: Do not allow OPP1 for VDD2
Date: Fri, 09 Oct 2009 07:43:31 -0700
Message-ID: <87iqeoy6ek.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D093D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:64722 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZJIOoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 10:44:09 -0400
Received: by pzk7 with SMTP id 7so2104994pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 09 Oct 2009 07:43:33 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D093D@dbde02.ent.ti.com> (Teerth Reddy's message of "Fri\, 9 Oct 2009 11\:38\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From 144669d941a432875db37ae9431847f6753e566e Mon Sep 17 00:00:00 2001
> From: Teerth Reddy <teerth@ti.com>
> Date: Wed, 9 Sep 2009 11:01:04 +0530
> Subject: OMAP3: PM: Do not allow OPP1 for VDD2
>
> Since OPP1 is not a supported OPP for VDD2, do not allow it to
> be changed using the sysfs interface.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>

Thanks, pulling into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm.c
> @@ -144,7 +144,7 @@ static ssize_t vdd_opp_store(struct kobj
>  		}
>  		resource_set_opp_level(VDD1_OPP, value, flags);
>  	} else if (attr == &vdd2_opp_attr) {
> -		if (value < 1 || value > 3) {
> +		if (value < 2 || value > 3) {
>  			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
>  			return -EINVAL;
>  		}
