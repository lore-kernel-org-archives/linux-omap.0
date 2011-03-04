From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Fri, 04 Mar 2011 13:51:03 -0800
Message-ID: <8762ryftbs.fsf@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
	<1298890670-5481-3-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58691 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760290Ab1CDVvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:51:07 -0500
Received: by mail-qy0-f172.google.com with SMTP id 29so510105qyk.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 13:51:07 -0800 (PST)
In-Reply-To: <1298890670-5481-3-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Mon, 28 Feb 2011 16:27:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> In omap3, save/restore context is implemented for GPIO
> banks 2-6 as GPIO bank1 is in wakeup domain. Instead
> of identifying bank's power domain by bank id, make use
> of powerdomain name itself.
>
> For this, omap_hwmod_get_pwrdm() is used. omap_device_get_pwrdm()
> could not be used as the pwrdm information needs to be filled
> in pdata. But omap_device_get_pwrdm() can be used only after
> omap_device_build() call.
>
> Signed-off-by: Charulatha V <charu@ti.com>
>
> Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> (2430-SDP testing)

I like the idea of this change, but not the implementation...

[...]

> @@ -1865,16 +1867,15 @@ static int workaround_enabled;
>  void omap2_gpio_prepare_for_idle(int off_mode)
>  {
>  	int i, c = 0;
> -	int min = 0;
>  
> -	if (cpu_is_omap34xx())
> -		min = 1;
> -
> -	for (i = min; i < gpio_bank_count; i++) {
> +	for (i = 0; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
>  		u32 l1 = 0, l2 = 0;
>  		int j;
>  
> +		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
> +			continue;
> +

This adds a string compare for every bank during every idle
transistion (and every resume.)  That's a lot of unneeded overhead.

I'd rather see a per-bank flag 'looses_context' or something that can be
checked more efficiently in this fast path.  This flag can be set based
on the powerdomain name in the device init code.

Kevin
