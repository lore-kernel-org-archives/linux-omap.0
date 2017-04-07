From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Fri, 7 Apr 2017 06:52:53 -0700
Message-ID: <20170407135252.GG13234@atomide.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908>
 <20170404140341.GO10760@atomide.com>
 <20170405003637.GB13234@atomide.com>
 <dda7b6b0-b533-dfd6-1b12-b320bd69b623@ti.com>
 <20170405134655.GD13234@atomide.com>
 <20170405152954.GF13234@atomide.com>
 <20170406190722.GA12367@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170406190722.GA12367@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170406 12:09]:
> On Wed, Apr 05, 2017 at 08:29:55AM -0700, Tony Lindgren wrote:
> > If the the port is configured as OTG, we should not need to
> > try to force any states during init. The change below will stop
> 
> True, but the code has been there for a very long time, any idea what
> causes the regression?

I think it's just that with commit d8e5f0eca1e8 we now have phy enabled
earlier and calling musb_host_setup() with phy enabled sends it into
a loop of trying to force the host mode with nothing connected. This
loops seems to end after few seconds if there are devices connected,
but keeps going if there's nothing connected.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
