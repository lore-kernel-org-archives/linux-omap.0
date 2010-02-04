From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] twl4030: keypad: Hooks for board specific suspend-resume
Date: Thu, 04 Feb 2010 13:48:49 -0800
Message-ID: <871vh03c5a.fsf@deeprootsystems.com>
References: <1265299609-30087-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:34956 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab0BDVsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 16:48:53 -0500
Received: by pxi12 with SMTP id 12so3366463pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Feb 2010 13:48:51 -0800 (PST)
In-Reply-To: <1265299609-30087-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Thu\,  4 Feb 2010 21\:36\:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch adds hooks to support board specific
> implementation during the suspend and resume operations.
>
> The TWL4030 can be connected to multiple boards. Without
> these hooks, board specific macros will be required in a
> generic driver.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Looks ok, but I think you should drop the 'on_' prefix in function
pointer names.

Kevin

> ---
>  drivers/input/keyboard/twl4030_keypad.c |   10 ++++++++++
>  include/linux/i2c/twl.h                 |   12 ++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index af0651d..9950d7e 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -442,11 +442,21 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM
>  static int twl4030_kp_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> +	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
> +
> +	if (pdata->on_suspend)
> +		pdata->on_suspend(pdata->pm_state);
> +
>  	return 0;
>  }
>  
>  static int twl4030_kp_resume(struct platform_device *pdev)
>  {
> +	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
> +
> +	if (pdata->on_resume)
> +		pdata->on_resume(pdata->pm_state);
> +
>  	return 0;
>  }
>  #else
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index bf1c5be..eefabf2 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -487,6 +487,18 @@ struct twl4030_keypad_data {
>  	unsigned rows;
>  	unsigned cols;
>  	bool rep;
> +#ifdef CONFIG_PM
> +	/*
> +	 * Board specific information required during suspend, resume.
> +	 * E.g. configuration as wake-up source.
> +	 */
> +	void *pm_state;
> +	/*
> +	 * Hooks for board specific execution during suspend, resume.
> +	 */
> +	void (*on_suspend)(void *pstate);
> +	void (*on_resume)(void *pstate);
> +#endif
>  };
>  
>  enum twl4030_usb_mode {
> -- 
> 1.6.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
