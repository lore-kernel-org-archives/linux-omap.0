From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Change the default silicon
Date: Thu, 12 Nov 2009 14:21:28 -0800
Message-ID: <20091112222127.GF24837@atomide.com>
References: <1256826908-14703-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62854 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbZKLWVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 17:21:24 -0500
Content-Disposition: inline
In-Reply-To: <1256826908-14703-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [091029 07:35]:
> Currently the default silicon - in absence of
> identification - is set to OMAP3630 ES1.0.
> 
> Though, condition may/should not arise; but
> the default should be latest in the most
> common silicon variant - currently OMAP3430
> ES3.1.

Is this still needed? To me it seems more likely there will
more 3630 based silicon than 3430 based silicon?

Regards,

Tony
 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 1c15112..0162623 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -243,8 +243,8 @@ void __init omap3_check_revision(void)
>  		}
>  		break;
>  	default:
> -		/* Unknown default to latest silicon rev as default*/
> -		omap_revision = OMAP3630_REV_ES1_0;
> +		/* Unknown. Default to latest among all variants */
> +		omap_revision = OMAP3430_REV_ES3_1;
>  	}
>  }
>  
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
