From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Mon, 1 Apr 2013 10:24:00 -0700
Message-ID: <20130401172400.GM10155@atomide.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
 <51482707.6020501@ti.com>
 <1363684373.15426.137.camel@sokoban>
 <alpine.DEB.2.00.1303261829440.23957@utopia.booyaka.com>
 <1364375463.3146.9.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56087 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756763Ab3DARYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 13:24:06 -0400
Content-Disposition: inline
In-Reply-To: <1364375463.3146.9.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

* Tero Kristo <t-kristo@ti.com> [130327 02:15]:
> On Tue, 2013-03-26 at 18:43 +0000, Paul Walmsley wrote:
> > 
> > So what I'd like you to do is:
> > 
> > 1. Determine what devices are remaining to be reset and idled on OMAP4 
> >    with the bootloader that I use.  As far as I know, there are only four 
> >    that block full-chip idle: M3, DSP, SL2IF, FSUSB
> > 
> > 2. Determine what's needed to reset and idle them.  For the M3 and DSP, 
> >    I'd assume this involves pointing the reset vector for those 
> >    processors at a few lines of code that basically enter WFI or the C64x 
> >    equivalent.
> 
> This is the nasty part. We need firmware support for the blocks to do
> this, and this is imo a complete overkill for the task at hand, as it
> will duplicate the DSP + M3 firmware and drivers at least partially. On
> OMAP3, it was easy as you could just setup the boot mode for IVA and get
> over with it. We don't have similar luxury on OMAP4.
> 
> If there was a simple way to do this, don't you think this would have
> been done already a year back when we started to discuss this first
> time? And, a year old bootloader is ancient seeing we didn't have any
> kind of support for OMAP4 core idle in mainline back then and this
> feature was essentially completely untested.... nobody cared about the
> upstream u-boot PM compatibility before that.

You may be able to have an inline function in the DSP and M3 headers
that idles those modules that can also be called from the reset and idle
function in the hwmod code. That way the driver related code stays in
the driver, but can be called from hwmod reset if the driver is not
compiled in.

Of course if the reset and idle of DSP and M3 gets more complex than
just a few lines of code, then we should just determine that the PM is
broken without those drivers and print out a warning.

Regards,

Tony
