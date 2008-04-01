From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Tue, 1 Apr 2008 16:00:27 +0300
Message-ID: <20080401130027.GD5185@codecarver.research.nokia.com>
References: <20080328084139.GJ24896@atomide.com> <20080331104332.GH26502@atomide.com> <20080331143011.GO26502@atomide.com> <20080401124354.GS26502@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32852 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbYDANBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 09:01:05 -0400
Content-Disposition: inline
In-Reply-To: <20080401124354.GS26502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 01, 2008 at 03:43:56PM +0300, ext Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [080331 17:30]:
> > * Tony Lindgren <tony@atomide.com> [080331 13:43]:
> > > * Tony Lindgren <tony@atomide.com> [080328 10:41]:
> > > > Hi all,
> > > > 
> > > > This helps with the annoying I2C timeouts. Does anybody have an idea
> > > > why the twl4030 chip does not like doing multiple transfers in a row?
> > > > 
> > > > To me the only difference seems to be that clocks are idled between
> > > > writing the twl4030 register and reading the register value.
> > > 
> > > I'll push this today with a REVISIT comment added.
> > 
> > Looks like this kills twl4030 interrupts, so I've reverted it.
> 
> After looking into this problem a bit more, looks like twl4030 reads
> to anything in "POWER ID" (modules 0x10 and higher) will hang twl4030
> eventually and I2C controller gets stuck in mode where STP never clears.
> 
> Repeated reads to "USB ID", "AUD ID" or "AUX ID" will not hang twl4030.
> 

I remember seeing something similar when doing the powerbutton code. 
Klaus Pedersen found out that leaving CFG_BOOT to its reset value solved
the problem. Unfortunately this breaks MADC and USB afaics, so it's not
a real solution. CFG_BOOT is programmed in power_companion_init().

Cheers,

Peter.

-- 
goa is a state of mind
