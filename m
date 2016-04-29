From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/7] ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
Date: Fri, 29 Apr 2016 08:34:30 -0700
Message-ID: <20160429153430.GK5995@atomide.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <1461927202-17677-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461927202-17677-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160429 03:55]:
> The McBSPLP's sidetone main clock is the McBSPLP's ICLK, not FCLK as the
> sidetone only receives the ICLK from the main McBSP module.
> Since the McBSP and sidetone is using the very same clock from PRCM level
> the sidetone must not have the prcm section to check the clock status since
> the sidetone is only used when McBSP is already configured.
> If two separate hwmods looking at the same bit and they would use
> pm_runtime in nested way (as it must happen with McBSP and it's ST module)
> the hwmod would warn, because the idlest will not match what it is expected
> after enable/disable of the clocks.

Thanks for looking into it, this looks right to me.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
