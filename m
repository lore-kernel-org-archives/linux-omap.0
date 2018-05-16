From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] wlcore: Make sure PM calls are paired
Date: Wed, 16 May 2018 09:17:52 -0700
Message-ID: <20180516161751.GH98604@atomide.com>
References: <20180515161315.1997-1-tony@atomide.com>
 <20180515161315.1997-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180515161315.1997-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180515 16:15]:
> The call to wl1271_ps_elp_wakeup() in wl12xx_queue_recovery_work() is
> unpaired. Let's remove it and add paired calls to wl1271_recovery_work()
> instead in preparation for changing things to use runtime PM.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/net/wireless/ti/wlcore/main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -796,7 +796,6 @@ void wl12xx_queue_recovery_work(struct wl1271 *wl)
>  
>  		wl->state = WLCORE_STATE_RESTARTING;
>  		set_bit(WL1271_FLAG_RECOVERY_IN_PROGRESS, &wl->flags);
> -		wl1271_ps_elp_wakeup(wl);
>  		wlcore_disable_interrupts_nosync(wl);
>  		ieee80211_queue_work(wl->hw, &wl->recovery_work);
>  	}

OK found it, we need to move wlcore_disable_interrupts_nosync(wl) to
wl1271_recovery_work() below also as otherwise wl1271_ps_elp_wakeup()
times out.

Regards,

Tony
