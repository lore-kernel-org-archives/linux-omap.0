From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 00/26] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Fri, 4 Mar 2016 18:33:35 -0800
Message-ID: <20160305023335.GP55664@google.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <56D470E8.4070106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D470E8.4070106-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 29, 2016 at 06:25:12PM +0200, Roger Quadros wrote:
> On 19/02/16 23:15, Roger Quadros wrote:
> > Hi,
> > 
> > @Tony
> > Patches 15 and 24 are new and will need your review.
> > I've modified patch 22 to include the new am335x boards introduced since v4.4.
> > 
> > Patches are based on top of omap-for-v4.6/dt so that the DT changes apply cleanly.
> > 
> > @Brian
> > If you can Ack the MTD related changes we can push the series (excluding DT patches)
> > to an immutable branch and you can then pull it into l2-mtd.git
> 
> Gentle ping on this. Thanks.

I think this series looks a lot better. I don't think I have any
fundamental issues with the MTD stuff, aside from the one comment
about the 'reg' property. If we get a satisfactory answer for that (and
you fix the small stuff), then:

Acked-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

(That's also presuming the relevant players are all on board with the DT
"ABI" breakage. But I think your old binding really needed a fixup, so
the warning might be sufficient.)

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
