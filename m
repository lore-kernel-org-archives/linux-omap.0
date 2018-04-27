From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MAINTAINERS: update OMAP MMC entry
Date: Fri, 27 Apr 2018 14:25:04 -0700
Message-ID: <20180427212504.GE5671@atomide.com>
References: <20180427212228.25426-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180427212228.25426-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [180427 21:24]:
> Jarkko's e-mail address hasn't worked for a long time. We still want
> to keep this driver working as it is critical for some of the OMAP boards.
> I use and test this driver frequently, so add myself as a maintainer
> with "Odd Fixes" status.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Good idea:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e41e12a88a4..0dbac7e43b17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10206,9 +10206,9 @@ F:	drivers/media/platform/omap3isp/
>  F:	drivers/staging/media/omap4iss/
>  
>  OMAP MMC SUPPORT
> -M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
> +M:	Aaro Koskinen <aaro.koskinen@iki.fi>
>  L:	linux-omap@vger.kernel.org
> -S:	Maintained
> +S:	Odd Fixes
>  F:	drivers/mmc/host/omap.c
>  
>  OMAP POWER MANAGEMENT SUPPORT
> -- 
> 2.17.0
> 
