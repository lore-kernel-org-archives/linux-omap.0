From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 00:36:56 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302160035240.6419@syhkavp.arg>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:32947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3BPFg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 00:36:57 -0500
Received: from xanadu.home ([24.202.213.203]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MIA005KASXKSI20@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Sat, 16 Feb 2013 00:36:56 -0500 (EST)
In-reply-to: <20130215163031.GA5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Fri, 15 Feb 2013, Tony Lindgren wrote:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 05:34]:
> > On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
> > >On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
> > >>Whats your view on use of arch_ioremap_caller() hook ? This can allow
> > >>us to avoid the dual ioremap() issue discussed here if the hook
> > >>maintains the list of mapped ios.
> > >>
> > >>I was even thinking of having such intelligence within the core
> > >>ioremap code but thought that might be too invasive.
> > >
> > >Why do you even need it?  There's no problem with ioremapping the same
> > >space multiple times (you end up with multiple mappings but that
> > >shouldn't be a problem, except for the additional space used.)
> > >
> > It just waste of iospace and Tony insisted to have just single ioremap()
> > hence all this discussion
> 
> The main goal is to avoid duplicating data both in hwmod and DT.
> That's pretty much solved as we can have the driver probe populate
> the common data for hwmod from DT as Santosh has already demonstrated.
> 
> Then we also want the driver specific idle and reset code to be done
> in the drivers rather than in hwmod and glue it together with hwmod
> using runtime PM. The biggest issue there is how do we reset and idle
> some piece of hardware for PM purposes when there's no driver loaded.
> 
> For the duplicate ioremapping, I don't think there's any need to
> do it if we get things right.

Note that if the ioremap matches a static map area there is no cost to 
ioremap it multiple times.


Nicolas
