From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP3530 with no TWL4030 power controller
Date: Mon, 06 Feb 2012 10:44:23 -0700
Message-ID: <4F301177.4020008@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:36789 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab2BFRo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 12:44:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have an OMAP3530 (DM3730) board which uses a very simple
power controller (TPS65910A1).  This controller does not
support many of the power supplies, etc, that are common
on the TWL4030 and similar devices.

I'm using Linux 3.0.  How can I remove the reliance on the
TWL devices?  Simply disabling PM in my configuration isn't
enough - that generates a bunch of undefined references.
Also, there are many places where power supply stuff is
accessed, outside of PM, in particular DSS2 which has a
terrible time.  Here's what I get when I disabled PM and
REGULATOR support:

arch/arm/mach-omap2/built-in.o: In function `omap_set_pwrdm_state':
/local/linux-3.0/arch/arm/mach-omap2/pm.c:122: undefined reference to `pwrdm_read_next_pwrst'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:126: undefined reference to `pwrdm_read_pwrst'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:127: undefined reference to `pwrdm_read_pwrst'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:133: undefined reference to `pwrdm_wait_transition'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:138: undefined reference to `pwrdm_set_next_pwrst'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:153: undefined reference to `pwrdm_set_lowpwrstchange'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:159: undefined reference to `pwrdm_wait_transition'
/local/linux-3.0/arch/arm/mach-omap2/pm.c:160: undefined reference to `pwrdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_get_context_loss_count':
/local/linux-3.0/arch/arm/mach-omap2/omap_hwmod.c:2638: undefined reference to `pwrdm_get_context_loss_count'
arch/arm/mach-omap2/built-in.o: In function `_clkdm_clk_hwmod_disable':
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:895: undefined reference to `pwrdm_clkdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `clkdm_allow_idle':
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:786: undefined reference to `pwrdm_clkdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `_clkdm_clk_hwmod_enable':
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:869: undefined reference to `pwrdm_wait_transition'
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:870: undefined reference to `pwrdm_clkdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `_clkdm_register':
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:79: undefined reference to `pwrdm_lookup'
/local/linux-3.0/arch/arm/mach-omap2/clockdomain.c:93: undefined reference to `pwrdm_add_clkdm'
arch/arm/mach-omap2/built-in.o: In function `omap2_clk_disable_unused':
/local/linux-3.0/arch/arm/mach-omap2/clock.c:442: undefined reference to `pwrdm_clkdm_state_switch'
arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_infrastructure':
/local/linux-3.0/arch/arm/mach-omap2/io.c:355: undefined reference to `omap3xxx_voltagedomains_init'
/local/linux-3.0/arch/arm/mach-omap2/io.c:356: undefined reference to `omap3xxx_powerdomains_init'


Any ideas?  I'd like to keep my changes to the kernel to
a minimum,

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
