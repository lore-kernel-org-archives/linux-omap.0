From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 00/10] ARM: DTS/clk: DRA7 family: enable eDMA and
 audio updates
Date: Mon, 11 Apr 2016 13:06:26 -0700
Message-ID: <20160411200625.GD5995@atomide.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
 <570BA7A2.3080507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570BA7A2.3080507-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160411 06:34]:
> Tony,
> 
> according to Nishanth, linux-next is broken for dra7 family:
> http://pastebin.ubuntu.com/15758542/ on x15 next-20160411
> because of the missing DT patches.

OK yeah thanks for letting me know.

> Do you want me to resend this series w/o the hwmod patch?

No need to, applying your dts patches into omap-for-v4.7/dt
thanks.

The epwmss entries still produce warnings, looks like there's
discussion still going on with those.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
