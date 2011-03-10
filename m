From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] OMAP3: wdtimer: Fix CORE idle
Date: Thu, 10 Mar 2011 04:08:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100402500.15132@utopia.booyaka.com>
References: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39557 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1CJLIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 06:08:24 -0500
In-Reply-To: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

On Thu, 10 Mar 2011, Kalle Jokiniemi wrote:

> These patches fix the issue where the wdtimer blocks CORE idle
> transitions on n900 (OMAP3). The root cause was that SMART idle
> mode in wdtimer did not allow the CORE idle transition to happen.
> 
> Paul, I added your S-o-bs to the patches already. Please check
> that they are ok by you.

Thanks, they look mostly fine to me.  What do you think about saying 
something like this in the commit message on the first one?

This patch is based on a patch created by Kalle Jokiniemi:
https://patchwork.kernel.org/patch/618231/
which is itself based on a patch created by Atal
Shargorodsky: http://lkml.org/lkml/2009/3/10/266.

Also, I guess we should get an Acked-by for the second patch from Wim Van 
Sebroeck <wim@iguana.be> since he is the maintainer.  Could you forward a 
copy of the second patch to linux-watchdog@vger.kernel.org and Wim and 
request his Ack?

thanks,

- Paul

> 
> Paul Walmsley (2):
>   Watchdog: omap_wdt: add fine grain runtime-pm
>   OMAP3: wdtimer: Fix CORE idle transition
> 
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>  drivers/watchdog/omap_wdt.c                |   25 +++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


