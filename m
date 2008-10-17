From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] ehci-omap: (mostly) cosmetic cleanups
Date: Fri, 17 Oct 2008 14:27:38 -0700
Message-ID: <20081017212738.GV15820@atomide.com>
References: <200810030003.34109.david-b@pacbell.net> <20081003080154.GE10743@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64105 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbYJQV1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:27:43 -0400
Content-Disposition: inline
In-Reply-To: <20081003080154.GE10743@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [081003 01:02]:
> On Fri, Oct 03, 2008 at 12:03:33AM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Various cleanups to the OMAP EHCI bus glue:
> > 
> >  - Whitespace fixes.
> > 
> >  - Busy-wait loops should really have timeouts, but lacking
> >    that ... at least cpu_relax() in the body.
> > 
> >  - Debug messages should end with newlines, so they don't
> >    break the next message; should not embed newlines; and
> >    should otherwise be clean and correctly spelled.
> > 
> >  - The probe() method should have initialized the SBRN value,
> >    so the driver didn't report "USB 0.0 started".
> > 
> >  - The MODULE_ALIAS() was missing its "platform:" prefix;
> >    doing it right means the module could hotplug/coldplug.
> > 
> > No real functional change except for the hotplug/coldplug thing.
> 
> I actually sent this patch (besides SBRN init) way back in time but
> Vikram and Anand (??) asked to hold on that patch since some patches
> would come from TI for ehci and ohci.
> 
> Never saw those patches till now.

Pushing this today anyways, seems like some good fixes.

Tony
