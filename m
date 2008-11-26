From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up v2.
Date: Wed, 26 Nov 2008 14:40:11 -0800
Message-ID: <20081126224011.GI11997@atomide.com>
References: <873ahotc5t.fsf@trdhcp146196.ntc.nokia.com> <1227080924-11555-1-git-send-email-jouni.hogander@nokia.com> <20081126175709.GS11997@atomide.com> <200811261041.02375.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52800 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYKZWkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 17:40:13 -0500
Content-Disposition: inline
In-Reply-To: <200811261041.02375.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081126 10:41]:
> On Wednesday 26 November 2008, Tony Lindgren wrote:
> > * Jouni Hogander <jouni.hogander@nokia.com> [081118 23:48]:
> > > Currently mcspi wake-ups are not enabled. This might cause case where
> > > OMAP is not waking up on mcspi events.
> > 
> > Dave, I assume you're picking these for your SPI queue? Will only
> > apply to l-o if you ack and tell me so.
> 
> OK... I'm not totally caught up there.  Is this needed for
> a 2.6.28-final merge?  I'm guessing not; so it'd be OK to
> queue for 2.6.29-final and have it in l-o until 29-rc1 gets
> pulled down.

Yes 2.6.29 timeline sounds fine to me at least. I'll apply these to
l-o then.

Tony
