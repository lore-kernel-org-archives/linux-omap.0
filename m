From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 13:44:04 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com> <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com> <20080417.215723.241260895.Hiroshi.DOYU@nokia.com> <200804171214.35936.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53115 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYDQToH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 15:44:07 -0400
In-Reply-To: <200804171214.35936.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hello Hiroshi, David,

On Thu, 17 Apr 2008, David Brownell wrote:

> On Thursday 17 April 2008, Hiroshi DOYU wrote:
> 
> > And if there will be a little possibility that sysfs attribute can be
> > used by userland in the future, keeping sysfs instead of debugfs
> > doesn't seem not so illegal, does it?

True, but if we can do a debugfs implementation first, then that seems 
like a good way to start, no?  Userspace PM implementations are probably 
some months in the future, and we can mandate that debugfs be mounted for 
those.

> I happen to think that the clock tree is sensitive enough
> that it should not be managed from userspace in production
> systems.  (Except possibly through driver-specific APIs which
> ensure the right rules are followed.)  Too easy to break things
> otherwise.

In terms of the clock tree, it would be good to allow userspace-driven OPP 
changes, analogous to CPUFreq's userspace governor.  [ In general, I agree 
that userspace should not be changing driver clocks directly, just like 
userspace should not be mucking around in /dev/mem directly :-) ]

Clock tree changes (like OPP changes) which are not initiated by drivers 
do create some additional complexity.  Drivers will need to be notified 
before and after these changes.  

It turns out that DSP Bridge already needs post-frequency-change 
notification for the DSP clock - there is a patch here which will 
soon be posted to add those.

Pre-change notifiers are also needed to quiesce DMA, etc.; those are 
somewhat more difficult, but also in the works.


- Paul
