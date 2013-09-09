From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 9 Sep 2013 09:03:48 -0700
Message-ID: <20130909160348.GB18975@roeck-us.net>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com>
 <20130908090206.GK25647@n2100.arm.linux.org.uk>
 <522CB0DE.2010102@roeck-us.net>
 <20130909105115.GL25647@n2100.arm.linux.org.uk>
 <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64104 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab3IIQDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 12:03:52 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so6394397pdj.12
        for <linux-omap@vger.kernel.org>; Mon, 09 Sep 2013 09:03:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Mon, Sep 09, 2013 at 10:24:42AM -0400, Nicolas Pitre wrote:
> On Mon, 9 Sep 2013, Guenter Roeck wrote:
> 
> > On 09/09/2013 03:51 AM, Russell King - ARM Linux wrote:
> > > On Sun, Sep 08, 2013 at 10:16:14AM -0700, Guenter Roeck wrote:
> > > > Since we are at it:
> > > > 
> > > > Build reference: v3.11-7887-gb409624
> > > > 
> > > > Building arm:defconfig ... passed
> > > > Building arm:allmodconfig ... failed
> > > > --------------
> > > > Error log:
> > > > arch/arm/mach-cns3xxx/pcie.c: In function 'cns3xxx_pcie_hw_init':
> > > > arch/arm/mach-cns3xxx/pcie.c:350:1: warning: the frame size of 1064 bytes
> > > > is larger than 1024 bytes [-Wframe-larger-than=]
> > > > arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
> > > > return_address should use unwind tables" [-Wcpp]
> > > > arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
> > > > return_address should use unwind tables" [-Wcpp]
> > > > /tmp/cce439dZ.s: Assembler messages:
> > > > /tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode
> > > > `isb '
> > > > /tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode
> > > > `isb '
> > > > /tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode
> > > > `dsb '
> > > > /tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode
> > > > `isb '
> > > > /tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode
> > > > `isb '
> > > > /tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode
> > > > `dsb '
> > > > make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
> > > > make: *** [arch/arm/mach-vexpress] Error 2
> > > > make: *** Waiting for unfinished jobs....
> > > > --------------
> > > > 
> > > > Any solution for this one ? omap2plus passes for me.
> > > > 
> > > > gcc version used is "arm-poky-linux-gnueabi-gcc (GCC) 4.7.2" from poky
> > > > 1.3.
> > > 
> > > That's due to:
> > > 
> > > commit e8f9bb1bd6bb93fff773345cc54c42585e0e3ece
> > > Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > Date:   Tue Jul 16 20:59:53 2013 -0400
> > > 
> > >      ARM: vexpress/dcscb: fix cache disabling sequences
> > > 
> > >      Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
> > >      cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
> > >      access within the disable and flush cache sequence, including to the
> > >      stack.
> > > 
> > >      Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > which introduces some 'isb' and 'dsb' instructions which are not
> > > available on ARMv6 CPUs - however, their 'mcr' equivalents are.
> > > 
> > > Either dcscb needs to be built with an -march=armv7 override, or
> > > they need to use the mcr equivalent instructions.
> > > 
> > 
> > Well, I hope it will get fixed one way or another.
> > I don't know enough about arm to fix it myself.
> 
> Would you try this patch please:
> 
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 36ea824712..505e64ab3e 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -7,6 +7,8 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  obj-y					:= v2m.o
>  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
>  obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
>  obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
> +CFLAGS_dcscb.o				+= -march=armv7-a
>  obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
> +CFLAGS_tc2_pm.o				+= -march=armv7-a
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> 
That fixes this problem. I'll leave it up to you and Russell to decide if it is
the proper fix.

Unfortunately, there are more problems.

arch/arm/kernel/built-in.o: In function `ret_fast_syscall':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:42: undefined reference to `user_enter'
arch/arm/kernel/built-in.o: In function `no_work_pending':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:77: undefined reference to `user_enter'
arch/arm/kernel/built-in.o: In function `vector_swi':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-common.S:376: undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__dabt_usr':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:365: undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__irq_usr':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:375: undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__und_usr':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:388: undefined reference to `user_exit'
arch/arm/kernel/built-in.o: In function `__pabt_usr':
/home/groeck/src/linux-stable/arch/arm/kernel/entry-armv.S:662: undefined reference to `user_exit'
arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
/home/groeck/src/linux-stable/arch/arm/mach-omap2/board-omap3evm.c:703:
undefined reference to `usb_nop_xceiv_register'

The undefined reference to usb_nop_xceiv_register is because CONFIG_NOP_USB_XCEIV
is built as module but obviously called from code built into the kernel.
Not sure what the correct fix is - build CONFIG_NOP_USB_XCEIV into the kernel,
make usb_nop_xceiv_register a dummy function if CONFIG_NOP_USB_XCEIV is built
as module but called from built-in code, or don't call usb_nop_xceiv_register
from code built into the kernel.

No idea where the undefined user_enter and user_exit comes from.

Guenter
