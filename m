From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
Date: Mon, 11 Jan 2010 16:29:18 +0000
Message-ID: <20100111162918.GA7220@n2100.arm.linux.org.uk>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com> <1263220628.6305.44.camel@pc1117.cambridge.arm.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com> <20100111152333.GB4109@n2100.arm.linux.org.uk> <1263227190.6305.51.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38324 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0AKQ3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 11:29:37 -0500
Content-Disposition: inline
In-Reply-To: <1263227190.6305.51.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, "Woodruff, Richard" <r-woodruff2@ti.com>

On Mon, Jan 11, 2010 at 04:26:30PM +0000, Catalin Marinas wrote:
> On Mon, 2010-01-11 at 15:23 +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> > > > Do you need to specify "r12" as well? What about "cc", are they
> > > > preserved by the secure monitor?
> > >
> > > r12 and reset of the registers are preserved. Lr needs to be saved but
> > > because of function call, the compiler saves/restores it.
> > 
> > That's not guaranteed; the compiler can re-use lr for its own purposes
> > within a function.  You need to add lr to the list of clobbered registers.
> 
> Do we need to specify "r12" in the list of clobbered registers as the
> inline asm explicitly modifies it? Or the compiler doesn't touch it.

Yes - again, the compiler should be told about everything that
potentially could change in an asm statement.

The compiler could decide to inline debug_writel, and use things
like r12 and lr to store temporary values within the parent function
across these calls.
