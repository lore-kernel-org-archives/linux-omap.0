From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Wed, 28 Jan 2009 07:59:02 -0800
Message-ID: <20090128155901.GP32148@atomide.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk> <20090124170408.GA7172@atomide.com> <20090124173824.GB27329@n2100.arm.linux.org.uk> <20090124183228.GB7172@atomide.com> <20090124184053.GC27329@n2100.arm.linux.org.uk> <20090124190130.GC7172@atomide.com> <20090128101745.GB15907@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54879 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZA1P7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 10:59:07 -0500
Content-Disposition: inline
In-Reply-To: <20090128101745.GB15907@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 02:17]:
> On Sat, Jan 24, 2009 at 11:01:36AM -0800, Tony Lindgren wrote:
> > I'll keep the clks-testing branch updated so we all can test it easily,
> > and then we'll just flip linux-omap to use that branch for the clocks
> > once everything is merged.
> 
> Note that I'm going to rebase the two omap-clks branches to be on top of
> Linus' tree now that my 'master' was merged.

OK, I'll refresh the clks-testing branch in linux-omap tree so people
can test it easily.

> I would also like to have Paul's patches by the weekend - I'm not asking
> for them to already be manipulated to apply on top of my patches, so it
> shouldn't take very much time to sort out which patches need to be sent
> to me.

Sounds doable, I believe Paul is pretty close to posting his series.

Regards,

Tony
