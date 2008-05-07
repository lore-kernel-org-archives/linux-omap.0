From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP:DISPC Register name typo
Date: Wed, 7 May 2008 16:22:00 -0700
Message-ID: <20080507232159.GS18682@atomide.com>
References: <c656a4d20805070030k1e5bcd39md4a7d3ce3730c56c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65413 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYEGXWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 19:22:02 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20805070030k1e5bcd39md4a7d3ce3730c56c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* arun c <arunedarath@mistralsolutions.com> [080507 00:31]:
> Hi all,
> 
> This patch corrects the register name typo in dispc.c.
> False read happens just after the reset(reading DISPC_CONTROL returns
> zero), this
> might be the reason it worked fine without any issue.

Pushing today.

Tony

> ############################################
> From 8734c18115caf53121c46002983b6c4763bd7f2b Mon Sep 17 00:00:00 2001
> From: arun <arunedarath@mistralsolutions.com>
> Date: Wed, 7 May 2008 12:25:40 +0530
> Subject: [PATCH] OMAP:DISPC Register name typo
> 
> DISPC_CONTROL was used instead of DISPC_SYSCONFIG.
> 
> Signed-off-by: arun <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/dispc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 4c055a2..6aff476 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -1393,7 +1393,7 @@ static int omap_dispc_init(struct omapfb_device
> *fbdev, int ext_mode,
>  	}
> 
>  	/* Enable smart idle and autoidle */
> -	l = dispc_read_reg(DISPC_CONTROL);
> +	l = dispc_read_reg(DISPC_SYSCONFIG);
>  	l &= ~((3 << 12) | (3 << 3));
>  	l |= (2 << 12) | (2 << 3) | (1 << 0);
>  	dispc_write_reg(DISPC_SYSCONFIG, l);
> -- 
> 1.5.3.4
> 
> ##########################################
> 
> Regards,
> Arun C

> From 8734c18115caf53121c46002983b6c4763bd7f2b Mon Sep 17 00:00:00 2001
> From: arun <arunedarath@mistralsolutions.com>
> Date: Wed, 7 May 2008 12:25:40 +0530
> Subject: [PATCH] OMAP:DISPC Register name typo
> 
> DISPC_CONTROL was used instead of DISPC_SYSCONFIG.
> 
> Signed-off-by: arun <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/dispc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 4c055a2..6aff476 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -1393,7 +1393,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>  	}
>  
>  	/* Enable smart idle and autoidle */
> -	l = dispc_read_reg(DISPC_CONTROL);
> +	l = dispc_read_reg(DISPC_SYSCONFIG);
>  	l &= ~((3 << 12) | (3 << 3));
>  	l |= (2 << 12) | (2 << 3) | (1 << 0);
>  	dispc_write_reg(DISPC_SYSCONFIG, l);
> -- 
> 1.5.3.4
> 

