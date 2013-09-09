From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 09 Sep 2013 05:00:42 -0700
Message-ID: <522DB86A.8010207@roeck-us.net>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com> <20130908090206.GK25647@n2100.arm.linux.org.uk> <522CB0DE.2010102@roeck-us.net> <20130909105115.GL25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53827 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab3IIMAo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 08:00:44 -0400
In-Reply-To: <20130909105115.GL25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On 09/09/2013 03:51 AM, Russell King - ARM Linux wrote:
> On Sun, Sep 08, 2013 at 10:16:14AM -0700, Guenter Roeck wrote:
>> Since we are at it:
>>
>> Build reference: v3.11-7887-gb409624
>>
>> Building arm:defconfig ... passed
>> Building arm:allmodconfig ... failed
>> --------------
>> Error log:
>> arch/arm/mach-cns3xxx/pcie.c: In function 'cns3xxx_pcie_hw_init':
>> arch/arm/mach-cns3xxx/pcie.c:350:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
>> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
>> /tmp/cce439dZ.s: Assembler messages:
>> /tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode `isb '
>> /tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode `isb '
>> /tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode `dsb '
>> /tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode `isb '
>> /tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode `isb '
>> /tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode `dsb '
>> make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>> make: *** [arch/arm/mach-vexpress] Error 2
>> make: *** Waiting for unfinished jobs....
>> --------------
>>
>> Any solution for this one ? omap2plus passes for me.
>>
>> gcc version used is "arm-poky-linux-gnueabi-gcc (GCC) 4.7.2" from poky 1.3.
>
> That's due to:
>
> commit e8f9bb1bd6bb93fff773345cc54c42585e0e3ece
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Tue Jul 16 20:59:53 2013 -0400
>
>      ARM: vexpress/dcscb: fix cache disabling sequences
>
>      Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
>      cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
>      access within the disable and flush cache sequence, including to the
>      stack.
>
>      Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> which introduces some 'isb' and 'dsb' instructions which are not
> available on ARMv6 CPUs - however, their 'mcr' equivalents are.
>
> Either dcscb needs to be built with an -march=armv7 override, or
> they need to use the mcr equivalent instructions.
>

Well, I hope it will get fixed one way or another.
I don't know enough about arm to fix it myself.

Guenter

