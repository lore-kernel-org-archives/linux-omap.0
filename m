From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [1/8] wlcore: Add missing PM call for
 wlcore_cmd_wait_for_event_or_timeout()
Date: Wed, 27 Jun 2018 15:46:56 +0000 (UTC)
Message-ID: <20180627154656.9E51960714@smtp.codeaurora.org>
References: <20180619094342.81831-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180619094342.81831-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Otherwise we can get:
> 
> WARNING: CPU: 0 PID: 55 at drivers/net/wireless/ti/wlcore/io.h:84
> 
> I've only seen this few times with the runtime PM patches enabled
> so this one is probably not needed before that. This seems to
> work currently based on the current PM implementation timer. Let's
> apply this separately though in case others are hitting this issue.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

8 patches applied to wireless-drivers-next.git, thanks.

4ec7cece87b3 wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
02edf81362fe wlcore: Make sure PM calls are paired
fa2648a34e73 wlcore: Add support for runtime PM
3ebbabea4219 wlcore: Fix misplaced PM call for scan_complete_work()
db68052bdf58 wlcore: Fix timout errors after recovery
45aa7f071b06 wlcore: Use generic runtime pm calls for wowlan elp configuration
c40aad28a3cf wlcore: Make sure firmware is initialized in wl1271_op_add_interface()
9b71578de087 wlcore: Enable runtime PM autosuspend support

-- 
https://patchwork.kernel.org/patch/10473893/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
