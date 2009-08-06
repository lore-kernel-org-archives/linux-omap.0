From: Tony Lindgren <tony@atomide.com>
Subject: Re: N8x0 to mainline patches
Date: Thu, 6 Aug 2009 10:10:38 +0300
Message-ID: <20090806071038.GE7374@atomide.com>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com> <87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZHFHKq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 03:10:46 -0400
Content-Disposition: inline
In-Reply-To: <20090713065341.GC16778@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Kalle Valo <kalle.valo@iki.fi>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [090713 09:54]:
> Hi,
> 
> On Mon, Jul 13, 2009 at 08:51:45AM +0200, ext Kalle Valo wrote:
> > > I'd say at least patch #2 should be sent for to l-o right now since it
> > > gets rid of another OMAP_TAG.
> > 
> > I didn't implement omap1 part yet. As soon as I have done that, I'll
> > send it.
> 
> ok, good :-)
> 
> > I agree. But isn't Tony on vacation the whole July and there is nobody
> > to push it to linux-omap?
> > 
> > Thanks for looking at the patches!
> 
> Yes, he is indeed. Good to see we are really getting rid of omap tags
> :-)

Hey, nice job cleaning up the n8x0 board support! Let's get those into
l-o master and queued up for the next merge window. (Except for the
hacks that is).

Tony
