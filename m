From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: LDP support
Date: Mon, 1 Jun 2009 08:45:26 +0100
Message-ID: <20090601074526.GB10590@n2100.arm.linux.org.uk>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162038DEAB716@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41366 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbZFAHph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 03:45:37 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038DEAB716@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Sun, May 31, 2009 at 07:24:19PM -0500, Woodruff, Richard wrote:
> > 6. do ___NOT___ (underscored in triplicate and 500ft high letters) enable
> >    ARM errata 460075 - it solidly prevents the kernel booting on LDP.
> >    (it's taken many hours to debug that.)
> 
> This is an r2p0 errata only.  It's not in earlier versions or in later cores.

Yes.

> Today there are only r1pX OMAP3s today.  In the future there will be r3px
> also.

That's something that TI may know, but it's almost impossible for developers
to know because:

(a) the OMAP3430 TRMs aren't available.
(b) you have to reverse engineer the ARM ID register using the ARM Cortex
A8 TRMs to find out that the 'variant' field describes the number after
'r' and the 'revision' field describes the number after the 'p', and then
looking at the ID value reported by the kernel for the OMAP3430 in the
LDP, you find that it's an undocumented r1p2 version.

So it's all very well specifying that errata N applies to some random
variants and revisions of the CPU, but that's insufficient for developers
who'll be configuring the kernel.

As said on linux-arm-kernel, we need the kernel to only apply these errata
fixes to the CPUs which they are applicable to if enabled, rather than
every CPU.  I provided a patch to do this, and this enables LDP to boot
with all errata config options enabled.
