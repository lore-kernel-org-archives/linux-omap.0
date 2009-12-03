From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 15:03:00 +0000
Message-ID: <20091203150300.GB26651@n2100.arm.linux.org.uk>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain> <20091203102700.GA30423@flint.arm.linux.org.uk> <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com> <20091203104354.GB20379@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com> <alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com> <20091203121157.GC20379@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33105 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbZLCPDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 10:03:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Thu, Dec 03, 2009 at 05:33:44AM -0700, Paul Walmsley wrote:
> My preference was to keep data separated from code in the source files; I 
> think it is slightly more readable.

It's less readable because instead of having similar stuff together, it's
at opposite ends of the file.

> The other consideration is that there are some patches in the works here 
> to move all of the struct clk function pointers into the struct clkops.  

Oh for gods sake, why do people take things to the extreme?

I looked into doing exactly that and decided it was a *bad* *idea* because
it stupidly multiplies the number of ops structures.  Instead of having a
few well-defined and well-understood ops structures, you end up with one
ops structure per special case.

Then you're going to be back into adding all that sodding crap that you
had back before I cleaned up the enable/disable shite.

No, please don't do this, this would definitely be a total backwards step.

Please take a moment to think about the changes you're doing.
