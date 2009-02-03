From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: BUG: LDP - smc911x region too small
Date: Tue, 3 Feb 2009 09:00:10 +0000
Message-ID: <20090203090010.GB5196@n2100.arm.linux.org.uk>
References: <20090119223750.GL18301@n2100.arm.linux.org.uk> <1232433403.31748.8.camel@localhost> <20090120083121.GA11157@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620376E9B0F3@dlee02.ent.ti.com> <498807E6.4090503@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55051 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZBCJA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 04:00:26 -0500
Content-Disposition: inline
In-Reply-To: <498807E6.4090503@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 03, 2009 at 05:01:26PM +0800, stanley.miao wrote:
> Woodruff, Richard wrote:
> >>>Here should be 0x100. Fixing this won't cause problems with smsc911x
> >>>patches.
> >>>      
> >>Yes it will - if it gets fixed in the -rc series for the smc911x driver
> >>your patches will conflict.
> >>
> >>There's more which needs fixing though - no platform data is being passed
> >>so the smc911x driver still fails to initialise.
> >>    
> >
> >Data sheet shows addressable range as 0x50 from base --> 0xFC.  So 0xFF 
> >should be good.
> >
> >I tried to send Russell data sheet but his emails is rejecting it.
> >
> >Regards,
> >Richard W.
> >
> >  
> It has been fixed.

No, it has not been fixed - it continues to fail in mainline kernels.

> http://marc.info/?l=linux-arm-kernel&m=123307584619895&w=2

That is a proposed patch for switching to the SMSC driver instead of
the SMC driver.  It's unclear at the moment whether it's acceptable
to switch to the SMSC driver for the -rc kernels.  Certainly just
applying the patch above results in something which is also nonfunctional.

The motivation here is to _fix_ mainline kernels.
