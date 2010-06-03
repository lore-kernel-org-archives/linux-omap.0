From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 1/7] omap3: pm: fix for twl4030 script load
Date: Thu, 03 Jun 2010 10:17:24 -0700
Message-ID: <87bpbsyr17.fsf@deeprootsystems.com>
References: <1274185973-23839-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36757 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0FCRRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 13:17:31 -0400
Received: by pvg16 with SMTP id 16so161891pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 10:17:30 -0700 (PDT)
In-Reply-To: <1274185973-23839-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Tue\, 18 May 2010 18\:02\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> This patch will fix the TRITON sleep/wakeup sequence.
>
> Since the function to populate the sleep script is getting called always
> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
> is getting over written by the sleep script.

OK, this is a clear bug fix and should be a patch on its own.

> Print warning if the sleep script is loaded before wakeup script.
> Because there is a chance that the Power chip may go to sleep before
> the wakeup script is completely loaded, which can cause a system hang.

OK, but your patch doesn't add this warning.  It's already  there.

Kevin

> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl4030-power.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 7efa878..b4fc190 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -451,12 +451,13 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
>  		if (err)
>  			goto out;
>  	}
> -	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> -		if (order)
> +	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
> +		if (!order)
>  			pr_warning("TWL4030: Bad order of scripts (sleep "\
>  					"script before wakeup) Leads to boot"\
>  					"failure on some boards\n");
>  		err = twl4030_config_sleep_sequence(address);
> +	}
>  out:
>  	return err;
>  }
> -- 
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
