From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 9 Sep 2013 11:51:15 +0100
Message-ID: <20130909105115.GL25647@n2100.arm.linux.org.uk>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com> <20130908090206.GK25647@n2100.arm.linux.org.uk> <522CB0DE.2010102@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54114 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab3IIKvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 06:51:35 -0400
Content-Disposition: inline
In-Reply-To: <522CB0DE.2010102@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Nicolas Pitre <nico@fluxnic.net>
Cc: Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Sun, Sep 08, 2013 at 10:16:14AM -0700, Guenter Roeck wrote:
> Since we are at it:
>
> Build reference: v3.11-7887-gb409624
>
> Building arm:defconfig ... passed
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> arch/arm/mach-cns3xxx/pcie.c: In function 'cns3xxx_pcie_hw_init':
> arch/arm/mach-cns3xxx/pcie.c:350:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
> /tmp/cce439dZ.s: Assembler messages:
> /tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode `dsb '
> /tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode `dsb '
> make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
> make: *** [arch/arm/mach-vexpress] Error 2
> make: *** Waiting for unfinished jobs....
> --------------
>
> Any solution for this one ? omap2plus passes for me.
>
> gcc version used is "arm-poky-linux-gnueabi-gcc (GCC) 4.7.2" from poky 1.3.

That's due to:

commit e8f9bb1bd6bb93fff773345cc54c42585e0e3ece
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Jul 16 20:59:53 2013 -0400

    ARM: vexpress/dcscb: fix cache disabling sequences

    Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
    cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
    access within the disable and flush cache sequence, including to the
    stack.

    Signed-off-by: Nicolas Pitre <nico@linaro.org>

which introduces some 'isb' and 'dsb' instructions which are not
available on ARMv6 CPUs - however, their 'mcr' equivalents are.

Either dcscb needs to be built with an -march=armv7 override, or
they need to use the mcr equivalent instructions.
