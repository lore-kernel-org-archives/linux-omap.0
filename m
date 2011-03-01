From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/8] omap3: pm: Fix for the TRITON sleep/wakeup sequence
Date: Tue, 01 Mar 2011 14:33:39 -0800
Message-ID: <87pqqafp30.fsf@ti.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
	<1298723139-1693-2-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35253 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756526Ab1CAWdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:33:42 -0500
Received: by mail-iw0-f176.google.com with SMTP id 19so5597959iwr.21
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 14:33:41 -0800 (PST)
In-Reply-To: <1298723139-1693-2-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Sat, 26 Feb 2011 17:55:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Since the function to populate the sleep script is getting called always
> irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
> is getting over written by the sleep script. Adding the missing brackets for
> if statement to fix the issue.

This is still a confusing changelog.  How about simply:

Only write the sleep script when TWL4030_SLEEP_SCRIPT is set.

Kevin

> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl4030-power.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 16422de..2c0d4d1 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -447,12 +447,13 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
>  		if (err)
>  			goto out;
>  	}
> -	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> +	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
>  		if (order)
>  			pr_warning("TWL4030: Bad order of scripts (sleep "\
>  					"script before wakeup) Leads to boot"\
>  					"failure on some boards\n");
>  		err = twl4030_config_sleep_sequence(address);
> +	}
>  out:
>  	return err;
>  }
