From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Beagle defconfig broken in mainline
Date: Fri, 16 Jan 2009 21:23:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EF6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbZAPPxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 10:53:32 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0GFrNT5019348
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 09:53:29 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0GFrMVc014818
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 21:23:22 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm not sure if this has been reported before. I just tried compiling mainline for the beagleboard and got this error.

- Anand

  CC      arch/arm/mach-omap2/board-omap3beagle.o
arch/arm/mach-omap2/board-omap3beagle.c: In function 'beagle_twl_gpio_setup':
arch/arm/mach-omap2/board-omap3beagle.c:132: error: 'TWL4030_GPIO_MAX' undeclared (first use in this function)
arch/arm/mach-omap2/board-omap3beagle.c:132: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/board-omap3beagle.c:132: error: for each function it appears in.)
arch/arm/mach-omap2/board-omap3beagle.c: At top level:
arch/arm/mach-omap2/board-omap3beagle.c:141: error: variable 'beagle_gpio_data' has initializer but incomplete type
arch/arm/mach-omap2/board-omap3beagle.c:142: error: unknown field 'gpio_base' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:142: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:142: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:143: error: unknown field 'irq_base' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:143: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:143: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:144: error: unknown field 'irq_end' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:144: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:144: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:145: error: unknown field 'use_leds' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:145: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:145: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:146: error: unknown field 'pullups' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:146: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:146: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:147: error: unknown field 'pulldowns' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:148: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:148: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:149: error: unknown field 'setup' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:149: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:149: warning: (near initialization for 'beagle_gpio_data')
arch/arm/mach-omap2/board-omap3beagle.c:152: error: variable 'beagle_twldata' has initializer but incomplete type
arch/arm/mach-omap2/board-omap3beagle.c:153: error: unknown field 'irq_base' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:153: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:153: warning: (near initialization for 'beagle_twldata')
arch/arm/mach-omap2/board-omap3beagle.c:154: error: unknown field 'irq_end' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:154: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:154: warning: (near initialization for 'beagle_twldata')
arch/arm/mach-omap2/board-omap3beagle.c:157: error: unknown field 'gpio' specified in initializer
arch/arm/mach-omap2/board-omap3beagle.c:157: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-omap3beagle.c:157: warning: (near initialization for 'beagle_twldata')
arch/arm/mach-omap2/board-omap3beagle.c: In function 'omap3_beagle_init':
arch/arm/mach-omap2/board-omap3beagle.c:308: error: 'gpio' undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap2/board-omap3beagle.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2