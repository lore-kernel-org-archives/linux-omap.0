From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]omap: mux.c warning removal
Date: Wed, 05 May 2010 14:21:40 -0700
Message-ID: <87mxwe3uzf.fsf@deeprootsystems.com>
References: <0680EC522D0CC943BC586913CF3768C003B31651B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63278 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0EEVVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:21:46 -0400
Received: by pxi5 with SMTP id 5so1741349pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 14:21:46 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B31651B1@dbde02.ent.ti.com> (Keshava Munegowda's message of "Wed\, 5 May 2010 19\:14\:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> From: Keshava Munegowda <a0393220@ti.com>
>
> This patch removes the below warning 
> arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
> The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 
>
> Signed-off-by: Keshava Munegowda <a0393220@ti.com>
> Index: linux-2.6/arch/arm/mach-omap2/mux.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 05:28:47.000000000 +0530
> +++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-05 05:29:02.000000000 +0530
> @@ -49,7 +49,9 @@
>  	struct list_head	node;
>  };
>  
> +#ifdef CONFIG_ARCH_OMAP3
>  static unsigned long mux_phys;
> +#endif

Rather than add another #ifdef, just move this inside the existing
#ifdef farther down in the file.

Kevin
