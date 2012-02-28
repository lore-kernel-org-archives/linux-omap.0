From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
Date: Tue, 28 Feb 2012 15:48:37 -0800
Message-ID: <20120228234837.GH18901@atomide.com>
References: <4F4BB0FB.3040308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45840 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757421Ab2B1Xsk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 18:48:40 -0500
Content-Disposition: inline
In-Reply-To: <4F4BB0FB.3040308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

Hi,

* Cousson, Benoit <b-cousson@ti.com> [120227 08:04]:
> Hi Tony
> 
> This series is based on the lo/dt + the irqdomain/next branch merged on top of it.
> 
> Grant confirmed that the irqdomain/next is a stable branch and thus can be referenced for dependency.
> 
> Please note that I will need that branch to base all the remaining OMAP DT stuff.
> 
> Thanks,
> Benoit
> 
> 
> The following changes since commit 1f52299ec000e2161635b263d81ab92ea7f1f0a7:
>   Benoit Cousson (1):
>         Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 into for_3.4/dt_irq_domain2
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_irq_domain
> 
> Benoit Cousson (3):
>       ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
>       arm/dts: OMAP3: Add interrupt-controller bindings for INTC
>       ARM: OMAP2+: board-generic: Use of_irq_init API
> 
>  .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
>  arch/arm/boot/dts/omap3.dtsi                       |    6 +-
>  arch/arm/mach-omap2/board-generic.c                |   30 +++++-----
>  arch/arm/mach-omap2/common.h                       |   12 ++++
>  arch/arm/mach-omap2/irq.c                          |   60 ++++++++++++++++---
>  5 files changed, 109 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt

Hmm, looks like this now produces the following warning at least on omap3:

