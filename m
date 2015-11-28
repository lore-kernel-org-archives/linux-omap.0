From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sat, 28 Nov 2015 12:54:55 +0000
Message-ID: <20151128125455.GD30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
 <2565382.eR6yg1spIk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2565382.eR6yg1spIk@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 28, 2015 at 01:27:07PM +0100, Arnd Bergmann wrote:
> On Friday 27 November 2015 18:28:50 Nicolas Pitre wrote:
> > On Fri, 27 Nov 2015, Arnd Bergmann wrote:
> > 
> > > I don't mind creating the /proc/atags compatibility hack from the kernel
> > > for a DT based N700 kernel, as long as we limit it as much as we can
> > > to the machines that need it. Leaving a board file for the N700 in place
> > > that contains the procfs code (and not much more) seems reasonable
> > > here, as we are talking about a board specific hack and the whole point
> > > appears to be running unmodified user space.
> > > 
> > > Regarding how to get the data into the kernel in the first place, my
> > > preferred choice would still be to have an intermediate bootloader
> > > such as pxa-impedance-matcher, but I won't complain if others are
> > > happy enough about putting it into the ATAGS compat code we already
> > > have, as long as it's limited to the boards we know need it.
> > 
> > Assuming you have a N700 board file for special procfs code, then why 
> > not getting at the atags in memory where the bootloader has put them 
> > directly from that same board file? This way it'll really be limited to 
> > the board we know needs it and the special exception will be contained 
> > to that one file.  Amongst the machine specific hooks, there is one that 
> > gets invoked early during boot before those atags are overwritten.
> 
> I didn't realize this was possible, as we don't know the atags pointer
> when we instead get a DTB pointer. However you are right: the board
> file knows exactly that the atag_offset is 0x100, so we can grab it
> from there, and that will make the implementation really easy and
> contained to a single file that has access to the atags and that
> can create the /proc/atags file for it.

I've made several suggestions over the year or so that this problem has
been around, and solving this problem appears to be getting nowhere...
(because we _still_ have the problem today.)  When the same suggestions
start to be made by other people, I think there's not much more that can
be done to help resolve the situation.  It's probably time to walk away
from the problem, and let those who are supposedly motivated to use
these troublesome platforms just get on with it.

I'm not sure what Tony does at this point: if he rips out the non-DT
OMAP code, it'll cause a regression, but at the same time, it provides
additional motivation to get the problem resolved.  I can quite well
see Pavel going off and whinging at Linus, Linus getting stressed at
us for intentionally breaking something that used to work, and telling
everyone that they shouldn't be working on the kernel, in his usual
friendly way.

So, I think if the non-DT OMAP stuff is getting in the way of further
OMAP development, then the only solution is to put pressure on those
who are holding it up: in other words, put pressure on those to get
this damned problem solved.

The only thing I can think of doing is to give the N900 people notice
that they're causing a problem here, explaining exactly why - maybe
explaining that it's been causing a problem however long it has and
that the only option is going to be to fork mainline and effectively
leave the code in mainline unmaintained because of this.

Then, of course, those who have caused this situation then get the fun
job of maintaining _all_ the OMAP code in mainline on their own, which
I think would bury them under such a huge mountain that the code would
end up being terminally broken, and ripe for deletion. At which point,
it'd make sense to merge the maintained fork back into mainline, which
of course wouldn't have the troublesome code platforms by that time. :)

Yes, it's not particularly nice, but I don't see this problem getting
resolved.

(Maybe this email will be enough to motivate the N900 users to sort this
out, but I suspect they'll prefer to spend time whinging and moaning at
me in email rather than doing what needs to be done and fixing the
problem.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
