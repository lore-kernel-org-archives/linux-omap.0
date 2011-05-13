From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v10 1/7] MFD: TWL4030: Fix for the TWL4030 sleep/wakeup sequence
Date: Fri, 13 May 2011 14:40:58 +0200
Message-ID: <87mxiqg4dh.fsf@ti.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-2-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:60438 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758916Ab1EMMlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 08:41:03 -0400
Received: by mail-fx0-f54.google.com with SMTP id 11so3611821fxm.27
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 05:41:01 -0700 (PDT)
In-Reply-To: <1304687833-4578-2-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Fri, 6 May 2011 18:47:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.
>
> Adding the missing brackets for fixing the issue.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Acked-by: Kevin Hilman <khilman@ti.com>


> ---
>  drivers/mfd/twl4030-power.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 6fed964..97f54ce 100644
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
