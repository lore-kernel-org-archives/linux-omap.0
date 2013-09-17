From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: provide arch-timer frequenecy parameter
Date: Tue, 17 Sep 2013 12:55:57 -0400
Message-ID: <5238899D.60903@ti.com>
References: <1379436433-24914-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379436433-24914-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, R Sricharan <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 September 2013 12:47 PM, Nishanth Menon wrote:
> CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
> same. Without a valid value arch_timer_init results in div0 crash.
s/same/timer frequency via DT
> Providing the same is a safer alternative.
Above statement won't be necessary. 

> Cc: R Sricharan <r.sricharan-l0cyMroinI0@public.gmane.org>
> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> 
Apart from minor change log fix,

Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
