From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 06:31:58 -0700
Message-ID: <20180522133158.GE98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com>
 <20180521224339.GD98604@atomide.com>
 <38ddca4c73bb4dbf835a84133035dbfb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <38ddca4c73bb4dbf835a84133035dbfb-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180522 13:28]:
> Actually the below patch removing the call to wlcore_fw_sleep() avoids this error.
> The downside is that the wl8 firmware remains fully active during supend, so we
> Would need to find the root cause why the last call allowing the wilink8 firmware 
> To go into ELP mode during suspend is only completing on resume and not during
> Suspend enter.
> 
> diff --git a/drivers/net/wireless/ti/wlcore/main.c
> b/drivers/net/wireless/ti/wlcore/main.c
> index 4c297aa..8df1ae6 100644
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -1789,7 +1789,6 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
>                 goto out_sleep;
> 
>  out_sleep:
> -       pm_runtime_put_noidle(wl->dev);
>         mutex_unlock(&wl->mutex);
> 
>         if (ret < 0) {
> @@ -1821,15 +1820,7 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
>          */
>         cancel_delayed_work(&wl->tx_watchdog_work);
> 
> -       /*
> -        * Use an immediate call for allowing the firmware to go into power
> -        * save during suspend.
> -        * Using a workque for this last write was only hapenning on resume
> -        * leaving the firmware with power save disabled during suspend,
> -        * while consuming full power during wowlan suspend.
> -        */
> -       wlcore_fw_sleep(wl);
> -
> +       pm_runtime_put_noidle(wl->dev);
>         return 0;
>  }

OK try replacing the pm_runtime_put_noidle() above with just
pm_runtime_put_sync(). The reason why I put noidle there was the
wlcore_fw_sleep() call, with that gone put_sync should do the trick.

Regards,

Tony
