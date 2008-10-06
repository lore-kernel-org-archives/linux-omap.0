From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Compilation broken for 3430SDP defconfig
Date: Mon, 6 Oct 2008 21:14:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107644@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41785 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYJFPo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:44:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

CONFIG_GPIO_TWL4030 needs to be set in menuconfig otherwise,
for OMAP3 defconfig we get the below build error.

arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
/share/anand/tony/arch/arm/mach-omap2/hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
/share/anand/tony/arch/arm/mach-omap2/hsmmc.c:82: undefined reference to `twl4030_free_gpio'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
/share/anand/tony/arch/arm/mach-omap2/hsmmc.c:63: undefined reference to `twl4030_request_gpio'
/share/anand/tony/arch/arm/mach-omap2/hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'
make: *** [.tmp_vmlinux1] Error 1
