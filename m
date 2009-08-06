From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Thu, 6 Aug 2009 22:06:03 +0300
Message-ID: <20090806190602.GA4124@nokia.com>
References: <44306.192.168.10.88.1249576131.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58944 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbZHFTE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 15:04:59 -0400
Content-Disposition: inline
In-Reply-To: <44306.192.168.10.88.1249576131.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "Hunter Adrian (Nokia-D/Helsinki)" <adrian.hunter@nokia.com>

On Thu, Aug 06, 2009 at 06:28:51PM +0200, ext Madhusudhan Chikkature wrote:
> Hi,
> 
> Resending the patch after fixing the conflict pointed out by Nishant.
> 
> Regards,
> Madhu
> -----------------------------------------------
> 
> Update maintainers entry for TI OMAP HS MMC support.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
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
> +F:	drivers/mmc/host/omap_hs*

do you think there will be any omap_hs* file besides omap_hsmmc.c ??

why not just use omap_hsmmc.c ??

-- 
balbi
