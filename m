From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Thu, 26 Sep 2013 10:18:15 +0100
Message-ID: <20130926091815.GC2411@e106331-lin.cambridge.arm.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA15ED7@DBDE04.ent.ti.com>
 <20130925134619.GG10746@radagast>
 <20130925175527.GA23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA16884@DBDE04.ent.ti.com>
 <20130925200539.GH23337@ld-irv-0074.broadcom.com>
 <CAOesGMif301iBe9zxHudkC_G9SzPPy1Mj4XYvQ-MY8nmx4wO+A@mail.gmail.com>
 <20130925212903.GI23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130925212903.GI23337-bU/DPfM3abD4WzifrMjOTkcViWtcw2C0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 25, 2013 at 10:29:03PM +0100, Brian Norris wrote:
> On Wed, Sep 25, 2013 at 01:33:27PM -0700, Olof Johansson wrote:
> > On Wed, Sep 25, 2013 at 1:05 PM, Brian Norris
> > <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > > Olof has given good advice on your DT binding and has (slowly) been
> > > responding to other requests for DT review that make it to his list. I
> > > see that he hasn't followed up on your changes (this v6), so pinging him
> > > (as you did) is probably the correct approach. But please do recognize
> > > that the DT list is very high volume, so it's hard to get good timely
> > > responses there.
> > 
> > I am not a DT mainainer, but sometimes when I see a binding that
> > appears to be wrong I speak up. In this case, the binding was one of
> > those.
> 
> Whoops, my bad. I was deceived by the responses I've seen from you on
> other issues (thanks, BTW). In that case, I haven't seen any response
> from a proper DT binding maintainer :(

Hmm... this is the first email in this thread I've received, and I don't
have older postings either. It looks like I must have cocked up
subscribing to the devicetree list, but as I was CC'd directly on many
patches I hadn't noticed.

As far as I can see I wasn't CC'd directly on any version of this
series, which would have helped to highlight the series as needing
review.

Apologies for that. I've attempted to correct the problem. Hopefully
I've got this right and mails are not being silently dropped somewhere.

Pekon, could you please re-send this version of the patches?

Cheers,
Mark.

>  
> > So, I have no more objections to it, and I hope you can get a quick
> > review from a DT maintainer on the rest of the binding.
> 
> At this point, I'm comfortable going ahead without their ack, since they
> obviously don't care/don't have the manpower to review.
> 
> Brian
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
