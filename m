From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/6] OMAP: hwmod: Temp fixes to get hwmod registers work
Date: Thu, 20 May 2010 10:26:59 -0700
Message-ID: <87zkzueb6k.fsf@deeprootsystems.com>
References: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
	<1273248424-15943-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:45270 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab0ETR1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 13:27:03 -0400
Received: by pzk6 with SMTP id 6so28421pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 10:27:01 -0700 (PDT)
In-Reply-To: <1273248424-15943-7-git-send-email-b-cousson@ti.com> (Benoit Cousson's message of "Fri\,  7 May 2010 18\:07\:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Do not disable any clocks yet since not all drivers are adapted
> and rely on bootloader to enable clocks
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 302f2c8..9f7cb9f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -524,6 +524,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
>  
> +	return 0;
> +

again, a cpu_is_* would be preferred, even for a temporary hack
as this obviously affects OMAP3 as well.

Kevin
