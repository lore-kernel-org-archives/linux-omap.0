From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 13:53:32 +0200
Message-ID: <20090220115332.GG16942@scadufax.research.nokia.com>
References: <6ed0b2680902200238o7b069a4fv8acb083b9771823e@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02F565677E@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28674 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZBTMMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 07:12:38 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F565677E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 11:44:25AM +0100, Anand Gadiyar wrote:
> On Friday Feb 20, 2009 Grazvydas Ignotas wrote:
> > On Fri, Feb 20, 2009 at 12:46 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> > > On Thu, Feb 19, 2009 at 02:43:36PM -0800, Steve Sakoman wrote:
> > >> EHCI omap driver definitely needs some work - there is machine
> > >> specific stuff in there that rightfully belongs in platform data.  I
> > >> haven't had time to work on it :-(
> > >
> > > For sure, and there's still workaround for clk framework stuff that
> > > should already move there.
> > >
> > > I'll try to start with some cleanups already during this weekend (yeah,
> > > I've got no life :-p) and post as RFT asap. After the cleanups are ok,
> > > then I'll start moving platform code out of there and for the clock
> > > workarounds I'll need help from Paul Walmsley, probably :-)
> >
> > Great, I'll be watching the list and gladly test them on pandora too.
> > It would be nice to have those remote wakeup issues [1] sorted out
> > too.
> >
> > 1: http://marc.info/?l=linux-omap&m=122911571519657&w=2
> 
> 
> Sorry, that is not something that will be fixed in ES3.1. It also affects
> suspend-resume, not just remote-wakeup.
> 
> However, there is a software workaround that is being tested right now
> - the one mentioned in the link does not work reliably. The new
> workaround should be ready shortly (maybe after Felipe is done with
> the cleanups he plans).

well, it's been about 5 months since you said TI would be doing such
cleanups, I've even had my patches dropped at that time because of that
and till now nothing happened. About the workaround, I'd rather read the
errata myself and implement it.

-- 
balbi
