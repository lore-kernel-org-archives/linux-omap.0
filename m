From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY +
	!DEBUG_[SPINLOCK|MUTEXES] = BUG()
Date: Mon, 25 Feb 2013 16:14:01 +0000
Message-ID: <20130225161401.GB30923@n2100.arm.linux.org.uk>
References: <20130221094819.GA4580@luxor.wired.org> <20130222123637.GA30923@n2100.arm.linux.org.uk> <20130225142048.GA6616@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49801 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759059Ab3BYQTT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Feb 2013 11:19:19 -0500
Content-Disposition: inline
In-Reply-To: <20130225142048.GA6616@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Feb 25, 2013 at 03:20:48PM +0100, Paolo Pisati wrote:
> On Fri, Feb 22, 2013 at 12:36:37PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> > > any idea how can i debug this?
> > 
> > Please try this patch, and report back whether it solves your problem.
> > Thanks.
> 
> yes, it solves my problem: any chance we can see it in 3.9 or 3.8.x?

I was just looking to send a chase for this, because I'm about to
remerge my tree and I wanted this patch committed.

Can I use your name and email address in the commit for the Reported-by
and Tested-by tags (which will be published in the kernel repository)
please?  Thanks.
