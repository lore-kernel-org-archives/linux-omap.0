From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/14] ARM: v6k: select TLS register code according to
	V6 variants
Date: Mon, 17 Jan 2011 22:36:35 +0000
Message-ID: <20110117223635.GB25829@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk> <alpine.LFD.2.00.1101171717090.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab1AQWgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:36:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101171717090.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 05:23:43PM -0500, Nicolas Pitre wrote:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
> 
> > If CONFIG_CPU_V6 is enabled, we may or may not have the TLS register.
> > Use the conditional code which copes with this variability.  Otherwise,
> > if CONFIG_CPU_32v6K is set, we know we have the TLS register on all
> > supported CPUs, so use it unconditionally.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Note: this is becoming a bit confusing and prone to mistake when we have:

Agreed.

> 	CONFIG_CPU_V6
> 	CONFIG_CPU_V6K
> 	CONFIG_CPU_32v6
> 	CONFIG_CPU_32v6K
> 
> I don't know what to suggest for a less similar naming scheme between 
> the CPU design and the allowed instruction set though.

It's best to consider CONFIG_CPU_V6/CONFIG_CPU_V6K/CONFIG_CPU_V7 in the
same light as CONFIG_CPU_ARM926T etc.  It selects a specific CPU core
(or family of CPU cores) rather than an architecture - the fact that it
_may_ tie up with an architecture is incidental.

The CPU_32vX selects the major architecture version.  32vX<letter> selects
sub-options of the architecture.

It may be better at some point to get rid of the CPU_32v* and replace
them with CPU_ARCH_V* instead, which makes it clear that these ones
definitely refer to the architecture versions.

The last point while we're here is I don't think it helps to have the
conditionals spread between the Kconfig files and this file - I'd much
rather see them all in Kconfig so we can see exactly how we end up with
each option (TLS_EMUL, TLS_V6, TLS_V6K) in one place.
