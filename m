From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v3 1/5] omap3: pm: fix for twl4030 script load
Date: Fri, 19 Mar 2010 11:00:01 +0530
Message-ID: <009b01cac725$3a475070$518918ac@apr.dhcp.ti.com>
References: <1268407878-22535-1-git-send-email-leslyam@ti.com> <87y6hpgqt7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab0CSFaL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 01:30:11 -0400
In-Reply-To: <87y6hpgqt7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi Kevin,

Comments inline

Thanks & Regards,
Lesly A M

-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: Friday, March 19, 2010 4:51 AM
To: Lesly A M
Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
Samuel Ortiz
Subject: Re: [PATCH v3 1/5] omap3: pm: fix for twl4030 script load

Lesly A M <leslyam@ti.com> writes:

> Keeping the twl4030_config_sleep_sequence() call under the flag checking
will fix
> the over writting of other sequences with the sleep sequences when loading
the scripts.

Sorry, but I read this 4-5 times and still have no idea what it means,
or how it relates to this patch.

[Lesly] All other sequence are getting over written by sleep seq.
Because twl4030_config_sleep_sequence() function is getting called always
when we enter load_twl4030_script().
And it will also over write the starting address of all seq with 0x2F.

> Removed the warning print with checking order of scripts, since the order
> is not important. 

OK, this much I get, and see what the patch is doing.

> Only the values configured in the register, which is pointing to
> the starting address of each sequence should be correct.

aw, bummer. -ECONFUSED again

Please fix the changelog to not only summarize *what* is being changed,
but *why*.

[Lesly] Why the order is not important.
Since each seq is independent and not falling trough any other seq.
Only thing we have to do is program the start address of each seq correctly.

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
> @@ -423,7 +423,6 @@ static int __init load_twl4030_script(struct
twl4030_script *tscript,
>  	       u8 address)
>  {
>  	int err;
> -	static int order;
>  
>  	/* Make sure the script isn't going beyond last valid address (0x3f)
*/
>  	if ((address + tscript->size) > END_OF_SCRIPT) {
> @@ -444,7 +443,6 @@ static int __init load_twl4030_script(struct
twl4030_script *tscript,
>  		err = twl4030_config_wakeup12_sequence(address);
>  		if (err)
>  			goto out;
> -		order = 1;
>  	}
>  	if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
>  		err = twl4030_config_wakeup3_sequence(address);
> @@ -452,10 +450,6 @@ static int __init load_twl4030_script(struct
twl4030_script *tscript,
>  			goto out;
>  	}
>  	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> -		if (order)
> -			pr_warning("TWL4030: Bad order of scripts (sleep "\
> -					"script before wakeup) Leads to
boot"\
> -					"failure on some boards\n");


Since calling this is not executed under the flag TWL4030_SLEEP_SCRIPT, will
be executed always.
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

