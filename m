From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OMAP3 PM: Fix issue with opp_find_freq_floor
Date: Tue, 6 Apr 2010 11:14:20 -0500
Message-ID: <4BBB5DDC.3050000@ti.com>
References: <> <1270576596-8761-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38234 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab0DFQOY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Apr 2010 12:14:24 -0400
In-Reply-To: <1270576596-8761-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Sripathy, Vishwanath had written, on 04/06/2010 12:56 PM, the following:
> opp_find_freq_floor should return the lower "enabled* OPP from a starting freq
> from a start opp list. But current code returns next lower opp. This patch fixes
> this issue.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index bb8120e..13da451
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -208,7 +208,7 @@ struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq)
>  
>  	*freq = prev_opp->rate;
>  
> -	return oppl;
> +	return prev_opp;
>  }
>  
Thanks. yep. since we return *freq with the right rate, we should point 
also to the right opp.

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
