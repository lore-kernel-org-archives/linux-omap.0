From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/14] ARM: v6k: select TLS register code according to
	V6 variants
Date: Mon, 17 Jan 2011 22:52:33 +0000
Message-ID: <20110117225233.GC25829@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk> <alpine.LFD.2.00.1101171717090.8580@xanadu.home> <20110117223635.GB25829@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab1AQWwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:52:40 -0500
Content-Disposition: inline
In-Reply-To: <20110117223635.GB25829@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 17, 2011 at 10:36:35PM +0000, Russell King - ARM Linux wrote:
> It may be better at some point to get rid of the CPU_32v* and replace
> them with CPU_ARCH_V* instead, which makes it clear that these ones
> definitely refer to the architecture versions.

Last point on this is that I think we want to sanitize PJ4.

If we think about CPU_V7 as being the selection of ARM CPUs which are V7
architectures, CPU_PJ4 should be a separate config option selecting all
the same symbols which CPU_V7 does - and that should also select proc-v7.S
for building.

I'm not sure it makes sense to have (eg) the V7 perf events available on
PJ4 or the ARM errata for their V7 cores?

Does PJ4 have VFPv3?  Is Neon available on PJ4?  What about the DCC
debug registers?

etc.
