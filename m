From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
	clock framework
Date: Thu, 17 Apr 2008 22:49:32 +0300
Message-ID: <1208461772.32060.14.camel@mort>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
	 <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
	 <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>
	 <200804171214.35936.david-b@pacbell.net>
	 <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33522 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYDQTxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 15:53:31 -0400
In-Reply-To: <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: David Brownell <david-b@pacbell.net>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hi all,
On Thu, 2008-04-17 at 13:44 -0600, ext Paul Walmsley wrote:
> Hello Hiroshi, David,
> 
> On Thu, 17 Apr 2008, David Brownell wrote:
> 
> > On Thursday 17 April 2008, Hiroshi DOYU wrote:
> > 
> > > And if there will be a little possibility that sysfs attribute can be
> > > used by userland in the future, keeping sysfs instead of debugfs
> > > doesn't seem not so illegal, does it?
> 
> True, but if we can do a debugfs implementation first, then that seems 
> like a good way to start, no?  Userspace PM implementations are probably 
> some months in the future, and we can mandate that debugfs be mounted for 
> those.

I can hardly see the benefit of a userspace implementation, considering
the extra context switch required and the fact the in many cases clocks
get enabled in response to irqs.

> > I happen to think that the clock tree is sensitive enough
> > that it should not be managed from userspace in production
> > systems.  (Except possibly through driver-specific APIs which
> > ensure the right rules are followed.)  Too easy to break things
> > otherwise.
> 
> In terms of the clock tree, it would be good to allow userspace-driven OPP 
> changes, analogous to CPUFreq's userspace governor.  [ In general, I agree 
> that userspace should not be changing driver clocks directly, just like 
> userspace should not be mucking around in /dev/mem directly :-) ]

That also sounds akward at best: cpufreq (or similar) is much better
suited for this sort of activity; userspace governor would be the
userspace controller you refer to, but it is far from being optimal.

Userspace should limit itself to changing policies.

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
