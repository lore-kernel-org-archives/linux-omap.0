From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
Date: Tue, 17 Aug 2010 18:16:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E81E9434@dbde02.ent.ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
 <1280959968-23933-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab0HQMrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 08:47:01 -0400
In-Reply-To: <1280959968-23933-4-git-send-email-b-cousson@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayakold@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> Sent: Thursday, August 05, 2010 3:43 AM
> To: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
> paul@pwsan.com
> Cc: Nayak, Rajendra; Shilimkar, Santosh; Cousson, Benoit
> Subject: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
> 
> Force the softreset of every IPs during the _setup phase.
> IPs that cannot support softreset or that should not
> be reset must set the HWMOD_INIT_NO_RESET flag in the
> hwmod struct.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> index 53b08e3..91ad9c6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -856,8 +856,8 @@ static int _reset(struct omap_hwmod *oh)
> 
>  	/* clocks must be on for this operation */
>  	if (oh->_state != _HWMOD_STATE_ENABLED) {
> -		WARN(1, "omap_hwmod: %s: reset can only be entered from "
> -		     "enabled state\n", oh->name);
> +		pr_warning("omap_hwmod: %s: reset can only be entered from "
> +			   "enabled state\n", oh->name);
>  		return -EINVAL;
>  	}
> 
> @@ -874,8 +874,8 @@ static int _reset(struct omap_hwmod *oh)
>  			  MAX_MODULE_RESET_WAIT, c);
> 
>  	if (c == MAX_MODULE_RESET_WAIT)
> -		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
> -		     oh->name, MAX_MODULE_RESET_WAIT);
> +		pr_warning("omap_hwmod: %s: failed to reset in %d usec\n",
> +			   oh->name, MAX_MODULE_RESET_WAIT);

http://focus.ti.com/pdfs/wtbu/SWPU177B_FinalEPDF_12_04_2009.pdf

This is leading to the above warning for DSS on OMAP3430/3630. Referring to the reference manual (7.5.1 Display Subsystem Reset), successful reset of DSS would need PRCM.CM_FCLKEN_DSS[2] EN_TV bit set to 1. For DSS, even though TV clock is an optional clock, this is mandatory for successful DSS reset. We could ignore this warning, or possibly WA it.
One way could be:

1. In the database, have HWMOD_INIT_NO_RESET flag set so that _setup() skips reset.
 
2. After omap device build of DSS is done, lookup the opt-clock and enable it (using clock framework).

3. Then do DSS reset again calling omap_device_reset().

All IPs that potentially have any special soft-reset sequence will need customized handling. Should we keep the framework light and handle such special cases in the drivers? In that case, the framework need not throw up a warning. Please comment.

>  	else
>  		pr_debug("omap_hwmod: %s: reset in %d usec\n", oh->name, c);
> 
> @@ -1074,12 +1074,11 @@ static int _setup(struct omap_hwmod *oh, void
> *data)
>  	}
> 
>  	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
> +		_reset(oh);
>  		/*
> -		 * XXX Do the OCP_SYSCONFIG bits need to be
> -		 * reprogrammed after a reset?  If not, then this can
> -		 * be removed.  If they do, then probably the
> -		 * _omap_hwmod_enable() function should be split to avoid the
> -		 * rewrite of the OCP_SYSCONFIG register.
> +		 * OCP_SYSCONFIG bits need to be reprogrammed after a
> softreset.
> +		 * The _omap_hwmod_enable() function should be split to
> +		 * avoid the rewrite of the OCP_SYSCONFIG register.
>  		 */
>  		if (oh->class->sysc) {
>  			_update_sysc_cache(oh);
> --
> 1.6.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
