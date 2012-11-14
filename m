From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 09:17:31 -0800
Message-ID: <20121114171730.GS6801@atomide.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
 <50A3844B.8040208@ti.com>
 <20121114164801.GQ6801@atomide.com>
 <20121114165947.GR6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37483 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932188Ab2KNRRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 12:17:37 -0500
Content-Disposition: inline
In-Reply-To: <20121114165947.GR6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121114 09:02]:
> * Tony Lindgren <tony@atomide.com> [121114 08:50]:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [121114 03:47]:
> > > On 2012-11-14 11:26, Russell King - ARM Linux wrote:
> > > > OMAP* allnoconfig fails:
> > > > 
> > > > arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
> > > > twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
> > > > twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> > > > twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> > > > twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> > > > twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> > > > twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > > arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> > > > twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'
> > > 
> > > I'm not able to reproduce this. I took v3.7-rc5, and the omap4430-sdp
> > > noconfig
> > > (http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2711),
> > > and it builds fine for me.
> > 
> > It happens if in arm-soc/for-next and rmk/for-next. Looks like the
> > CONFIG_OMAP_PM_NOOP can't be under CONFIG_PM in the makefile where I moved it
> > in commit 6e740f9a8.
> 
> This should say just "It happens in arm-soc/for-next".
>  
> > Looks like in my test configs I run make oldnoconfig on Russell's seed
> > config, and I do get CONFIG_PM=y set while Russell's generated config
> > does not have that. No ideas yet why oldnoconfig add CONFIG_PM=y..

Looks like the way to do this not to use oldnoconfig but to do:

$ make KCONFIG_ALLCONFIG=../configs/rmk-omap4430-sdp-noconfig allnoconfig

It seems that oldnoconfig will pick the new options that have default y?

Regards,

Tony
