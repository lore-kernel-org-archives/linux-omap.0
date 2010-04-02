From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] [PATCH v4 1/5] omap3: pm: fix for twl4030 script load
Date: Fri, 2 Apr 2010 12:22:41 +0200
Message-ID: <20100402102240.GE8010@sortiz.org>
References: <1270030828-2032-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:17764 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758053Ab0DBKWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 06:22:03 -0400
Content-Disposition: inline
In-Reply-To: <1270030828-2032-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Wed, Mar 31, 2010 at 03:50:28PM +0530, Lesly A M wrote:
> This patch will fix the TRITON sleep/wakeup sequence.
> 
> Since the function to populate the sleep script is getting called always
> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
> is getting over written by the sleep script.
> 
> Also removing the order checking while loading the scripts,
> since the order doesn't matter. Only the values configured
> in the register, which is pointing to the starting address
> of each sequence should be correct.
Tony, I think it would make sense for this patchset to go through the
linux-omap tree.
If you agree, please add my:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

to the patch below.

Cheers,
Samuel.


> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl4030-power.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 7efa878..bd98733 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -423,7 +423,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
>  	       u8 address)
>  {
>  	int err;
> -	static int order;
>  
>  	/* Make sure the script isn't going beyond last valid address (0x3f) */
>  	if ((address + tscript->size) > END_OF_SCRIPT) {
> @@ -444,7 +443,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
>  		err = twl4030_config_wakeup12_sequence(address);
>  		if (err)
>  			goto out;
> -		order = 1;
>  	}
>  	if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
>  		err = twl4030_config_wakeup3_sequence(address);
> @@ -452,10 +450,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
>  			goto out;
>  	}
>  	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> -		if (order)
> -			pr_warning("TWL4030: Bad order of scripts (sleep "\
> -					"script before wakeup) Leads to boot"\
> -					"failure on some boards\n");
>  		err = twl4030_config_sleep_sequence(address);
>  out:
>  	return err;
> -- 
> 1.6.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
