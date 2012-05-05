From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] twl4030: Various fixes for charing-from-USB
Date: Sat, 5 May 2012 03:52:49 -0700
Message-ID: <20120505105249.GA20875@lizard>
References: <20120425072931.20124.56635.stgit@notabene.brown>
 <CANOLnOOQDxu-P=yTN6159XJANq-_FSCtZ4rBt69NSCPjLz1Rjw@mail.gmail.com>
 <20120430093002.472dfdde@notabene.brown>
 <20120505104910.GA19590@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120505104910.GA19590@lizard>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, May 05, 2012 at 03:49:10AM -0700, Anton Vorontsov wrote:
> On Mon, Apr 30, 2012 at 09:30:02AM +1000, NeilBrown wrote:
> > > > Following are a collection of patches that I've need using for a while
> > > > to make sure the charge-from-usb on my GTA04 works.
> > > > Hopefully I've included the right people in the recipient list :-)
> > > 
> > > You missed the power supply maintainers - ./scripts/get_maintainer.pl
> > > is usually good at finding the right people, although their
> > > MAINTAINERS entry could be better I guess..
> > > 
> > > 
> > 
> > I guess you mean:
> > 
> > POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
> > M:	Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>
> > M:	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> > T:	git git://git.infradead.org/battery-2.6.git
> > S:	Maintained
> > F:	include/linux/power_supply.h
> > F:	drivers/power/power_supply*
> > 
> > 
> > get_maintainer.pl didn't find them.  The F: line seems to say they aren't
> > interested in individual drivers...
> 
> This is a 'bug', of course. :-) Thanks for the report.
> 
> This is what I've just applied:
> 
> - - - -
> MAINTAINERS: Fix 'F' entry for the power supply class
> 
> For some reason the maintainers file only specifies power
> supply core files.
> 
> We're surely interested in individual drivers as well, so fix
> the entry.
> 
> Reported-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

Oh, Grazvydas Ignotas noticed this too. I added
Reported-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> as well.
Just to be precise. ;-)

Thanks folks,

-- 
Anton Vorontsov
Email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
