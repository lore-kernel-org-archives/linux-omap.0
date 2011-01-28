From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Fri, 28 Jan 2011 08:49:44 -0800
Message-ID: <20110128164944.GT23412@atomide.com>
References: <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
 <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
 <20110127185935.GA1651@n2100.arm.linux.org.uk>
 <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
 <20110128095953.GA13005@n2100.arm.linux.org.uk>
 <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
 <20110128110629.GB13005@n2100.arm.linux.org.uk>
 <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com>
 <20110128132134.GD13005@n2100.arm.linux.org.uk>
 <1296227465.1799.95.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27424 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1A1QuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 11:50:02 -0500
Content-Disposition: inline
In-Reply-To: <1296227465.1799.95.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [110128 07:11]:
> On Fri, 2011-01-28 at 13:21 +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 28, 2011 at 12:25:18PM +0000, Catalin Marinas wrote:
> > > With your latest patches, do we use the TLS emulation on ARMv7 (UP) if
> > > v6 is compiled in? If that's the case, we may have a problem - I talked
> > > to the toolchain guys and it looks like code optimised for ARMv7 reads
> > > the TLS register directly without going through the kuser helper. So you
> > > may have people taking an Ubuntu filesystem (v7 only) and a pre-built
> > > OMAP image with TLS emulation even on Cortex-A8 and things won't work as
> > > expected.
> > 
> > You're really making a mountain out of TLS.
> 
> Not really, just asking for clarification as I haven't checked all your
> patches recently.
> 
> > If we have a v6+v6k+v7 kernel, then the way the kernel TLS code is built,
> > we will use the TLS register if that's available on the hardware.  If it
> > isn't, we will write the TLS value directly to virtual 0xffff0ffc.
> > 
> > So, a kernel built for v6+v6k+v7, when run on v7, will set the hardware
> > TLS register, and your v7 optimized binaries which access the TLS register
> > directly will work.  Same for v6k.
> 
> Great.

Yes AFAIK we sorted out the TLS issue already a while back for v6+v6k+v7.

Regards,

Tony
