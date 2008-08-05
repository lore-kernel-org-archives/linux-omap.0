From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MUSB: Fix bug - don't mess up count number and CSR0
	register value
Date: Tue, 5 Aug 2008 12:02:12 +0300
Message-ID: <20080805090211.GG7193@atomide.com>
References: <1217907118963-git-send-email-cooloney@kernel.org> <20080805084549.GC7193@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB02569B8800@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65132 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758842AbYHEJCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:02:23 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8800@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Bryan Wu <cooloney@kernel.org>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [080805 11:59]:
> > Hi,
> >
> > * Bryan Wu <cooloney@kernel.org> [080805 06:27]:
> > > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > > ---
> > >  drivers/usb/musb/musb_gadget_ep0.c |   24 ++++++++++++------------
> > >  1 files changed, 12 insertions(+), 12 deletions(-)
> >
> > I think all musb patches should be now posted to linux-usb list as the
> > patches are queued for integration.
> >
> > So I'll be using plain code coming from mainline tree and
> > won't apply any patches to musb code except temporary fixes if compile
> > breaks.
> >
> > Cheers,
> >
> > Tony
> 
> Do you mind if I post the patches here as well? It could be useful to
> someone using USB on OMAP? At least they could get a review here.

Yes, it's a good idea to Cc linux-omap list so people can test them
and keep track of the changes easier :)

> I've got one set of patches coming up over the next couple of days, and
> all of it is based on the current linux-omap tree.

OK

Tony
