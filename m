From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH v5 1/5] omap3: pm: fix for twl4030 script load
Date: Tue, 4 May 2010 09:27:02 +0300
Message-ID: <20100504062701.GA8686@besouro.research.nokia.com>
References: <1271677380-2095-1-git-send-email-leslyam@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36435 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0EDGZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 02:25:34 -0400
Content-Disposition: inline
In-Reply-To: <1271677380-2095-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Lesly A M <leslyam@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hello Lesly,

On Mon, Apr 19, 2010 at 01:43:00PM +0200, ext Lesly A M wrote:
> This patch will fix the TRITON sleep/wakeup sequence.

OK.

> 
> Since the function to populate the sleep script is getting called always
> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
> is getting over written by the sleep script.

Yes, and that is because of missing curls {}.

> 
> Also removing the order checking while loading the scripts,
> since the order doesn't matter. Only the values configured
> in the register, which is pointing to the starting address
> of each sequence should be correct.

Are sure about that. Please check commig 75a7456539224c5c5c254130afdb18bd7eb2286f
At least from that description, Amit was very convincing that loading
order matters.

Author: Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon Aug 17 17:01:56 2009 +0300

    mfd: Print warning for twl4030 out-of-order script loading
    
    When the sleep script is loaded before the wakeup script, there is a
    chance that the system might go to sleep before the wakeup script
    loading is completed. This will lead to a system that does not wakeup
    and has been observed to cause non-booting boards.


> 
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


If the problem you are trying to address is the fact that everything goes to
sleep address, then just embrace the conditional into brackets.

>  out:
>  	return err;
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
