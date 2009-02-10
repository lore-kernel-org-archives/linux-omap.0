From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 10:46:34 +0200
Message-ID: <20090210104634.40706b4f.jarkko.nikula@nokia.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
	<5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403FA81B610@dbde02.ent.ti.com>
	<20090210073525.GE3166@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55635 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZBJIqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 03:46:31 -0500
In-Reply-To: <20090210073525.GE3166@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, 10 Feb 2009 08:35:31 +0100
"Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com> wrote:

> > > Could you give me a little more detail on what you had to do for
> > > session start?  Perhaps I have a similar issue on Overo.
> > It is same $ echo "F" >/proc/driver/musb_hdrc, which was earlier
> > In musb_procfs.c and now been removed.
> >
> > +       case 'F':
> > +               reg = musb_readb(mbase, MUSB_DEVCTL);
> > +               reg |= MUSB_DEVCTL_SESSION;
> > +               musb_writeb(mbase, MUSB_DEVCTL, reg);
> 
> a temp sysfs for that will help:
> 
> Steve, could you try the following
> 
I let Felipe to send new version of the patch where it applies (I had
there spaces instead of tabs?) and condition for session value is not
true for all values ;-)

But for me Beagle work. Ethernet gadget just fine and HS HUB by kicking
the session on.


Jarkko
