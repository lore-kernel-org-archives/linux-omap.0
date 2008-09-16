From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP support in mainline?
Date: Tue, 16 Sep 2008 16:25:06 -0700
Message-ID: <20080916232505.GC25885@atomide.com>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62398 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYIPXZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 19:25:13 -0400
Content-Disposition: inline
In-Reply-To: <20080916184110.GA10733@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080916 11:42]:
> On Tue, Sep 16, 2008 at 09:13:21AM -0600, Paul Walmsley wrote:
> > On Tue, 16 Sep 2008, Kalle Valo wrote:
> > 
> > > Hello Linux OMAP community,
> > > 
> > > I have seen a lot of patches going to Russell and general talk about
> > > mainline support. What is actually the current situation? Is there
> > > hope to have good support in mainline soon? If yes, when?
> > > 
> > > Unsurprisingly I'm especially interested about N800/N810 support :)
> > 
> > Parts of N800/N810 are still broken in linux-omap tree.  At least sound 
> > did not work as of early September, and MMC still emits errors as 
> > described in:
> > 
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02499.html
> > 
> > Don't recall what the current LM8323 status is.
> 
> Bluetooth is also missing on mainline, but the driver needs some rework.

Hopefully we'll get all core 24xx and 34xx files integrated soon. But
then there are tons of board-*.c files missing from mainline that
probably need to be cleaned up a bit. 

Tony
