From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 04/10] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Thu, 19 May 2011 18:39:28 +0200
Message-ID: <8739ka7igv.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40070 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756856Ab1ESQpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 12:45:19 -0400
Received: by mail-wy0-f177.google.com with SMTP id 28so3174800wyb.22
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:45:18 -0700 (PDT)
In-Reply-To: <1305546104-1511-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> gpio_bank_count is the count of number of GPIO devices
> in a SoC. Remove this dependency from the driver. Also remove
> the dependency on array of pointers to gpio_bank struct of
> all GPIO devices.
>
> The cpu_is*() checks used in omap2_gpio_prepare_for_idle() and
> omap2_gpio_resume_after_idle() would be removed in one of the
> patches in this series
>
> Signed-off-by: Charulatha V <charu@ti.com>

This is all in the right direction, but some comments about the
save/restore context...

[...]

> @@ -1497,11 +1494,16 @@ void omap2_gpio_resume_after_idle(void)
>  /* save the registers of bank 2-6 */
>  void omap_gpio_save_context(void)
>  {
> -	int i;
> +	struct gpio_bank *bank;
> +	int i = 0;
>  
>  	/* saving banks from 2-6 only since GPIO1 is in WKUP */
> -	for (i = 1; i < gpio_bank_count; i++) {
> -		struct gpio_bank *bank = &gpio_bank[i];
> +	list_for_each_entry(bank, &omap_gpio_list, node) {
> +		i++;
> +
> +		if (bank->id == 0)
> +			continue;
> +

Rather than add a list iterator here, I'd rather see the save_context
called from the prepare_for_idle, only for the specific banks needed
(and then gpio_save_context can be removed from pm34xx.c.)

Similar for restore.

If you prefer, you can do that in an additional patch on top of this
one.

Kevin
