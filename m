From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Compilation broken for 3430SDP defconfig
Date: Mon, 6 Oct 2008 21:23:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D610764D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107644@dbde02.ent.ti.com>
 <20081006154716.GA8273@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbYJFPxf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:53:35 -0400
In-Reply-To: <20081006154716.GA8273@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> On Mon, Oct 06, 2008 at 09:14:19PM +0530, Gadiyar, Anand wrote:
> > CONFIG_GPIO_TWL4030 needs to be set in menuconfig otherwise,
> > for OMAP3 defconfig we get the below build error.
> > 
> > arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
> > /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
> > arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
> > /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:82: undefined reference to `twl4030_free_gpio'
> > arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
> > /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:63: undefined reference to `twl4030_request_gpio'
> > /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> Yes, we need defconfig changes since Kconfig is not asking about the new
> CONFIG_GPIO_TWL4030 symbol added.
> 
> That'll probably change soon when we start using standard gpio calls but
> please, provide the defconfig change. You could even do it for all omap3
> plus 2430.

Will it help if we have a 'default' option in drivers/gpio/Kconfig?

Something like:
+	default y if ARCH_OMAP34XX || MACH_OMAP_2430SDP


