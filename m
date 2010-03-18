From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 1/5] omap3: pm: fix for twl4030 script load
Date: Thu, 18 Mar 2010 16:20:36 -0700
Message-ID: <87y6hpgqt7.fsf@deeprootsystems.com>
References: <1268407878-22535-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:40701 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0CRXUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 19:20:45 -0400
Received: by ywh2 with SMTP id 2so326403ywh.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 16:20:44 -0700 (PDT)
In-Reply-To: <1268407878-22535-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Fri\, 12 Mar 2010 21\:01\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Keeping the twl4030_config_sleep_sequence() call under the flag checking will fix
> the over writting of other sequences with the sleep sequences when loading the scripts.

Sorry, but I read this 4-5 times and still have no idea what it means,
or how it relates to this patch.

> Removed the warning print with checking order of scripts, since the order
> is not important. 

OK, this much I get, and see what the patch is doing.

> Only the values configured in the register, which is pointing to
> the starting address of each sequence should be correct.

aw, bummer. -ECONFUSED again

Please fix the changelog to not only summarize *what* is being changed,
but *why*.

Kevin

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
