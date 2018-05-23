From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 0/5] Runtime PM support for wlcore
Date: Wed, 23 May 2018 10:02:52 -0700
Message-ID: <20180523170252.GN98604@atomide.com>
References: <a5eb26fc5db445f2a6473df1306da735@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a5eb26fc5db445f2a6473df1306da735-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180523 12:45]:
> > 
> > >
> > > Here's a modified version of your patch, does that put wlcore to
> > > idle with wowlan during suspend for you?
> > >
> > 
> > Still no joy.
> > It suspends/resumes ok but leaves the firmware disabled from entering ELP.
> 
> Spent some time on it today and looks like adding calls to pm_generic_runtime_suspend ()
> And pm_generic_runtime_resume is helping and all seems to work well.

Oh right yeah you got it, I totally forgot about those.

> See the modified version of your patch below.
> Let me know what you think.

Looks good to me, one comment below..

> -    wlcore_fw_sleep(wl);
> +    spin_lock_irqsave(&wl->wl_lock, flags);
> +    set_bit(WL1271_FLAG_SUSPENDED, &wl->flags);
> +    spin_unlock_irqrestore(&wl->wl_lock, flags);
> +
> +    pm_generic_runtime_suspend(wl->dev);
> 
>      return 0;

Maybe just return pm_generic_runtime_suspend(wl->dev)
here?

> @@ -1845,6 +1816,8 @@ static int wl1271_op_resume(struct ieee80211_hw *hw)
>               wl->wow_enabled);
>      WARN_ON(!wl->wow_enabled);
> 
> +    pm_generic_runtime_resume(wl->dev);
> +

And add error handling to pm_generic_runtime_resume(wl->dev)
here?

Then if you can please post your patch with proper Signed-off-by
I'll add it to my set and repost v3 of all the patches :)

Regards,

Tony
