From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 10:35:00 +0000
Message-ID: <20121114103500.GA3332@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <50A36DA3.2080201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42046 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab2KNKgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 05:36:06 -0500
Content-Disposition: inline
In-Reply-To: <50A36DA3.2080201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 11:08:35AM +0100, Peter Ujfalusi wrote:
> Hi Russell,
> 
> On 11/14/2012 10:26 AM, Russell King - ARM Linux wrote:
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
> Not sure what is going on here but neither of these are referenced within
> twl-common.c directly.

You can't rely on the .c file issued by the linker.  omap_display_init()
is not in twl-common.c, but is in arch/arm/mach-omap2/display.c.  So
ignore the "twl-common.c".

> > OMAP4 randconfig fails:
> > 
> > arch/arm/mach-omap2/cm_common.c: In function 'cm_register':
> > arch/arm/mach-omap2/cm_common.c:42:11: error: 'EINVAL' undeclared (first use in this function)
> > arch/arm/mach-omap2/cm_common.c:45:11: error: 'EEXIST' undeclared (first use in this function)
> > arch/arm/mach-omap2/cm_common.c: In function 'cm_unregister':
> > arch/arm/mach-omap2/cm_common.c:66:11: error: 'EINVAL' undeclared (first use in this function)
> 
> I have already sent a patch to fix this:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/131341.html
> 
> > You know where to find the build information and results...
> 
> It seams I can not find the link in my mail archives. Could you point me to
> the correct place?

http://www.arm.linux.org.uk/developer/build/
