From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 03:43:25 -0700
Message-ID: <20140619104324.GC29055@atomide.com>
References: <20140619095655.GA29055@atomide.com>
 <53A2B6B0.2040804@zonque.org>
 <20140619103100.GB29055@atomide.com>
 <53A2BD34.1060409@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53A2BD34.1060409-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> [140619 03:38]:
> Hi Tony,
> 
> On 06/19/2014 12:31 PM, Tony Lindgren wrote:
> > * Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> [140619 03:10]:
> >> On 06/19/2014 11:56 AM, Tony Lindgren wrote:
> >>> Looks like commit ca88fc2ef0d7 (usb: musb: add a work_struct
> >>> to recover from babble errors) causes MUSB gadgets to stop
> >>> enumerating at least on omap3. Reverting the the commit fixes
> >>> the issue.
> >>
> >> Hmm, so do you see babble errors occuring?
> > 
> > Not that I noticed of.
> >  
> >> Also, there are some more patches for musb and babble error recovery on
> >> the usb list, namely the ones starting here in v6:
> >>
> >>   http://marc.info/?l=linux-usb&m=140109627505065&w=4
> >>
> >> Care to give them a try?
> > 
> > I can confirm that "[PATCH v6 1/5] usb: musb: core: Handle Babble
> > condition only in HOST mode" fixes the issue for me. Also the
> > explanation in the patch description explains why it breaks, and
> > probably for all gadgets too because "BABBLE and RESET share the
> > same interrupt" so it's RESET in peripheral mode.
> 
> Ok, thanks for testing. I was told Felipe was out for some weeks, so I
> don't know when these patches will be reviewed and merged.

He seems to be back now :)
 
> > But that also raises a question: Were these patches merged for
> > v3.16 ever even tested in peripheral mode?
> 
> At the time, I had no such hardware to test this on, so I was hoping for
> more testers to give them a try in different environments, which
> apparently didn't happen. It fixed a dead USB port condition on
> host-mode enabled hardware, though.

Well we probably should not merge patches without proper acks and
tested-by:s in general as things just seem to keep breaking
constantly otherwise. And things not working will keep people from
using linux next which will lead into even less testing..

Anyways, this driver is the only way to get a console on many
devices, so we should ensure it always works properly.

> We should make sure at least patch 1/5 from the series mentioned above
> makes it to 3.16.

Agreed.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
