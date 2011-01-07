From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure - solved + SPI bug fix
Date: Fri, 7 Jan 2011 20:24:57 +0000
Message-ID: <20110107202457.GW1198@n2100.arm.linux.org.uk>
References: <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk> <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107154920.GQ1198@n2100.arm.linux.org.uk> <20110107171020.GF880@atomide.com> <20110107171914.GB25446@angua.secretlab.ca> <20110107172511.GI880@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60930 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab1AGUZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 15:25:10 -0500
Content-Disposition: inline
In-Reply-To: <20110107172511.GI880@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

On Fri, Jan 07, 2011 at 09:25:11AM -0800, Tony Lindgren wrote:
> * Grant Likely <grant.likely@secretlab.ca> [110107 09:18]:
> > On Fri, Jan 07, 2011 at 09:10:20AM -0800, Tony Lindgren wrote:
> > > Grant,
> > > 
> > > Care to queue or ack the following fix?
> > 
> > If you bounce the patch to me, then I'll pick it up into the spi tree
> > and send it on to Linus right away.  (It didn't get sent to either me
> > or the spi list, so I don't have the original).
> 
> Thanks, bounced it to you.

As noted in the original patch, someone who understands this driver should
fix the other exit paths so buffers aren't left mapped when they shouldn't
be.
