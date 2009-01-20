From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: BUG: LDP - smc911x region too small
Date: Tue, 20 Jan 2009 08:31:21 +0000
Message-ID: <20090120083121.GA11157@n2100.arm.linux.org.uk>
References: <20090119223750.GL18301@n2100.arm.linux.org.uk> <1232433403.31748.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54967 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZATIbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 03:31:33 -0500
Content-Disposition: inline
In-Reply-To: <1232433403.31748.8.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jan 20, 2009 at 02:36:43PM +0800, stanley.miao wrote:
> On Mon, 2009-01-19 at 22:37 +0000, Russell King - ARM Linux wrote:
> > At the moment:
> > 
> >         ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
> >         ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
> > 
> > However, the SMC911x driver wants to claim 256 bytes from this region.
> > Indeed, its register set definitions appears to indicate that its needs
> > more than 16 bytes of address space.
> > 
> > So, the question is what is the right fix?
> > 
> > Unfortunately, fixing this will cause problems with the SMSC911x patches,
> > so I'd like to get an answer on this sooner rather than later please.
> 
> Here should be 0x100. Fixing this won't cause problems with smsc911x
> patches.

Yes it will - if it gets fixed in the -rc series for the smc911x driver
your patches will conflict.

There's more which needs fixing though - no platform data is being passed
so the smc911x driver still fails to initialise.
