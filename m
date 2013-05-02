From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 08:38:34 -0700
Message-ID: <20130502153834.GR28721@atomide.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <20130502082218.GA21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55388 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3EBPio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 May 2013 11:38:44 -0400
Content-Disposition: inline
In-Reply-To: <20130502082218.GA21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Eduardo Valentin <eduardo.valentin@ti.com>, Neil Brown <neilb@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130502 01:27]:
> On Tue, Apr 30, 2013 at 09:17:39AM +0100, Russell King - ARM Linux wrote:
> > Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> > great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> > arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> > source of errors.
> > 
> > OMAP stuff needs a serious look at too - much Kconfig madness there
> > caused by over-use of select, which then goes on to cause build errors
> > because it assumes some stuff is always enabled.
> > 
> > There's also warnings about of_device_id from include/linux/of_platform.h
> > via from arch/arm/kernel/setup.c which feature in all the non-OF builds
> > too which need addressing.
> > 
> > See todays http://www.arm.linux.org.uk/developer/build/ results for all
> > the details and configs.  Not pushing my tree until some of this stuff
> > gets fixed.
> 
> And now we have a new bunch of warnings from OMAP stuff which weren't
> previously there...
> 
> arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_hwmod_name':
> arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes pointer from integer without a cast
> arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes pointer from integer without a cast

Hmm these I already fixed earlier along with a merge resolution, and
I'm not seeing them in next/master or arm-soc/for-next. What do you
have merged into your current tree?

> drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_usb':
> drivers/power/twl4030_charger.c:192:20: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result

Neil, care to provide a fix for this? It's from your commit ab37813
(twl4030_charger: Allow charger to control the regulator that feeds it).

> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event' defined but not used

Eduardo, can you fix that one? It seems to be from your commit 8ab3e6a
(thermal: Use thermal zone device id in netlink messages).

Regards,

Tony
