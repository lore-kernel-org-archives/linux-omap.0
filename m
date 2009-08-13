From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Thu, 13 Aug 2009 14:39:10 -0700
Message-ID: <87zla3cs1t.fsf@deeprootsystems.com>
References: <50872.192.168.10.88.1249658504.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:21307 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZHMVjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 17:39:12 -0400
Received: by wf-out-1314.google.com with SMTP id 26so323781wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 14:39:13 -0700 (PDT)
In-Reply-To: <50872.192.168.10.88.1249658504.squirrel@dbdmail.itg.ti.com> (Madhusudhan Chikkature's message of "Fri\, 7 Aug 2009 20\:51\:44 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, felipe.balbi@nokia.com

"Madhusudhan Chikkature" <madhu.cr@ti.com> writes:

> Hi,
>
> Resending the patch after changing omap_hs* to omap_hsmmc.c.
>
> Regards,
> Madhu
>
>
>
> Update maintainers entry for TI OMAP HS MMC support.
>
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>

Madhu is the right guy for the job.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  MAINTAINERS |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/MAINTAINERS
> ===================================================================
> --- linux-omap-2.6.orig/MAINTAINERS
> +++ linux-omap-2.6/MAINTAINERS
> @@ -3698,7 +3698,13 @@ OMAP MMC SUPPORT
>  M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
>  L:	linux-omap@vger.kernel.org
>  S:	Maintained
> -F:	drivers/mmc/host/*omap*
> +F:	drivers/mmc/host/omap.c
> +
> +OMAP HS MMC SUPPORT
> +M:	Madhusudhan Chikkature <madhu.cr@ti.com>
> +L:	linux-omap@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/omap_hsmmc.c
>
>  OMAP RANDOM NUMBER GENERATOR SUPPORT
>  M:	Deepak Saxena <dsaxena@plexity.net>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
