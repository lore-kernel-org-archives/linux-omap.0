From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/6] OMAP: hwmod: Temporary disable dependency
Date: Thu, 20 May 2010 10:25:42 -0700
Message-ID: <87632ifpt5.fsf@deeprootsystems.com>
References: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
	<1273248424-15943-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:62920 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0ETRZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 13:25:46 -0400
Received: by pzk31 with SMTP id 31so34100pzk.16
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 10:25:45 -0700 (PDT)
In-Reply-To: <1273248424-15943-5-git-send-email-b-cousson@ti.com> (Benoit Cousson's message of "Fri\,  7 May 2010 18\:07\:02 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

Benoit Cousson <b-cousson@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Dependency not supported yet, hence comment all dependency handling
> code in hwmod.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 2fff39f..302f2c8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -908,7 +908,9 @@ static int _enable(struct omap_hwmod *oh)
>  
>  	/* XXX mux balls */
>  
> +#if 0
>  	_add_initiator_dep(oh, mpu_oh);
> +#endif
>  	_enable_clocks(oh);
>  
>  	r = _wait_target_ready(oh);
> @@ -949,7 +951,9 @@ static int _idle(struct omap_hwmod *oh)
>  
>  	if (oh->class->sysc)
>  		_sysc_idle(oh);
> +#if 0
>  	_del_initiator_dep(oh, mpu_oh);
> +#endif

At least, the temporaty hack should use cpu_is_* as to not
break OMAP3.

Kevin
