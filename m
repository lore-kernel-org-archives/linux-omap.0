From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Date: Wed, 29 Feb 2012 10:13:04 +0000
Message-ID: <4F4DFA30.2040503@gmx.de>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com> <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:43891 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030857Ab2B2KNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 05:13:30 -0500
In-Reply-To: <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> ovl->enable/disable are meant to be synchronous so that they can handle
> the configuration of fifo sizes. The current kernel doesn't configure
> fifo sizes yet, and so the code doesn't need to block to function (from
> omapdss driver's perspective).
> 
> However, for the users of omapdss a non-blocking ovl->disable is
> confusing, because they don't know when the memory area is not used
> any more.
> 
> Furthermore, when the fifo size configuration is added in the next merge
> window, the change from non-blocking to blocking could cause side
> effects to the users of omapdss. So by making the functions block
> already will keep them behaving in the same manner.

Is there any difference to doing it now?
I agree that this should be fixed but if we can't avoid breaking users I'd
prefer to break them in a merge window not in late rc stage. Or did we introduce
these functions just in the last merge window?


Best regards,

Florian Tobias Schandinat

> 
> And, while not the main purpose of this patch, this will also remove the
> compile warning:
> 
> drivers/video/omap2/dss/apply.c:350: warning:
> 'wait_pending_extra_info_updates' defined but not used
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 052dc87..87b3e25 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -1276,6 +1276,9 @@ int dss_ovl_enable(struct omap_overlay *ovl)
>  
>  	spin_unlock_irqrestore(&data_lock, flags);
>  
> +	/* wait for overlay to be enabled */
> +	wait_pending_extra_info_updates();
> +
>  	mutex_unlock(&apply_lock);
>  
>  	return 0;
> @@ -1313,6 +1316,9 @@ int dss_ovl_disable(struct omap_overlay *ovl)
>  
>  	spin_unlock_irqrestore(&data_lock, flags);
>  
> +	/* wait for the overlay to be disabled */
> +	wait_pending_extra_info_updates();
> +
>  	mutex_unlock(&apply_lock);
>  
>  	return 0;

