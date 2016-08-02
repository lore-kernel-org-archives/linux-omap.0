From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] musb: omap2430: do not assume balanced enable()/disable()
Date: Tue, 2 Aug 2016 03:33:34 -0700
Message-ID: <20160802103334.GC28140@atomide.com>
References: <1469814151-2571-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469814151-2571-1-git-send-email-andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160729 11:14]:
> The code assumes that omap2430_musb_enable() and
> omap2430_musb_disable() is called in a balanced way. The
> That fact is broken by the fact that musb_init_controller() calls
> musb_platform_disable() to switch from unknown state to off state.

OK, some spelling issues with the above paragraph though :)

> That means that phy_power_off() is called first so that
> phy->power_count gets -1 and the phy is not enabled on phy_power_on().
> In the probably common case of using the phy_twl4030, that
> prevents also charging the battery and so makes further
> kernel debugging hard.

Is this with v4.7 kernel? Also, care to describe how you hit this
and on which hardware? Just wondering..

> The patch prevents phy_power_off() from being called when
> it is already off.

OK

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
