From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [5/8] wclore: Fix timout errors after recovery
Date: Wed, 27 Jun 2018 15:41:52 +0000 (UTC)
Message-ID: <20180627154152.7434960791@smtp.codeaurora.org>
References: <20180619094342.81831-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180619094342.81831-6-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> After enabling runtime PM, if we force hardware reset multiple times with:
> 
> # echo 1 > /sys/kernel/debug/ieee80211/phy0/wlcore/start_recovery
> 
> We will after few tries get the following error:
> 
> wlcore: ERROR timeout waiting for the hardware to complete initialization
> 
> And then wlcore is unable to reconnect until after the wlcore related modules
> are reloaded.
> 
> Let's fix this by moving pm_runtime_put() earlier before we restart the hardware.
> And let's use the sync version to make sure we're done before we restart.
> 
> Note that we still will get -EBUSY warning from wl12xx_sdio_set_power() but let's
> fix that separately once we know exactly why we get the warning.
> 
> Reported-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I'll do s/wclore/wlcore/ to the title.

-- 
https://patchwork.kernel.org/patch/10473897/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
