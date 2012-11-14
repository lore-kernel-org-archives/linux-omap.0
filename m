From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 08:59:48 -0800
Message-ID: <20121114165947.GR6801@atomide.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
 <50A3844B.8040208@ti.com>
 <20121114164801.GQ6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:51308 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754000Ab2KNQ7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 11:59:54 -0500
Content-Disposition: inline
In-Reply-To: <20121114164801.GQ6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121114 08:50]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121114 03:47]:
> > On 2012-11-14 11:26, Russell King - ARM Linux wrote:
> > > OMAP* allnoconfig fails:
> > > 
> > > arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
> > > twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
> > > arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
> > > twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
> > > arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> > > twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> > > twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> > > twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
> > > arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> > > twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> > > twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'
> > 
> > I'm not able to reproduce this. I took v3.7-rc5, and the omap4430-sdp
> > noconfig
> > (http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2711),
> > and it builds fine for me.
> 
> It happens if in arm-soc/for-next and rmk/for-next. Looks like the
> CONFIG_OMAP_PM_NOOP can't be under CONFIG_PM in the makefile where I moved it
> in commit 6e740f9a8.

This should say just "It happens in arm-soc/for-next".
 
> Looks like in my test configs I run make oldnoconfig on Russell's seed
> config, and I do get CONFIG_PM=y set while Russell's generated config
> does not have that. No ideas yet why oldnoconfig add CONFIG_PM=y..
> 
> Anyways, patch below to make it behave like earlier.
> 
> Regards,
> 
> Tony
> 
>  
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 14 Nov 2012 08:40:00 -0800
> Subject: [PATCH] ARM: OMAP: Fix compile for OMAP_PM_NOOP if PM is not selected
> 
> Commit 6e740f9a8 (ARM: OMAP: Move omap-pm-noop.c local to mach-omap2)
> moved omap-pm-noop to be local to mach-omap2. However, the makefile
> entry got placed within ifeq ($(CONFIG_PM),y) which was not the
> case earlier.
> 
> Fix the issue by moving it out of the ifeq ($(CONFIG_PM),y) in
> the makefile as these stubs are needed also when PM is not set.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -68,6 +68,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
>  endif
>  
>  # Power Management
> +obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
> +
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> @@ -75,7 +77,6 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> -obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
>  
>  obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>  obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
