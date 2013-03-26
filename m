From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OK to use commit 71856843 as base for further omap clean up?
Date: Tue, 26 Mar 2013 23:22:00 +0000
Message-ID: <20130326232200.GQ30923@n2100.arm.linux.org.uk>
References: <20130319175921.GA22104@atomide.com> <5150A60E.2090108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45450 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab3CZXWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 19:22:20 -0400
Content-Disposition: inline
In-Reply-To: <5150A60E.2090108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Mar 25, 2013 at 02:31:26PM -0500, Jon Hunter wrote:
> Hi Russell,
> 
> On 03/19/2013 12:59 PM, Tony Lindgren wrote:
> > Hi Russell,
> > 
> > Can we use your commit 71856843 (ARM: OMAP: use consistent error checking)
> > as an immutable base for further omap dmtimer and gpmc work?
> 
> I saw that you updated your clean-up branch. Ok to use the below commit
> [1] as a base for some v3.10 updates?

It's still the same commit.  I'm not intending to remove this commit
from it, so yes, fine, go ahead.
