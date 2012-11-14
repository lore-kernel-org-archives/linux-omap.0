From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 17:42:11 +0000
Message-ID: <20121114174211.GB3332@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <50A3844B.8040208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42322 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028Ab2KNRmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 12:42:22 -0500
Content-Disposition: inline
In-Reply-To: <50A3844B.8040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 01:45:15PM +0200, Tomi Valkeinen wrote:
> On 2012-11-14 11:26, Russell King - ARM Linux wrote:
> > OMAP* allnoconfig fails:
> > 
> > arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
> > twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
> > arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
> > twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
> > arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> > twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
> > arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> > twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
> > arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> > twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
> > arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> > twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
> > arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> > twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'
> 
> I'm not able to reproduce this. I took v3.7-rc5, and the omap4430-sdp
> noconfig
> (http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2711),
> and it builds fine for me.

That's not the kernel it builds - it builds mainline + my kernel (which
is basically for-next + a few bits more) + arm-soc.

This error only just poped up, so I'm guessing there is a change in arm-soc
which has broken it.

> I see that arch/arm/plat-omap/omap-pm-noop.c is not compiled, which is
> where the above functions are. However, the config contains
> CONFIG_OMAP_PM_NOOP=y, which should cause omap-pm-noop.c to be compiled.

Suggest you retry with v3.7-rc5 + arm-soc.
