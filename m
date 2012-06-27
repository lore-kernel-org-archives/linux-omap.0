From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: Panda ES board hang when using GPIO as interrupt
Date: Tue, 26 Jun 2012 22:37:05 -0500
Message-ID: <87txxxs9we.fsf@ti.com>
References: <4FE8CF77.5080400@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FE8CF77.5080400-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> (Franky Lin's message of "Mon, 25
	Jun 2012 13:52:07 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franky Lin <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: tarun.kanti-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-wireless@vger.kernel.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

"Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> writes:

> Hi Kevin, Tarun,
>
> We are using the expansion connector A on Panda board to mount a SDIO
> WiFi dongle on MMC2 with a level triggered interrupt signal connected
> to GPIO 138. It's been working fine until 3.5 rc1. The board hang
> randomly within 5 mins during a network traffic test. After bisecting
> we found the culprit is "[PATCH 8/8] gpio/omap: fix missing check in
> *_runtime_suspend()" [1].

<grumble>

As you might guess.  That patch has caused me enough headaches that
reverting it sounds like a good idea now.  But, I'd still like to better
understand exactly what's going on.

> I noticed Kevin raised some similar cases on other platforms and also
> provided two patches in the patch mail thread. But unfortunately those
> two patches doesn't help in our case. I tested the driver with 3.5-rc3
> mainline kernel and the issue is still there. I can only "fix" the
> hang by either reverting the commit or disabling
> CONFIG_PM_RUNTIME. Also, the hang only happens on Panda ES board. Old
> Panda with 4430 works good.
>
> Any thoughts and suggestions?

If reverting the patch fixes your problem, can you isolate down to which
part of that patch causes the problem?  IOW, can you fix your problem if
you undo just the hunk added in runtime_suspend or undo just the moved
hunk runtime_resume?  Or is reverting both required?

I suspect the added runtime_suspend hunk is causing the problems, so can
you see if just undoing that part works[1].  If that works, I will give
a bit more of a thinking on it tomorrow.

Thanks for reporting the problem!   Bug reports like this that have
clearly been thoroughly researched and bisected are greatly appreciated!

Kevin

[1] patch against v3.5-rc4

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c                
index c4ed172..2a6067f 100644                                                   
--- a/drivers/gpio/gpio-omap.c                                                  
+++ b/drivers/gpio/gpio-omap.c                                                  
@@ -1177,9 +1177,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
                __raw_writel(wake_hi | bank->context.risingdetect,              
                             bank->base + bank->regs->risingdetect);            
                                                                                
-       if (!bank->enabled_non_wakeup_gpios)                                    
-               goto update_gpio_context_count;                                 
-                                                                               
        if (bank->power_mode != OFF_MODE) {                                     
                bank->power_mode = 0;                                           
                goto update_gpio_context_count;                                 



--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
