From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: OMAP: build mach-omap code only if needed
Date: Thu, 4 Jul 2013 04:59:30 -0700
Message-ID: <20130704115929.GK5523@atomide.com>
References: <3976244.L5dCjrM5gT@wuerfel>
 <20130625072812.GD5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41610 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985Ab3GDL7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 07:59:34 -0400
Content-Disposition: inline
In-Reply-To: <20130625072812.GD5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130625 00:34]:
> * Arnd Bergmann <arnd@arndb.de> [130624 07:25]:
> > If we build a kernel with CONFIG_ARCH_OMAP2PLUS enabled but all of the
> > individual SoCs disabled, we run into a large number of link errors
> > because if incorrect dependencies:
> > 
> > arch/arm/mach-omap2/built-in.o: In function `_add_initiator_dep':
> > arch/arm/mach-omap2/omap_hwmod.c:691: undefined reference to `clkdm_add_sleepdep' arch/arm/mach-omap2/built-in.o: In function `_del_initiator_dep':
> > arch/arm/mach-omap2/omap_hwmod.c:720: undefined reference to `clkdm_del_sleepdep' arch/arm/mach-omap2/built-in.o: In function `_enable':
> > arch/arm/mach-omap2/omap_hwmod.c:2145: undefined reference to `clkdm_in_hwsup'
> > arch/arm/mach-omap2/omap_hwmod.c:2147: undefined reference to `clkdm_hwmod_enable'
> > arch/arm/mach-omap2/omap_hwmod.c:2191: undefined reference to `clkdm_hwmod_disable'
> > arch/arm/mach-omap2/omap_hwmod.c:2146: undefined reference to `clkdm_missing_idle_reporting' arch/arm/mach-omap2/built-in.o: In function `_idle':
> > arch/arm/mach-omap2/omap_hwmod.c:2235: undefined reference to `clkdm_hwmod_disable' arch/arm/mach-omap2/built-in.o: In function `_shutdown':
> > arch/arm/mach-omap2/omap_hwmod.c:2338: undefined reference to `clkdm_hwmod_disable' arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_get_context_loss_count':
> > arch/arm/mach-omap2/omap_hwmod.c:4071: undefined reference to `pwrdm_get_context_loss_count' arch/arm/mach-omap2/built-in.o: In function `omap_pm_clkdms_setup':
> > arch/arm/mach-omap2/pm.c:114: undefined reference to `clkdm_allow_idle'
> > arch/arm/mach-omap2/pm.c:117: undefined reference to `clkdm_sleep' arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_late_init':
> > arch/arm/mach-omap2/pm.c:294: undefined reference to `omap_voltage_late_init' arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> > arch/arm/mach-omap2/gpio.c:133: undefined reference to `pwrdm_can_ever_lose_context'
> > 
> > We can avoid this if we make CONFIG_ARCH_OMAP2PLUS a silent option that
> > gets enabled any time that one of the SoC versions is enabled.
> 
> /me hopes this does the trick finally ;)
> 
> I could not apply this to anything I tried though..
> Which branch is this against?

Ping, do you have updated patche(s) available as we discussed on IRC?

Tony
