From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/13] OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
Date: Wed, 23 Jun 2010 23:02:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006232254430.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52306 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0FXFCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 01:02:34 -0400
In-Reply-To: <1277336563-24988-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

something doesn't make sense in this patch...

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> If an omap_hwmod is setup using HWMOD_INIT_NO_IDLE flag, there is
> currently way to idle it since omap_hwmod_idle() requires the hwmod to
> be in the enabled state.

The only thing that HWMOD_INIT_NO_IDLE does is prevent the hwmod from 
being idled at the end of _setup().  By that time, the hwmod has already 
been enabled, and its state has been set to _HWMOD_STATE_ENABLED.  So 
there shouldn't be anything preventing the hwmod from being idled at that 
point?

Maybe the problem is that some hwmods were failing _wait_target_ready() 
and so were never entering the ENABLED state?  If so, that looks like it's 
fixed appropriately by your patch 3.

> This patch adds a check to omap_hwmod_idle() so if the hwmod was has
> the INIT_NO_IDLE flag, calling omap_hwmod_idle() will still succeed.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 95c9a5f..ac75407 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -938,7 +938,13 @@ static int _enable(struct omap_hwmod *oh)
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
> @@ -953,6 +959,9 @@ static int _idle(struct omap_hwmod *oh)
>  
>  	oh->_state = _HWMOD_STATE_IDLE;
>  
> +	/* Clear init flag which should only affect first call to idle */
> +	oh->flags &= ~HWMOD_INIT_NO_IDLE;


- Paul
