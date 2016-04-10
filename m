From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: DRA7: hwmod: Add data for GPTimer 12
Date: Sun, 10 Apr 2016 17:57:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604101757100.11457@utopia.booyaka.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com> <1459892652-47845-4-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459892652-47845-4-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 5 Apr 2016, Suman Anna wrote:

> Add the hwmod data for GPTimer 12. GPTimer 12 is present in
> WKUPAON power domain and is clocked from a secure 32K clock.
> GPTimer 12 serves as a secure timer on HS devices, but is
> available for kernel on regular GP devices.
> 
> The hwmod link is registered only on GP devices. The hwmod data
> also reused the existing timer class instead of reintroducing
> the identical dra7xx_timer_secure_sysc class which was dropped
> in commit edec17863362 ("ARM: DRA7: hwmod: Fix the hwmod class
> for GPTimer4").
> 
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Thanks, queued for v4.7.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
