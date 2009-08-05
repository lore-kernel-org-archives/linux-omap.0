From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH] Maintainers update for hsmmc driver
Date: Wed, 5 Aug 2009 18:51:37 -0500
Message-ID: <4A7A1B09.2040006@ti.com>
References: <39332.192.168.10.88.1249515741.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZHEXvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Aug 2009 19:51:48 -0400
In-Reply-To: <39332.192.168.10.88.1249515741.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>

Chikkature Rajashekar, Madhusudhan had written, on 08/05/2009 06:42 PM, 
the following:
> 
no body?
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-omap-2.6/MAINTAINERS
> ===================================================================
> --- linux-omap-2.6.orig/MAINTAINERS
> +++ linux-omap-2.6/MAINTAINERS
> @@ -3700,6 +3700,12 @@ L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/*omap*
this regex *omap* and your regex *omap_hsmmc* are conflicting IMHO. 
maybe  Jarkko Lavinen <jarkko.lavinen@nokia.com> should comment on 
reducing scope?
> 
> +OMAP HS MMC SUPPORT
> +M:	Madhusudhan Chikkature <madhu.cr@ti.com>
> +L:	linux-omap@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/*omap_hsmmc*
> +
>  OMAP RANDOM NUMBER GENERATOR SUPPORT
>  M:	Deepak Saxena <dsaxena@plexity.net>
>  S:	Maintained
> 
-- 
Regards,
Nishanth Menon
