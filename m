From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP* Latest build failures
Date: Sat, 17 Nov 2012 09:33:07 +0000
Message-ID: <20121117093307.GL3332@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44239 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2KQJdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Nov 2012 04:33:17 -0500
Content-Disposition: inline
In-Reply-To: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 09:26:43AM +0000, Russell King - ARM Linux wrote:
> OMAP* allnoconfig fails:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'

These are now gone, but we have a new warning:

arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used

And the randconfig found:

drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_readl':
drivers/staging/omap-thermal/omap-bandgap.c:46:2: error: implicit declaration of function 'readl'
drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_writel':
drivers/staging/omap-thermal/omap-bandgap.c:51:2: error: implicit declaration of function 'writel'

Which, as its in staging, maybe its not important but it's another source
of unnecessary failure.
