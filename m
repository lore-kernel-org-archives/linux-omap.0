From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFT 6/6] wlcore: Use generic runtime pm calls for wowlan elp
 configuration
Date: Tue, 29 May 2018 14:23:05 -0500
Message-ID: <75fb865b-dc84-2e7d-d879-581e65dc343d@ti.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-7-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180529180605.73622-7-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 05/29/2018 01:06 PM, Tony Lindgren wrote:
> From: Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> With runtime PM enabled, we can now use generic calls to
> pm_generic_runtime_suspend and pm_generic_runtime_resume for enabling elp
> during suspend when wowlan is enabled and waking the chip from elp
> on resume.

Sry, but not sure you can :(

These functions are not used by drivers directly because system suspend
are not synchronized with PM runtime, so if you call pm_generic_runtime_suspend()
and, at the same time, there is pm_runtime_get_() in progress --> race ...

The pm_runtime_force_() APIs have to be used, or 
PM runtime drivers functions can be called directly, but only if it possible to be
sure no other PM runtime calls active which is usually true at suspend_noirq stage. 

> 
> Remove the custom API that was used to ensure that the command
> that is used to allow ELP during suspend is completed before the system
> suspend.
> 
> Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/net/wireless/ti/wlcore/main.c | 51 +++++++--------------------
>   1 file changed, 13 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
> @@ -998,24 +998,6 @@ static int wlcore_fw_wakeup(struct wl1271 *wl)
>   	return wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
>   }
>   
> -static int wlcore_fw_sleep(struct wl1271 *wl)

[...]

-- 
regards,
-grygorii
