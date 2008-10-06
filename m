From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Compilation broken for 3430SDP defconfig
Date: Mon, 6 Oct 2008 18:47:20 +0300
Message-ID: <20081006154716.GA8273@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107644@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48026 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYJFPrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:47:55 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107644@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Mon, Oct 06, 2008 at 09:14:19PM +0530, Gadiyar, Anand wrote:
> CONFIG_GPIO_TWL4030 needs to be set in menuconfig otherwise,
> for OMAP3 defconfig we get the below build error.
> 
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
> /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
> /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:82: undefined reference to `twl4030_free_gpio'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
> /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:63: undefined reference to `twl4030_request_gpio'
> /share/anand/tony/arch/arm/mach-omap2/hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'
> make: *** [.tmp_vmlinux1] Error 1

Yes, we need defconfig changes since Kconfig is not asking about the new
CONFIG_GPIO_TWL4030 symbol added.

That'll probably change soon when we start using standard gpio calls but
please, provide the defconfig change. You could even do it for all omap3
plus 2430.

-- 
balbi
