From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OK to use commit 71856843 as base for further omap clean up?
Date: Wed, 3 Apr 2013 17:53:53 +0100
Message-ID: <20130403165353.GW30923@n2100.arm.linux.org.uk>
References: <20130319175921.GA22104@atomide.com> <5150A60E.2090108@ti.com> <20130326232200.GQ30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51424 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762275Ab3DCQyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 12:54:04 -0400
Content-Disposition: inline
In-Reply-To: <20130326232200.GQ30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 26, 2013 at 11:22:00PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 25, 2013 at 02:31:26PM -0500, Jon Hunter wrote:
> > Hi Russell,
> > 
> > On 03/19/2013 12:59 PM, Tony Lindgren wrote:
> > > Hi Russell,
> > > 
> > > Can we use your commit 71856843 (ARM: OMAP: use consistent error checking)
> > > as an immutable base for further omap dmtimer and gpmc work?
> > 
> > I saw that you updated your clean-up branch. Ok to use the below commit
> > [1] as a base for some v3.10 updates?
> 
> It's still the same commit.  I'm not intending to remove this commit
> from it, so yes, fine, go ahead.

*sigh*.  Actually, 4d485661d799e81f98097057d445f4803cef2af0 is buggered
which is the commit below it.  I said yes too quickly.  Oh well, it'll
just have to be broken for when it hits mainline now.
