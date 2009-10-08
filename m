From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]  OMAP3: PM: Fix VDD2 OPP1 issue
Date: Thu, 08 Oct 2009 06:50:59 -0700
Message-ID: <878wfmhu4c.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D062B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:36658 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163AbZJHNvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:51:39 -0400
Received: by pxi9 with SMTP id 9so5789611pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 08 Oct 2009 06:51:02 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D062B@dbde02.ent.ti.com> (Teerth Reddy's message of "Thu\, 8 Oct 2009 14\:51\:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From 144669d941a432875db37ae9431847f6753e566e Mon Sep 17 00:00:00 2001
> From: Teerth Reddy <teerth@ti.com>
> Date: Wed, 9 Sep 2009 11:01:04 +0530
> Subject: [PATCH] ARM: OMAP3: PM: Fix VDD2 OPP1 issue
>
> This patch fixes the VDD2 OPP1 issue. The patch has change
> which does not allow VDD2 OPP setting to 1.VDD2 should not be put 
> at OPP1 as this is not a supported OPP for VDD2

Patch looks fine, but shortlog (subject) and changelog should be more
clear.  These should be written for people who are not as familiar
with the code.  For example, seeing this shortlog in a git history
would not be helpful as the irst thing one would ask is "what OPP1
issue?"

How about something like this:

Subject: OMAP3: PM: do not allow OPP1 allow for VDD2

Since OPP1 is not a supported OPP for VDD2, do not allow it to be
changed using the sysfs interface.

Kevin


> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index fec7d00..d0e03c4 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -195,7 +195,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		}
>  		resource_set_opp_level(VDD1_OPP, value, flags);
>  	} else if (attr == &vdd2_opp_attr) {
> -		if (value < 1 || value > 3) {
> +		if (value < 2 || value > 3) {
>  			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
>  			return -EINVAL;
>  		}
> -- 
> 1.5.4.7
