From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
Date: Fri, 28 Jan 2011 13:22:08 +0000
Message-ID: <20110128132208.GE13005@n2100.arm.linux.org.uk>
References: <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk> <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com> <20110127185935.GA1651@n2100.arm.linux.org.uk> <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com> <20110128095953.GA13005@n2100.arm.linux.org.uk> <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com> <20110128110629.GB13005@n2100.arm.linux.org.uk> <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com> <20110128130532.GC13005@n2100.arm.linux.org.uk> <1296220256.1799.62.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47378 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1A1NWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 08:22:16 -0500
Content-Disposition: inline
In-Reply-To: <1296220256.1799.62.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 28, 2011 at 01:10:56PM +0000, Catalin Marinas wrote:
> On Fri, 2011-01-28 at 13:05 +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 28, 2011 at 12:25:18PM +0000, Catalin Marinas wrote:
> > > With your latest patches, do we use the TLS emulation on ARMv7 (UP) if
> > > v6 is compiled in? If that's the case, we may have a problem - I talked
> > > to the toolchain guys and it looks like code optimised for ARMv7 reads
> > > the TLS register directly without going through the kuser helper.
> > 
> > That's not a problem, because you wouldn't run ARMv7 optimized userspace
> > on an ARMv6 CPU.  That's not what this whole exercise is about.
> 
> But you can run ARMv7 optimised userspace on ARMv7 CPU with a kernel
> image compiled for v6+v7.

Yes.
