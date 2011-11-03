From: Daniel Mack <zonque@gmail.com>
Subject: mainline tree fails to build with OMAP3-only config
Date: Thu, 03 Nov 2011 16:48:01 +0100
Message-ID: <4EB2B7B1.4070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45595 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab1KCPsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 11:48:12 -0400
Received: by faao14 with SMTP id o14so1658192faa.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 08:48:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org

Hi,

when trying to build an OMAP3-only config with Linus' current mainline 
HEAD, I'm getting the following errors. The same config works fine with 
v3.1.

The reasons seems to be that arch/arm/mach-omap2/io.c defines the 
*_init_early() functions unconditionally for all platforms. Is this 
already fixed in any tree?


Thanks,
Daniel


   LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap4430_init_early':
twl-common.c:(.init.text+0x4f0): undefined reference to 
`omap2_set_globals_443x'
twl-common.c:(.init.text+0x4f8): undefined reference to 
`omap44xx_voltagedomains_init'
twl-common.c:(.init.text+0x4fc): undefined reference to 
`omap44xx_powerdomains_init'
twl-common.c:(.init.text+0x500): undefined reference to 
`omap44xx_clockdomains_init'
twl-common.c:(.init.text+0x504): undefined reference to 
`omap44xx_hwmod_init'
twl-common.c:(.init.text+0x510): undefined reference to `omap4xxx_clk_init'
arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
twl-common.c:(.init.text+0x578): undefined reference to 
`omap2_set_globals_243x'
twl-common.c:(.init.text+0x580): undefined reference to 
`omap2xxx_voltagedomains_init'
twl-common.c:(.init.text+0x584): undefined reference to 
`omap243x_powerdomains_init'
twl-common.c:(.init.text+0x588): undefined reference to 
`omap243x_clockdomains_init'
twl-common.c:(.init.text+0x58c): undefined reference to 
`omap2430_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap2420_init_early':
twl-common.c:(.init.text+0x59c): undefined reference to 
`omap2_set_globals_242x'
twl-common.c:(.init.text+0x5a4): undefined reference to 
`omap2xxx_voltagedomains_init'
twl-common.c:(.init.text+0x5a8): undefined reference to 
`omap242x_powerdomains_init'
twl-common.c:(.init.text+0x5ac): undefined reference to 
`omap242x_clockdomains_init'
twl-common.c:(.init.text+0x5b0): undefined reference to 
`omap2420_hwmod_init'
make: *** [.tmp_vmlinux1] Error 1

