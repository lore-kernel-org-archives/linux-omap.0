From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc3-omap git] hsmmc gpio updates
Date: Fri, 7 Nov 2008 11:52:04 -0800
Message-ID: <20081107195203.GI21736@atomide.com>
References: <200811062115.30519.david-b@pacbell.net> <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59368 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYKGTwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 14:52:08 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Steve Sakoman <sakoman@gmail.com> [081107 06:19]:
> On Thu, Nov 6, 2008 at 9:15 PM, David Brownell <david-b@pacbell.net> wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> >
> > Rework card detect GPIO handling in the twl4030 MMC glue:  drive
> > it *only* from the hsmmc_info passed; remove most of remaining
> > "we know we're always a twl4030 GPIO" logic.
> >
> > Add write-protect switch detection support to that glue.  Stub
> > in a not-present WP GPIO into most boards.  (Beagle's is real.)
> >
> > Teach the hsmmc driver how to use the card detect and writeprotect
> > methods, and move some data structure init earlier so that when IRQs
> > come in, more of the data used by their handlers is initialized.
> >
> > Verified on Beagle (WP, card detect events) and Overo (boots, both
> > card and wlan are seen).  Beagle behaves fully, and is the model
> > to follow for the common case where the TWL4030 gpio-0 card detect
> > magic is used.
> 
> Nice work!  Overo uses TWL4030 gpio-0 for card detect (just like
> Beagle) and GPIO-54 for WP.

Yeah, looks good! Pushing.

Tony
