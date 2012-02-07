From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3530 with no TWL4030 power controller
Date: Tue, 07 Feb 2012 14:55:52 -0800
Message-ID: <874nv2gsnb.fsf@ti.com>
References: <4F301177.4020008@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46478 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753992Ab2BGWz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 17:55:56 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so907019dae.5
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 14:55:55 -0800 (PST)
In-Reply-To: <4F301177.4020008@mlbassoc.com> (Gary Thomas's message of "Mon,
	06 Feb 2012 10:44:23 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

Gary Thomas <gary@mlbassoc.com> writes:

> I have an OMAP3530 (DM3730) board which uses a very simple
> power controller (TPS65910A1).  This controller does not
> support many of the power supplies, etc, that are common
> on the TWL4030 and similar devices.
>
> I'm using Linux 3.0.  

Can you try what you want with current linux-omap master?  I think I
have fixed any assumptions about the presence of the TWL PMICs, at least
from the voltage layer init.

> How can I remove the reliance on the
> TWL devices?  Simply disabling PM in my configuration isn't
> enough - that generates a bunch of undefined references.

CONFIG_PM is about lots more stuff than PMICs.  All the SoC-internal
power management (power domains, clocks, CPUidle, etc.) are controlled
by that as well.

> Also, there are many places where power supply stuff is
> accessed, outside of PM, in particular DSS2 which has a
> terrible time.  

Does CONFIG_REGULATOR_DUMMY help here? I believe that is for cases like
this where you don't want the regulator request to fail.

> Here's what I get when I disabled PM and
> REGULATOR support:
>
> arch/arm/mach-omap2/built-in.o: In function `omap_set_pwrdm_state':
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:122: undefined reference to `pwrdm_read_next_pwrst'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:126: undefined reference to `pwrdm_read_pwrst'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:127: undefined reference to `pwrdm_read_pwrst'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:133: undefined reference to `pwrdm_wait_transition'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:138: undefined reference to `pwrdm_set_next_pwrst'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:153: undefined reference to `pwrdm_set_lowpwrstchange'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:159: undefined reference to `pwrdm_wait_transition'
> /local/linux-3.0/arch/arm/mach-omap2/pm.c:160: undefined reference to
> `pwrdm_state_switch'

> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_get_context_loss_count':
> /local/linux-3.0/arch/arm/mach-omap2/omap_hwmod.c:2638: undefined reference to `pwrdm_get_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `_clkdm_clk_hwmod_disable':
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:895: undefined reference to `pwrdm_clkdm_state_switch'
> arch/arm/mach-omap2/built-in.o: In function `clkdm_allow_idle':
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:786: undefined reference to `pwrdm_clkdm_state_switch'
> arch/arm/mach-omap2/built-in.o: In function `_clkdm_clk_hwmod_enable':
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:869: undefined reference to `pwrdm_wait_transition'
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:870: undefined reference to `pwrdm_clkdm_state_switch'
> arch/arm/mach-omap2/built-in.o: In function `_clkdm_register':
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:79: undefined reference to `pwrdm_lookup'
> /local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:93: undefined reference to `pwrdm_add_clkdm'
> arch/arm/mach-omap2/built-in.o: In function `omap2_clk_disable_unused':
> /local/linux-3.0/arch/arm/mach-omap2/clock.c:442: undefined reference to `pwrdm_clkdm_state_switch'
> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_infrastructure':
> /local/linux-3.0/arch/arm/mach-omap2/io.c:355: undefined reference to `omap3xxx_voltagedomains_init'
> /local/linux-3.0/arch/arm/mach-omap2/io.c:356: undefined reference to `omap3xxx_powerdomains_init'

Can you be specific about what .config changes (compared to
omap2plus_defconfig) result in these warnings?

I thought we fixed these a while ago too.  Does this happen on newer kernels?

Kevin
