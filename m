From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 17:55:30 -0800
Message-ID: <20120205015530.GI1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10188 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2BEBzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 20:55:33 -0500
Content-Disposition: inline
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> 
> Another problem oopses the kernel at boot in the voltage domain code,
> which I suspect this has never been boot tested on OMAP34xx CPUs:
> 
> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
...
> Backtrace: 
> [<c03db824>] (omap_vp_init+0x0/0x15c) from [<c03db448>] (omap_voltage_late_init+
> 0xc4/0xfc)
> [<c03db384>] (omap_voltage_late_init+0x0/0xfc) from [<c03d9df8>] (omap2_common_p
> m_late_init+0x14/0x54)
>  r8:00000000 r7:00000013 r6:c0039988 r5:c03fe004 r4:c03fdfb8
> [<c03d9de4>] (omap2_common_pm_late_init+0x0/0x54) from [<c0008798>] (do_one_init
> call+0x9c/0x164)
> [<c00086fc>] (do_one_initcall+0x0/0x164) from [<c03d1284>] (kernel_init+0x7c/0x1
> 20)
> [<c03d1208>] (kernel_init+0x0/0x120) from [<c0039988>] (do_exit+0x0/0x2cc)
>  r5:c03d1208 r4:00000000
...

> And OMAP4 doesn't build.  Fixing the build error in prm44xx.c (which is
> virtually the same as the OMAP3 build error in its prm file) gets us to
> a buildable state, but... it silently fails to boot.
> 
> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> 
> At least enabling DEBUG_LL gets this reason:
> 
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
...
> Backtrace:                                                                      
> [<c007bab4>] (irq_domain_add+0x0/0x134) from [<c029baac>] (twl_probe+0xd0/0x370)
>  r6:c03bef90 r5:00000014 r4:00000170                                            
> [<c029b9dc>] (twl_probe+0x0/0x370) from [<c01eee70>] (i2c_device_probe+0xb0/0xe4
> )                                                                               
> [<c01eedc0>] (i2c_device_probe+0x0/0xe4) from [<c01d1f34>] (really_probe+0xa0/0x
> 178)                                                                            
...

Just to verify, it seems that both of these happen because of
IRQ_DOMAIN not being set?

And that causes twl-core to not get built as drivers/mfd/Kconfig wrongly
depends on IRQ_DOMAIN that only gets currently selected with OF..

So I assume the patch you posted at [1] fixes both of the above?

Regards,

Tony


[1] http://marc.info/?l=linuxppc-embedded&m=132839494214427&w=2
