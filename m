From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: nl80211 wlcore regression in next
Date: Tue, 25 Jun 2019 12:18:39 +0300
Message-ID: <87r27irpjk.fsf@kamboji.qca.qualcomm.com>
References: <20190625073837.GG5447@atomide.com>
        <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
        <20190625080019.GH5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190625080019.GH5447-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message of
        "Tue, 25 Jun 2019 01:00:19 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> Hi,
>
> * Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org> [190625 07:47]:
>> On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
>> > Hi,
>> > 
>> > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
>> > working in Linux next with commit 901bb9891855 ("nl80211: require and
>> > validate vendor command policy"). Reverting the commit above makes it
>> > work again.
>> > 
>> > It fails with the warning below, any ideas what goes wrong?
>> 
>> Oops. For some reason, I neglected to check the vendor command usage
>> beyond hwsim.
>> 
>> The patch below should work?
>
> Yeah thanks that fixes the issue for me:
>
> Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Acked-by: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

-- 
Kalle Valo
