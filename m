From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 00/19] irqchip: crossbar: driver fixes
Date: Fri, 13 Jun 2014 15:22:06 -0700
Message-ID: <1402698126.2727.13.camel@joe-AO725>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
	 <20140613150122.GP8664@titan.lakedaemon.net>
	 <1402676074.12385.40.camel@joe-AO725>
	 <20140613163714.GR8664@titan.lakedaemon.net>
	 <1402678104.3509.1.camel@joe-AO725>
	 <20140613165458.GS8664@titan.lakedaemon.net>
	 <alpine.DEB.2.10.1406132222570.5170@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1406132222570.5170@nanos>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2014-06-13 at 22:38 +0200, Thomas Gleixner wrote:
> On Fri, 13 Jun 2014, Jason Cooper wrote:
> > On Fri, Jun 13, 2014 at 09:48:24AM -0700, Joe Perches wrote:
> > > On Fri, 2014-06-13 at 12:37 -0400, Jason Cooper wrote:
> > > > On Fri, Jun 13, 2014 at 09:14:34AM -0700, Joe Perches wrote:
> > > > > On Fri, 2014-06-13 at 11:01 -0400, Jason Cooper wrote:
> > > > > > Please format the subject lines like so:
> > > > > > 
> > > > > >   irqchip: crossbar: Set cb pointer ...
> > > > > >                      ^
> > > > > >                      |
> > > > > >                      \-- note the capitalization
> > > > > 
> > > > > I suggest you don't make this a rule and focus
> > > > > on more important stuff instead.

[elided the bit that describes what a patch subject looks like]

Documentation/SubmittingPatches simply says:

The canonical patch subject line is:

    Subject: [PATCH 001/123] subsystem: summary phrase

It doesn't say anything about capitalization.

> Sentences start with an upper case letter. Our brain is trained on
> that rule when parsing a line.

<shrug>  I don't think patch subjects are sentences.
The docs call them phrases.

> So for people who actually review patches by reading them instead of
> running a spell checker, consistent formatting more important than
> avoiding the random typo, which our brain just blends out in most of
> the cases. Unfortunately also when the typo is in actual code :(

That part about the code is truth.

Anyway, how you spend your time is certainly up to you.
Do what makes you happy.

But if you want this specific form for your patches,
please just document it somewhere in the kernel tree.

I think that relatively commit log subjects are generally
easy to parse as-is and don't need more strictures.

I think it akin to british/american spelling uses and
I and i.  I just don't care which people use.

I did propose a mechanism to nudge people when proposed
patch subjects don't fit some specific maintainer's idea
of proper.

https://lkml.org/lkml/2010/11/16/245

cheers, Joe




--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