[    0.290832] WARNING: at drivers/mfd/twl4030-irq.c:645 twl4030_sih_setup+0x258/0x298()
[    0.290832] irq 428 for gpio too big
[    0.290863] Modules linked in:
[    0.290893] [<c001b5a8>] (unwind_backtrace+0x0/0xf0) from [<c0042c74>] (warn_slowpath_common+0x4c/0x64)
[    0.290954] [<c0042c74>] (warn_slowpath_common+0x4c/0x64) from [<c0042d20>] (warn_slowpath_fmt+0x30/0x40)
[    0.290985] [<c0042d20>] (warn_slowpath_fmt+0x30/0x40) from [<c02d21e4>] (twl4030_sih_setup+0x258/0x298)
[    0.291015] [<c02d21e4>] (twl4030_sih_setup+0x258/0x298) from [<c0469ae4>] (gpio_twl4030_probe+0x24/0x214)
[    0.291046] [<c0469ae4>] (gpio_twl4030_probe+0x24/0x214) from [<c02bece8>] (platform_drv_probe+0x18/0x1c)
[    0.291076] [<c02bece8>] (platform_drv_probe+0x18/0x1c) from [<c02bd7a0>] (really_probe+0x60/0x15c)
[    0.291107] [<c02bd7a0>] (really_probe+0x60/0x15c) from [<c02bd9e0>] (driver_probe_device+0x48/0x60)
[    0.291137] [<c02bd9e0>] (driver_probe_device+0x48/0x60) from [<c02bc198>] (bus_for_each_drv+0x5c/0x88)
[    0.291168] [<c02bc198>] (bus_for_each_drv+0x5c/0x88) from [<c02bd958>] (device_attach+0x98/0xbc)
[    0.291198] [<c02bd958>] (device_attach+0x98/0xbc) from [<c02bcf9c>] (bus_probe_device+0x88/0xac)
[    0.291229] [<c02bcf9c>] (bus_probe_device+0x88/0xac) from [<c02bb814>] (device_add+0x278/0x358)
[    0.291259] [<c02bb814>] (device_add+0x278/0x358) from [<c02bf214>] (platform_device_add+0xf8/0x228)
[    0.291290] [<c02bf214>] (platform_device_add+0xf8/0x228) from [<c047e394>] (add_numbered_child.constprop.0+0xb8/0xfc)
[    0.291320] [<c047e394>] (add_numbered_child.constprop.0+0xb8/0xfc) from [<c047e474>] (add_children+0x44/0x658)
[    0.291351] [<c047e474>] (add_children+0x44/0x658) from [<c046ac6c>] (twl_probe+0x354/0x3bc)
[    0.291381] [<c046ac6c>] (twl_probe+0x354/0x3bc) from [<c036e364>] (i2c_device_probe+0xc0/0x100)
[    0.291412] [<c036e364>] (i2c_device_probe+0xc0/0x100) from [<c02bd7a0>] (really_probe+0x60/0x15c)
[    0.291442] [<c02bd7a0>] (really_probe+0x60/0x15c) from [<c02bd9e0>] (driver_probe_device+0x48/0x60)
[    0.291473] [<c02bd9e0>] (driver_probe_device+0x48/0x60) from [<c02bc198>] (bus_for_each_drv+0x5c/0x88)
[    0.291503] [<c02bc198>] (bus_for_each_drv+0x5c/0x88) from [<c02bd958>] (device_attach+0x98/0xbc)
[    0.291503] [<c02bd958>] (device_attach+0x98/0xbc) from [<c02bcf9c>] (bus_probe_device+0x88/0xac)
[    0.291534] [<c02bcf9c>] (bus_probe_device+0x88/0xac) from [<c02bb814>] (device_add+0x278/0x358)
[    0.291564] [<c02bb814>] (device_add+0x278/0x358) from [<c036eac4>] (i2c_new_device+0xec/0x164)
[    0.291595] [<c036eac4>] (i2c_new_device+0xec/0x164) from [<c036eed4>] (i2c_register_adapter+0x168/0x220)
[    0.291625] [<c036eed4>] (i2c_register_adapter+0x168/0x220) from [<c036f0f8>] (i2c_add_numbered_adapter+0xd4/0xf0)
[    0.291656] [<c036f0f8>] (i2c_add_numbered_adapter+0xd4/0xf0) from [<c046f8b8>] (omap_i2c_probe+0x33c/0x428)
[    0.291687] [<c046f8b8>] (omap_i2c_probe+0x33c/0x428) from [<c02bece8>] (platform_drv_probe+0x18/0x1c)
[    0.291717] [<c02bece8>] (platform_drv_probe+0x18/0x1c) from [<c02bd7a0>] (really_probe+0x60/0x15c)
[    0.291748] [<c02bd7a0>] (really_probe+0x60/0x15c) from [<c02bd9e0>] (driver_probe_device+0x48/0x60)
[    0.291778] [<c02bd9e0>] (driver_probe_device+0x48/0x60) from [<c02bda8c>] (__driver_attach+0x94/0x98)
[    0.291809] [<c02bda8c>] (__driver_attach+0x94/0x98) from [<c02bc214>] (bus_for_each_dev+0x50/0x7c)
[    0.291839] [<c02bc214>] (bus_for_each_dev+0x50/0x7c) from [<c02bd2a0>] (bus_add_driver+0x1f4/0x2b8)
[    0.291870] [<c02bd2a0>] (bus_add_driver+0x1f4/0x2b8) from [<c02bdf5c>] (driver_register+0x78/0x17c)
[    0.291900] [<c02bdf5c>] (driver_register+0x78/0x17c) from [<c0008630>] (do_one_initcall+0x34/0x178)
[    0.291931] [<c0008630>] (do_one_initcall+0x34/0x178) from [<c06458ac>] (kernel_init+0x8c/0x12c)
[    0.291961] [<c06458ac>] (kernel_init+0x8c/0x12c) from [<c0014d68>] (kernel_thread_exit+0x0/0x8)

Regards,

Tony
