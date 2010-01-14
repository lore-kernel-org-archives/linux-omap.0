From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Wed, 13 Jan 2010 16:53:20 -0800
Message-ID: <87aawhcxrz.fsf@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62689 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab0ANAxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 19:53:25 -0500
Received: by pwj9 with SMTP id 9so3305293pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 16:53:24 -0800 (PST)
In-Reply-To: <1262993213-19866-4-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Fri\,  8 Jan 2010 15\:26\:53 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
> currently way to idle it since omap_hwmod_idle() requires the hwmod to
> be in the enabled state.
>
> This patch adds a check to omap_hwmod_idle() so if the hwmod was has
> the INIT_NO_IDLE flag, calling omap_hwmod_idle() will still succeed.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Retracting this patch as it is no longer necessary after recent
hwmod updates from Paul.

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 307deea..2de4cc3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -869,7 +869,13 @@ static int _enable(struct omap_hwmod *oh)
>   */
>  static int _idle(struct omap_hwmod *oh)
>  {
> -	if (oh->_state != _HWMOD_STATE_ENABLED) {
> +	/*
> +	 * To idle, hwmod must be enabled, EXCEPT if hwmod was
> +	 * initialized using the INIT_NO_IDLE flag.  In this case it
> +	 * will not yet be enabled so we have to allow it to be idled.
> +	 */
> +	if ((oh->_state != _HWMOD_STATE_ENABLED) &&
> +	    !(oh->flags & HWMOD_INIT_NO_IDLE)) {
>  		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
>  		     "enabled state\n", oh->name);
>  		return -EINVAL;
> @@ -884,6 +890,9 @@ static int _idle(struct omap_hwmod *oh)
>  
>  	oh->_state = _HWMOD_STATE_IDLE;
>  
> +	/* Clear init flag which should only affect first call to idle */
> +	oh->flags &= ~HWMOD_INIT_NO_IDLE;
> +
>  	return 0;
>  }
>  
> -- 
> 1.6.6.rc2.1.g42108
