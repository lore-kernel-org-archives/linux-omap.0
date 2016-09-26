From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/5] wlcore: Prepare family to fix nvs file handling
Date: Mon, 26 Sep 2016 18:47:06 +0300
Message-ID: <878tuezmrp.fsf@kamboji.qca.qualcomm.com>
References: <20160917160633.8767-1-tony@atomide.com>
        <20160917160633.8767-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160917160633.8767-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message
        of "Sat, 17 Sep 2016 09:06:29 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> Move struct wilink_family_data to be available for all TI WLAN
> variants. And fix familiy typo, it should be just family.
>
> Looks like wl12xx use two different nvs.bin files and wl18xx
> uses a different conf.bin file.
>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied to wireless-drivers-next.git, thanks.

-- 
Kalle Valo
