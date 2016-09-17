From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/5] Fix wlcore config firwmare annoyances
Date: Sat, 17 Sep 2016 18:24:49 +0300
Message-ID: <87k2ea7dmm.fsf@kamboji.qca.qualcomm.com>
References: <20160913215043.29454-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160913215043.29454-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's
        message of "Tue, 13 Sep 2016 14:50:38 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> Hi all,
>
> Here are some patches to fix the firmware loading for wl12xx/wl18xx
> when the same rootfs is used on multiple WLAN chip variants.
>
> Regards,
>
> Tony
>
> Tony Lindgren (5):
>   wlcore: Prepare family to fix nvs file handling
>   wlcore: sdio: Populate config firmware data
>   wlcore: sdio: Populate config firmware data
>   wlcore: Fix config firmware loading issues
>   wlcore: wl18xx: Use chip specific configuration firmware

I saw a new warning which I think is a valid one:

drivers/net/wireless/ti/wlcore/main.c: In function 'wlcore_probe':
drivers/net/wireless/ti/wlcore/main.c:6518:6: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]

-- 
Kalle Valo
