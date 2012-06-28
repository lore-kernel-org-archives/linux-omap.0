From: "Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: Panda ES board hang when using GPIO as interrupt
Date: Thu, 28 Jun 2012 15:53:27 -0700
Message-ID: <4FECE067.7000809@broadcom.com>
References: <4FE8CF77.5080400@broadcom.com> <87txxxs9we.fsf@ti.com>
 <4FEBA854.5010508@broadcom.com> <4FEC7B48.8040402@ti.com>
 <4FECCB91.7090609@broadcom.com> <4FECD2E5.1060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FECD2E5.1060603-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tarun.kanti-l0cyMroinI0@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/28/2012 02:55 PM, Jon Hunter wrote:
> Ok. Any way to manually reset the wlan module to deactivate the gpio
> when it is hung? I am wondering if the gpio is deactivated if the board
> comes back to life, indicating it is stuck in the interrupt somewhere.

The only way I can think of is removing the module manually. But it 
didn't bring the board back to live.

> Well, at least that is consistent with what I see, but also perplexing
> that it takes sometime to fail. Can you try the following as a debug
> patch to see if it is in the context restore that is the problem. From
> your testing and bisect, the only possible difference in the current
> kernel is that it could perform the context restore when acquiring the gpio.
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c4ed172..a2401bd 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1341,6 +1341,8 @@ void omap2_gpio_resume_after_idle(void)
>   #if defined(CONFIG_PM_RUNTIME)
>   static void omap_gpio_restore_context(struct gpio_bank *bank)
>   {
> +       return;
> +
>          __raw_writel(bank->context.wake_en,
>                                  bank->base + bank->regs->wkup_en);
>          __raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
>

This one works! It can run more than 20 mins.

I found one interesting thing. When I added the print info to see when 
runtime_suspend/resume get called, it seems like the suspend/resume is 
unbalance during boot. Resume got called more than suspend. So I hack 
the code to make sure suspend and resume are called in pair. A resume 
without suspend will do nothing and return immediately. This also makes 
the hang vanish.

Regards,
Franky


--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
