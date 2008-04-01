From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Tue, 1 Apr 2008 15:43:56 +0300
Message-ID: <20080401124354.GS26502@atomide.com>
References: <20080328084139.GJ24896@atomide.com> <20080331104332.GH26502@atomide.com> <20080331143011.GO26502@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49297 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbYDAMn6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 08:43:58 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JgfqH-000PTG-Ae
	for linux-omap@vger.kernel.org; Tue, 01 Apr 2008 12:43:57 +0000
Content-Disposition: inline
In-Reply-To: <20080331143011.GO26502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080331 17:30]:
> * Tony Lindgren <tony@atomide.com> [080331 13:43]:
> > * Tony Lindgren <tony@atomide.com> [080328 10:41]:
> > > Hi all,
> > > 
> > > This helps with the annoying I2C timeouts. Does anybody have an idea
> > > why the twl4030 chip does not like doing multiple transfers in a row?
> > > 
> > > To me the only difference seems to be that clocks are idled between
> > > writing the twl4030 register and reading the register value.
> > 
> > I'll push this today with a REVISIT comment added.
> 
> Looks like this kills twl4030 interrupts, so I've reverted it.

After looking into this problem a bit more, looks like twl4030 reads
to anything in "POWER ID" (modules 0x10 and higher) will hang twl4030
eventually and I2C controller gets stuck in mode where STP never clears.

Repeated reads to "USB ID", "AUD ID" or "AUX ID" will not hang twl4030.

Tony
