From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Sat, 28 Nov 2015 13:27:07 +0100
Message-ID: <2565382.eR6yg1spIk@wuerfel>
References: <20150713131902.GH26485@atomide.com> <11537945.4HX4Y84tjV@wuerfel> <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.20.1511271817230.22569-fMhRO7WWcppj+hNMo8g0rg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 27 November 2015 18:28:50 Nicolas Pitre wrote:
> On Fri, 27 Nov 2015, Arnd Bergmann wrote:
> 
> > I don't mind creating the /proc/atags compatibility hack from the kernel
> > for a DT based N700 kernel, as long as we limit it as much as we can
> > to the machines that need it. Leaving a board file for the N700 in place
> > that contains the procfs code (and not much more) seems reasonable
> > here, as we are talking about a board specific hack and the whole point
> > appears to be running unmodified user space.
> > 
> > Regarding how to get the data into the kernel in the first place, my
> > preferred choice would still be to have an intermediate bootloader
> > such as pxa-impedance-matcher, but I won't complain if others are
> > happy enough about putting it into the ATAGS compat code we already
> > have, as long as it's limited to the boards we know need it.
> 
> Assuming you have a N700 board file for special procfs code, then why 
> not getting at the atags in memory where the bootloader has put them 
> directly from that same board file? This way it'll really be limited to 
> the board we know needs it and the special exception will be contained 
> to that one file.  Amongst the machine specific hooks, there is one that 
> gets invoked early during boot before those atags are overwritten.

I didn't realize this was possible, as we don't know the atags pointer
when we instead get a DTB pointer. However you are right: the board
file knows exactly that the atag_offset is 0x100, so we can grab it
from there, and that will make the implementation really easy and
contained to a single file that has access to the atags and that
can create the /proc/atags file for it.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
