From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv2] wlcore: sdio: Fix flakey SDIO runtime PM handling
Date: Tue, 29 May 2018 07:16:03 +0000 (UTC)
Message-ID: <20180529071603.4DFD260541@smtp.codeaurora.org>
References: <20180517182950.60807-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180517182950.60807-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> We can have pm_runtime_get_sync() return 1, and we can have
> pm_runtime_put_sync() return -EBUSY. See rpm_suspend() and
> rpm_resume() for more information.
> 
> Fix the issue by returning 0 from wl12xx_sdio_power_on() on success.
> And use pm_runtime_put() instead of pm_runtime_put_sync() for
> wl12xx_sdio_power_off(), then the MMC subsystem will idle the bus
> when suitable.
> 
> Otherwise wlcore can sometimes get confused and may report bogus
> errors and WLAN connection can fail.
> 
> Note that while wlcore checks the return value for wl1271_power_on(),
> the return value is ignored for wl1271_power_off(). Let's fix them
> both though to avoid further confusion in the future.
> 
> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

728a9dc61f13 wlcore: sdio: Fix flakey SDIO runtime PM handling

-- 
https://patchwork.kernel.org/patch/10407569/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
